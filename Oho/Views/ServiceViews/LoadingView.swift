import SwiftUI

struct LoadingView: View {
    @State private var isTextTapped = false
    @State private var displayedText = "Завантажуємо п***ду."
    let text = "Завантажуємо п***ду."

    var body: some View {
        ZStack {
            Rectangle()
                .fill(.ultraThinMaterial)
                .opacity(0.01)
                .ignoresSafeArea()
                .onTapGesture { removeAsterisks() }

            HStack {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                Text(displayedText)
                    .minorTextStyle()
                    .padding()
            }
        }
        .animation(.spring(), value: displayedText)
    }

    func removeAsterisks() {
        if isTextTapped {
            displayedText = text.replacingOccurrences(of: "***", with: "ого")
            isTextTapped = false
        } else {
            displayedText = text.replacingOccurrences(of: "ого", with: "***")
            isTextTapped = true
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
            .preferredColorScheme(.dark)
    }
}
