import Moya
import Domain
import Foundation

public final class MainViewModel: ObservableObject {
    private let authProvider = MoyaProvider<MainAPI>()
    private var accessToken: String = UserDefaults.standard.string(forKey: "accessToken") ?? ""

    @Published public var allPostList: [Post] = []
    @Published public var gymPostList: [Post] = []
    @Published public var homePostList: [Post] = []
    @Published public var playgroundPostList: [Post] = []
    @Published public var domitoryPostList: [Post] = []
    @Published public var walkingTrailPostList: [Post] = []

    @MainActor
    public func fetchAllPostList() {
        authProvider.request(.fetchAllPostList(authorization: accessToken)) { result in
            switch result {
            case let .success(res):
                do {
                    if let responseString = String(data: res.data, encoding: .utf8) {
                        print("서버 응답 데이터: \(responseString)")
                    }
                    let responseModel = try JSONDecoder().decode([Post].self, from: res.data)
                    self.allPostList = responseModel
                    print("성공ㅣ전체 게시물 불러오기")
                } catch {
                    print("JSON 디코딩 에러: \(error)")
                }
            case let .failure(err):
                print("Network request failed: \(err)")
            }
        }
    }
}
