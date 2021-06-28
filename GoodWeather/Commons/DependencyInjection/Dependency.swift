struct Dependency {
    
    typealias Factory<T> = () -> T
    
    private let factory: Factory<Any>
    private(set) var component: Any!
    
    let name: String
 
    init<T>(_ factory: @escaping Factory<T>) {
        self.factory = factory
        name = String(describing: T.self)
    }
    
    mutating func build() {
        component = factory()
    }
    
}
