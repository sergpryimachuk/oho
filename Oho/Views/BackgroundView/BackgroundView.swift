import FluidGradient
import SwiftUI

struct BackgroundView: View {
    @StateObject var vm = BackgroundViewModel()
    @Binding var colorsFor: Tab

    var body: some View {
        FluidGradient(blobs: vm.getBlobs(for: colorsFor),
                      highlights: vm.getHighlights(for: colorsFor),
                      speed: vm.getWind(for: colorsFor))
            .background(.quaternary)
            .ignoresSafeArea()
            .animation(.spring().speed(0.3), value: colorsFor)
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView(colorsFor: .constant(.none))
    }
}
