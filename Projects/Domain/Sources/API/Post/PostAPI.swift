import Foundation
import Moya

public enum PostAPI {
    case createPost(param: CreatePostRequest, authorization: String)
    case uploadImage(files: [Data], authorization: String)
    case allUserList(authorization: String)
    case myPostList(authorization: String)
    case myReactionPostList(authorization: String)
}

extension PostAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "https://port-0-gple-backend-eg4e2alkoplc4q.sel4.cloudtype.app")!
    }

    public var path: String {
        switch self {
        case .createPost:
            return "/post"
        case .uploadImage:
            return "/file/images"
        case .allUserList:
            return "/user"
        case .myPostList:
            return "/post/my"
        case .myReactionPostList:
            return "/post/react"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .createPost, .uploadImage:
            return .post
        case .allUserList, .myPostList, .myReactionPostList:
            return .get
        }
    }

    public var sampleData: Data {
        return "{}".data(using: .utf8)!
    }

    public var task: Task {
        switch self {
        case .createPost(let param, _):
            return .requestJSONEncodable(param)
        case .uploadImage(let files, _):
            let formData = files.map { fileData in
                MultipartFormData(provider: .data(fileData), name: "files", fileName: "image.jpg", mimeType: "image/jpeg")
            }
            return .uploadMultipart(formData)
        case .allUserList, .myPostList, .myReactionPostList:
            return .requestPlain
        }
    }

    public var headers: [String : String]? {
        switch self {
        case .createPost(_, let authorization), .uploadImage(_, let authorization), .allUserList(let authorization), .myPostList(let authorization), .myReactionPostList(let authorization):
            return ["Authorization": authorization]
        }
    }
}
