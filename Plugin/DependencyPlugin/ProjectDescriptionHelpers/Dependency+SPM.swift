@preconcurrency import ProjectDescription

public extension TargetDependency {
    struct SPM {}
}

public extension TargetDependency.SPM {
    static let Moya = TargetDependency.external(name: "Moya")
    static let GoogleSignIn = TargetDependency.external(name: "GoogleSignIn")
}

public extension Package {
}
