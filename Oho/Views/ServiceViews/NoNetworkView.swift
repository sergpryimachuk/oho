import SwiftUI

struct NoNetworkView: View {
    @State private var isTextTapped = false
    @State private var displayedText = "\n\nТому ми не можемо показати вам п***ду.\n\n"
    @State private var reason = "Немає доступу до мережі."
    @State private var prompt = "Увімкніть стільникові дані або Wi-Fi."
    @State private var buttonSymbol = "gear"
    @State private var buttonText = "Перейти в налаштування"

    let text = "\n\nТому ми не можемо показати вам погоду.\n\n"

    var body: some View {
        VStack {
            Spacer()

            Image(systemName: "wifi.slash")
                .resizable()
                .scaledToFit()
                .foregroundColor(.white)
                .opacity(0.8)
                .frame(width: 100)
                .padding(.bottom, 20)

            VStack(alignment: .leading, spacing: -30) {
                Text(reason)
                Text(displayedText)
                Text(prompt)
            }
            .mainTextStyle()
            .padding()
            .onTapGesture {
                removeAsterisks()
            }

            Spacer()

            Button {
                Task {
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        await UIApplication.shared.open(url)
                    }
                }
            } label: {
                HStack {
                    Group {
                        Image(systemName: buttonSymbol)
                        Text(buttonText)
                    }
                    .minorTextStyle()
                }
            }
            .serviceButtonStyle()
        }
        .animation(.spring(), value: displayedText)
    }

    func removeAsterisks() {
        if isTextTapped {
            displayedText = text
            isTextTapped = false
        } else {
            displayedText = "\n\nТому ми не можемо показати вам п***ду.\n\n"
            isTextTapped = true
        }
    }
}

struct NoNetworkView_Previews: PreviewProvider {
    static var previews: some View {
        NoNetworkView()
            .preferredColorScheme(.dark)
    }
}
