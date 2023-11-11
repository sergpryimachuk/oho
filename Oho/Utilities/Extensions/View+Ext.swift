import SwiftUI

// MARK: - Text modifiers

extension View {
    func mainTextStyle() -> some View {
        modifier(Main())
    }

    func minorTextStyle() -> some View {
        modifier(Minor())
    }

    func onboardingTextStyle() -> some View {
        modifier(Onboarding())
    }
}

private struct Main: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("e-Ukraine-Bold", size: 22, relativeTo: .headline))
            .shadow(radius: 0.1)
            .foregroundColor(.white)
            .opacity(0.8)
    }
}

private struct Minor: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("e-Ukraine-Bold", size: 16, relativeTo: .body))
            .shadow(radius: 0.1)
            .foregroundColor(.white)
            .opacity(0.8)
    }
}

private struct Onboarding: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("e-Ukraine-Bold", size: 18, relativeTo: .body))
            .shadow(radius: 0.1)
            .foregroundColor(.white)
            .opacity(0.8)
    }
}

// MARK: - Button modifiers

extension View {
    func serviceButtonStyle() -> some View {
        modifier(Service())
    }
}

private struct Service: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .padding(.bottom)
    }
}
