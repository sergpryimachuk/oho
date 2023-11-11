import CoreLocation
import FluidGradient
import SwiftUI

enum Tab: String, Equatable {
    case today, tomorrow, none
}

struct MainView: View {
    @AppStorage("isOnboarding") var isOnboarding = true

    @StateObject var networkManager = NetworkManager()
    @StateObject var locationManager = LocationManager()
    @StateObject var vm = MainViewModel()
    @State private var selectedTab: Tab = .none
    @State private var refresh = false
    @State private var removeAsteriks = false

    var body: some View {
        ZStack {
            BackgroundView(colorsFor: vm.isLoading ? .constant(.none) : $selectedTab)
                .onAppear { locationManager.authorizationStatus == .authorizedWhenInUse ? locationManager.requestLocation() : () }

            if !isOnboarding {
                if networkManager.isConnected {
                    if let coordinate = locationManager.userLocation?.coordinate {
                        if vm.isLoading {
                            LoadingView()
                                .task { await vm.getWeatherData(for: coordinate) }
                        } else {
                            VStack {
                                CustomButtons(tab: $selectedTab)
                                TabView(selection: $selectedTab) {
                                    ScrollView {
                                        VStack {
                                            WeatherView(weatherFor: .now, refresh: $refresh, removeAsteriks: $removeAsteriks)
                                            WeatherView(weatherFor: .later, refresh: $refresh, removeAsteriks: $removeAsteriks)
                                        }
                                    }
                                    .refreshable { refresh.toggle() }
                                    .tag(Tab.today)

                                    ScrollView {
                                        VStack {
                                            WeatherView(weatherFor: .morning, refresh: $refresh, removeAsteriks: $removeAsteriks)
                                            WeatherView(weatherFor: .afternoon, refresh: $refresh, removeAsteriks: $removeAsteriks)
                                        }
                                    }
                                    .refreshable { refresh.toggle() }
                                    .tag(Tab.tomorrow)
                                }
                                .tabViewStyle(.page(indexDisplayMode: .never))

                                Button {
                                    removeAsteriks.toggle()
                                } label: {
                                    Text("*ого")
                                        .minorTextStyle()
                                        .padding()
                                }
                                .serviceButtonStyle()

                                Spacer()
                            }
                            .onAppear { selectedTab = .today }
                        }
                    } else {
                        RequestLocationView(locationManager: locationManager)
                    }
                } else {
                    NoNetworkView()
                }
            } else {
                LoadingView()
            }
        }
        .animation(.spring(response: 1), value: selectedTab)
        .sheet(isPresented: $isOnboarding) {
            OnboardingView(locationManager: locationManager)
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .preferredColorScheme(.light)
    }
}
