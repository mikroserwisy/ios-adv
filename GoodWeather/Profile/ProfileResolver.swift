import Resolver

extension Resolver {

    public static func registerProfileComponents() {
        register { CombineProfileStore() as ProfileStore }
            .scope(.application)
    }
    
}
