import SwiftUI

struct PageOneView: View {
    @State private var animatedText = "Ласкаво просимо до *ого, \nдодатку п***ди*."
    private let pageContent: OnboardingContent = .init(systemImage: "cloud.fill", text: [
        "*ого це нагадування про упередженість наших думок.",
        "Три маленькі зірочки здатні змінити наше сприйняття.",
    ])
    private let generator = UINotificationFeedbackGenerator()

    @Binding var tab: Int

    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            Spacer()
            Spacer()

            if pageContent.systemImage.isEmpty {
                // Don't show anything
            } else {
                Image(systemName: pageContent.systemImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 100, minHeight: 100)
                    .foregroundColor(.pinky)
                    .opacity(0.8)
            }

            VStack(alignment: .leading, spacing: 30) {
                Text(animatedText)
                ForEach(pageContent.text, id: \.self) { Text($0) }
            }
            .onboardingTextStyle()

            Spacer()

            Button {
                removeAsteriks()
                generator.notificationOccurred(.success)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    tab = 2
                }
            } label: {
                Text("*ого")
                    .minorTextStyle()
                    .padding()
            }
            .serviceButtonStyle()
        }
        .padding()
        .animation(.spring(response: 0.5), value: animatedText)
    }

    func removeAsteriks() {
        let newText = animatedText.replacingOccurrences(of: "п***ди*", with: "погоди")
        animatedText = newText
    }
}

struct PageOneView_Previews: PreviewProvider {
    static var previews: some View {
        PageOneView(tab: .constant(1))
            .preferredColorScheme(.dark)
    }
}
