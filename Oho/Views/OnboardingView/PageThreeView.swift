import SwiftUI

struct PageThreeView: View {
    let pageContent: OnboardingContent = .init(systemImage: "asterisk", text: [
        "Перш ніж робити висновки.",
        "Шукайте виноски.*",
    ])
    private let generator = UINotificationFeedbackGenerator()

    @Binding var tab: Int

    var body: some View {
        VStack(alignment: .center, spacing: 50) {
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

            VStack(alignment: .leading, spacing: 30) { ForEach(pageContent.text, id: \.self) { Text($0) }.mainTextStyle() }

            Spacer()

            Button {
                tab = 4
                generator.notificationOccurred(.success)
            } label: {
                Text("*ого")
                    .minorTextStyle()
                    .padding()
            }
            .serviceButtonStyle()
        }
    }
}

struct PageThreeView_Previews: PreviewProvider {
    static var previews: some View {
        PageThreeView(tab: .constant(1))
            .preferredColorScheme(.dark)
    }
}
