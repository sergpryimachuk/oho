import SwiftUI

struct PageTwoView: View {
    @State private var pageContent: OnboardingContent = .init(
        systemImage: "exclamationmark.triangle.fill",
        text: [
            "Цей додаток це маніфест.",
            "Нагадування про те, що ми всі упереджені.",
            "Кожен бачить те, що хоче.",
            "Ми мали на увазі погода.",
            "А ви?",
        ]
    )
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
                    .foregroundColor(.white)
                    .opacity(0.8)
            }

            VStack(alignment: .leading, spacing: 30) {
                ForEach(pageContent.text, id: \.self) { Text($0) }.onboardingTextStyle()
            }

            Spacer()

            if tab != 4 {
                Button {
                    removeAsteriks()
                    generator.notificationOccurred(.success)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        tab = 3
                    }
                } label: {
                    Text("*ого")
                        .minorTextStyle()
                        .padding()
                }
                .serviceButtonStyle()
            }
        }
        .padding()
    }

    func removeAsteriks() {
        let newText = pageContent.text[3].replacingOccurrences(of: "ого", with: "***")
        pageContent.text[3] = newText
        generator.notificationOccurred(.success)
    }
}

struct PageTwoView_Previews: PreviewProvider {
    static var previews: some View {
        PageTwoView(tab: .constant(1))
            .preferredColorScheme(.dark)
    }
}
