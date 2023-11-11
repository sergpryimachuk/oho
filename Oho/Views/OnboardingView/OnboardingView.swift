import SwiftUI

struct OnboardingView: View {
    @ObservedObject var locationManager: LocationManager
    @State private var tab = 1

    var body: some View {
        VStack {
            TabView(selection: $tab) {
                PageOneView(tab: $tab)
                    .padding(.bottom, 50)
                    .tag(1)

                PageTwoView(tab: $tab)
                    .padding(.bottom, 50)
                    .tag(2)

                PageThreeView(tab: $tab)
                    .padding(.bottom, 50)
                    .tag(3)

                RequestLocationView(locationManager: locationManager)
                    .padding(.bottom, 50)
                    .tag(4)
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .presentationBackground(.ultraThinMaterial)
        }
        .animation(.spring(response: 1), value: tab)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(locationManager: LocationManager())
            .preferredColorScheme(.dark)
    }
}

struct OnboardingContent: Hashable {
    let systemImage: String
    var text: [String]
}
