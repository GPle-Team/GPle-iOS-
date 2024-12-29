import SwiftUI

struct SplashView: View {
    @State private var isActive = false

    var body: some View {
        ZStack {
            if isActive {
                MainView(viewModel: MainViewModel(), postViewModel: PostViewModel())
                    .transition(.opacity) // 페이드 효과
            } else {
                ZStack {
                    GPleAsset.Color.back.swiftUIColor
                        .ignoresSafeArea()

                    VStack {
                        GPleAsset.Assets.gpleBigLogo.swiftUIImage
                            .resizable()
                            .frame(width: 160, height: 70)
                    }
                }
                .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 1), value: isActive)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    isActive = true
                }
            }
        }
    }
}
