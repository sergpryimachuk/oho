import SwiftUI

enum WeatherFor: String {
    case now, later, morning, afternoon
}

struct WeatherView: View {
    @StateObject private var vm = WeatherViewModel()
    @State private var isEyeTapped = false
    @State private var isTextTapped = false
    @State private var lyric = "Якась п***да."

    var weatherFor: WeatherFor
    @Binding var refresh: Bool
    @Binding var removeAsteriks: Bool

    var whenStr: String {
        switch weatherFor {
        case .now:
            return "Зараз"
        case .later:
            return "Потім"
        case .morning:
            return "Зранку"
        case .afternoon:
            return "Після обіду"
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            HStack {
                Text(whenStr)
                    .minorTextStyle()

                Spacer()

                Button {
                    isEyeTapped.toggle()
                } label: {
                    Image(systemName: isEyeTapped ? "eye.slash" : "eye")
                        .frame(width: 44, height: 44)
                }
            }
            .foregroundColor(.white)
            .opacity(0.8)
            .padding(.top, 50)

            VStack {
                if isEyeTapped {
                    Text("\(vm.getTemp(for: weatherFor))° і \(vm.getDescription(for: weatherFor)).")
                        .mainTextStyle()
                } else {
                    Text(vm.lyric ?? "Якась п***да.")
                        .mainTextStyle()
                        .onTapGesture {
                            if isTextTapped {
                                vm.removeAsterisk()
                                isTextTapped.toggle()
                            } else {
                                vm.removeAsterisk()
                                isTextTapped.toggle()
                            }
                        }
                }
            }
        }
        .padding()
        .onChange(of: refresh) { _ in
            vm.getLyric(for: weatherFor)
            isEyeTapped = false
        }
        .onChange(of: removeAsteriks) { _ in
            isEyeTapped = false
            vm.removeAsterisk()
        }
        .animation(.spring(response: 0.5), value: isEyeTapped)
        .animation(.spring(response: 1), value: isTextTapped)
        .animation(.spring(response: 1), value: vm.lyric)
        .onAppear {
            vm.getLyric(for: weatherFor)
            isEyeTapped = false
        }
    }
}

struct DescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weatherFor: .now, refresh: .constant(true), removeAsteriks: .constant(false))
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
