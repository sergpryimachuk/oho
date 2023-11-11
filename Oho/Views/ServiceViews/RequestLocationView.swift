import CoreLocationUI
import SwiftUI

struct RequestLocationView: View {
    @AppStorage("isOnboarding") var isOnboarding: Bool?

    @ObservedObject var locationManager: LocationManager

    @State private var isTextTapped = false
    @State private var displayedText = "Для отримання актуальної п***ди потрібне ваше місцезнаходження."
    private let initialPromt = "Дозвольте доступ до вашого місцезнаходження."
    private let deniedPromt = "Ви заборонили доступ до вашого місцезнаходження.\n\nДозвольте в налатуваннях."
    private let restrictedPromt = "Вам заборонено ділитися місцезнаходженням\n\nЗапитайте дозволу в батьків."
    private let buttonSymbol = "location.fill"
    private let buttonSymbolSettings = "gear"
    private let initialButton = "Дозволяю"
    private let settingsButton = "Перейти в налаштування"
    private let text = "Для отримання актуальної п***ди потрібне ваше місцезнаходження."
    private let generator = UINotificationFeedbackGenerator()

    var body: some View {
        ZStack {
            Rectangle()
                .background(.ultraThinMaterial)
                .opacity(0.01)
                .ignoresSafeArea()
                .onTapGesture {
                    removeAsterisk()
                }

            VStack {
                Spacer()

                Image(systemName: "location.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .opacity(0.8)
                    .frame(width: 100)
                    .padding(.bottom, 20)

                VStack(alignment: .leading, spacing: 30) {
                    Text(displayedText)

                    switch locationManager.authorizationStatus {
                    case .denied:
                        Text(deniedPromt)
                    case .restricted:
                        Text(restrictedPromt)
                    case .notDetermined:
                        Text(initialPromt)
                    default:
                        Text(initialPromt)
                    }
                }
                .onboardingTextStyle()

                Spacer()

                Button {
                    switch locationManager.authorizationStatus {
                    case .notDetermined:
                        removeAsterisk()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            locationManager.requestLocation()
                            isOnboarding = false
                        }
                    default:
                        Task {
                            if let url = URL(string: UIApplication.openSettingsURLString) {
                                await UIApplication.shared.open(url)
                            }
                        }
                    }
                    generator.notificationOccurred(.warning)
                } label: {
                    HStack {
                        Group {
                            switch locationManager.authorizationStatus {
                            case .denied, .restricted:
                                Image(systemName: buttonSymbolSettings)
                                Text(settingsButton)
                                    .padding()
                            case .notDetermined:
                                Image(systemName: buttonSymbol)
                                    .padding()
                                Text(initialButton)
                                    .padding()
                                    .padding(.leading, -30)
                            default:
                                Text(initialPromt)
                                    .padding()
                            }
                        }
                        .minorTextStyle()
                    }
                }
                .serviceButtonStyle()
            }
            .animation(.spring(), value: displayedText)
        }
    }

    func removeAsterisk() {
        if displayedText.contains("п***д") {
            let newLyric = displayedText.replacingOccurrences(of: "п***д", with: "погод")
            displayedText = newLyric
            generator.notificationOccurred(.success)
            return
        } else if displayedText.contains("погод") {
            let newLyric = displayedText.replacingOccurrences(of: "погод", with: "п***д")
            displayedText = newLyric
            generator.notificationOccurred(.success)
            return
        } else {
            generator.notificationOccurred(.error)
        }
    }
}

struct RequestLocationView_Previews: PreviewProvider {
    static var previews: some View {
        RequestLocationView(locationManager: LocationManager())
            .environmentObject(LocationManager())
            .preferredColorScheme(.dark)
    }
}
