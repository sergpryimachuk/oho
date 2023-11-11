import SwiftUI

struct CustomButtons: View {
    @Binding var tab: Tab

    var body: some View {
        VStack {
            HStack {
                ZStack {
                    Text("Сьогодні")
                        .minorTextStyle()
                        .padding(.horizontal, 25)
                        .padding(.vertical)
                        .background(.ultraThinMaterial.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .opacity(tab == .today ? 0 : 1)
                        .onTapGesture { tab = .today }

                    Button {
                        tab = .today
                    } label: {
                        Text("Сьогодні")
                            .minorTextStyle()
                            .padding(.horizontal, 10)
                            .padding()
                    }
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .opacity(tab == .today ? 1 : 0)
                }

                ZStack {
                    Text("Завтра")
                        .minorTextStyle()
                        .padding(.horizontal, 35)
                        .padding(.vertical)
                        .background(.ultraThinMaterial.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .opacity(tab == .tomorrow ? 0 : 1)
                        .onTapGesture { tab = .tomorrow }

                    Button {
                        tab = .tomorrow
                    } label: {
                        Text("Завтра")
                            .minorTextStyle()
                            .padding(.horizontal, 35)
                            .padding(.vertical)
                    }
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .opacity(tab == .tomorrow ? 1 : 0)
                }
            }

//            HStack {
//                Button {
//                    tab = .today
//                } label: {
//                    ZStack {
//                        Text("Сьогодні")
//                            .minorTextStyle()
//
//                        Text("Сьогодні")
//                            .minorTextStyle()
//                            .frame(width: 120, height: 5)
//                            .padding(.vertical, 20)
//                            .background(.ultraThinMaterial)
//                            .opacity(tab == .today ? 0.8 : 0)
//                            .clipShape(RoundedRectangle(cornerRadius: 10))
//                    }
//                }
//
//                Button {
//                    tab = .tomorrow
//                } label: {
//                    ZStack {
//                        Text("Завтра")
//                            .minorTextStyle()
//
//                        Text("Завтра")
//                            .minorTextStyle()
//                            .frame(width: 120, height: 5)
//                            .padding(.vertical, 20)
//                            .background(.ultraThinMaterial)
//                            .opacity(tab == .tomorrow ? 0.8 : 0)
//                            .clipShape(RoundedRectangle(cornerRadius: 10))
//                    }
//                }
//            }
            .padding(.top, 50)
            .animation(.spring().speed(0.3), value: tab)
        }
    }
}

struct CustomButtons_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.pinky)

            CustomButtons(tab: .constant(.today))
                .preferredColorScheme(.light)
        }
    }
}
