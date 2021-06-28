@propertyWrapper
struct Inject<Dependency> {
    
    var dependency: Dependency!
    
    var wrappedValue: Dependency {
        mutating get {
            if dependency == nil {
                let dep: Dependency = Container.shared.get()
                self.dependency = dep
            }
            return dependency
        }
        mutating set {
            dependency = newValue
        }
        
    }
    
}
