import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    @StateObject var postViewModel: PostViewModel
    @State private var selectedIndex = 0

    var body: some View {
        NavigationView {
            NavigationStack {
                ZStack {
                    GPleAsset.Color.back.swiftUIColor
                        .ignoresSafeArea()

                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 0) {
                            HStack(spacing: 0) {
                                GPleAsset.Assets.gpleBigLogo.swiftUIImage
                                    .padding(.leading, 20)

                                Spacer()

                                NavigationLink(destination:
                                                MyPageView(
                                                    postViewModel: PostViewModel())) {
                                                        GPleAsset.Assets.profile.swiftUIImage
                                                            .padding(.trailing, 20)
                                                    }
                            }
                            .padding(.top, 16)

                            NavigationLink(destination: LocationPostView(viewModel: LocationPostViewModel(), locationType: "WALKING_TRAIL")) {
                                GPleAsset.Assets.backyard.swiftUIImage
                                    .padding(.top, 61)
                            }

                            NavigationLink(destination: LocationPostView(viewModel: LocationPostViewModel(), locationType: "HOME")) {
                                GPleAsset.Assets.bongwan.swiftUIImage
                                    .padding(.top, 6)
                            }

                            HStack(spacing: 13) {
                                NavigationLink(destination: LocationPostView(viewModel: LocationPostViewModel(), locationType: "GYM")) {
                                    GPleAsset.Assets.geumbongGwan.swiftUIImage
                                }

                                NavigationLink(destination: LocationPostView(viewModel: LocationPostViewModel(), locationType: "PLAYGROUND")) {
                                    GPleAsset.Assets.playground.swiftUIImage
                                }

                                NavigationLink(destination: LocationPostView(viewModel: LocationPostViewModel(), locationType: "DOMITORY")) {
                                    GPleAsset.Assets.dongHaengGwan.swiftUIImage
                                }
                            }
                            .padding(.top, 8)

                            HStack(spacing: 36) {
                                NavigationLink(destination: RankView(postViewModel: PostViewModel())) {
                                    rankButton()
                                }

                                NavigationLink(destination: PostCreateView(viewModel: PostViewModel())) {
                                    imageUploadButton()
                                }

                            }
                            .padding(.top, 16)

                            ForEach(viewModel.allPostList) { post in
                                NavigationLink(destination: DetailView(
                                    postViewModel: PostViewModel(),
                                    postId: post.id,
                                    location: post.location,
                                    title: post.title,
                                    name: post.author.name,
                                    grade: post.author.grade,
                                    imageUrl: post.imageUrl,
                                    tagList: post.tagList.map { ($0.name, $0.id) },
                                    emojiList: [
                                        post.emojiList.heartCount,
                                        post.emojiList.congCount,
                                        post.emojiList.thumbsCount,
                                        post.emojiList.thinkCount,
                                        post.emojiList.poopCount,
                                        post.emojiList.chinaCount
                                    ],
                                    checkEmojiList: post.checkEmoji,
                                    createTime: post.createdTime
                                )) {
                                    postList(
                                        name: post.author.name,
                                        grade: post.author.grade,
                                        title: post.title,
                                        place: post.location,
                                        tag: post.tagList.map { $0.name },
                                        date: post.createdTime,
                                        imageURL: post.imageUrl
                                    )
                                }
                            }
                            .padding(.top, 60)

                            Spacer()
                        }
                    }
                    .onAppear {
                        viewModel.fetchAllPostList()
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    @ViewBuilder
    func rankButton() -> some View {
        HStack {
            GPleAsset.Assets.chart.swiftUIImage

            Text("인기 순위")
                .foregroundStyle(GPleAsset.Color.white.swiftUIColor)
        }
        .padding(.all, 12)
        .background(GPleAsset.Color.gray1000.swiftUIColor)
        .cornerRadius(8)
    }

    @ViewBuilder
    func imageUploadButton() -> some View {
        HStack {
            GPleAsset.Assets.download.swiftUIImage

            Text("사진 업로드")
                .foregroundStyle(GPleAsset.Color.white.swiftUIColor)
        }
        .padding(.all, 12)
        .background(GPleAsset.Color.gray1000.swiftUIColor)
        .cornerRadius(8)
    }

    @ViewBuilder
    func postList(
        name: String,
        grade: Int,
        title: String,
        place: String,
        tag: [String],
        date: String,
        imageURL: [String]
    ) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 4) {
                GPleAsset.Assets.profile.swiftUIImage

                Text(name)
                    .foregroundStyle(GPleAsset.Color.white.swiftUIColor)
                    .font(GPleFontFamily.Pretendard.semiBold.swiftUIFont(size: 16))
                    .padding(.leading, 4)

                Text("•")
                    .foregroundStyle(GPleAsset.Color.gray800.swiftUIColor)

                HStack(spacing: 0) {
                    Text("\(grade)")

                    Text("학년")
                }
                .foregroundStyle(GPleAsset.Color.gray800.swiftUIColor)
                .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 14))
            }
            .padding(.leading, 8)

            Text(title)
                .foregroundStyle(GPleAsset.Color.white.swiftUIColor)
                .font(GPleFontFamily.Pretendard.semiBold.swiftUIFont(size: 18))
                .padding(.top, 16)
                .padding(.leading, 8)

            Text(place)
                .foregroundStyle(GPleAsset.Color.gray600.swiftUIColor)
                .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 14))
                .padding(.top, 4)
                .padding(.leading, 8)

            TabView(selection: $selectedIndex) {
                ForEach(imageURL.indices, id: \.self) { index in
                    if let imageUrl = URL(string: imageURL[index]) {
                        AsyncImage(url: imageUrl) { image in
                            image
                                .resizable()
                                .padding(.top, 12)
                        } placeholder: {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                        }
                        .tag(index)
                    }
                }
            }
            .padding(.horizontal, 8)
            .frame(height: 381)
            .tabViewStyle(.page)
            .padding(.top, 16)

            HStack(spacing: 8) {
                ForEach(tag, id: \.self) { tag in
                    HStack(spacing: 0) {
                        Text("@")

                        Text(tag)
                    }
                }
            }
            .foregroundStyle(GPleAsset.Color.gray600.swiftUIColor)
            .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 14))
            .padding(.top, 12)
            .padding(.leading, 8)

            let dateString = date.split(separator: "T").first
            if let dateString = dateString {
                let components = dateString.split(separator: "-")
                if components.count >= 3 {
                    var month = String(components[1])
                    var day = String(components[2])

                    Text("\(month)월 \(day)일")
                        .foregroundStyle(GPleAsset.Color.gray800.swiftUIColor)
                        .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 14))
                        .padding(.top, 6)
                        .padding(.leading, 8)
                }
            }

        }
        .padding(.horizontal, 10)
        .padding(.vertical, 20)
        .background(GPleAsset.Color.gray1000.swiftUIColor)
        .cornerRadius(12)
        .padding(.horizontal, 20)
    }
}
