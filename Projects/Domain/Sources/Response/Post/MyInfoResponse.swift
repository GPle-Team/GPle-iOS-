import Foundation

public struct MyInfoResponse: Identifiable, Codable {
    public let id: Int
    public let name: String
    public let grade: Int
    public let profileImage: String
}
