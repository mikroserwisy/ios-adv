class Container {
    
    static private(set) var shared = Container()

    private var dependencies = [Dependency]()
    
    func add(depenency: Dependency) {
        guard dependencies.firstIndex(where: { $0.name == depenency.name }) == nil else {
            return
        }
        dependencies.append(depenency)
    }
    
    func build() {
        for index in dependencies.startIndex ..< dependencies.endIndex {
            dependencies[index].build()
        }
        Self.shared = self
    }
    
    func get<T>() -> T {
        guard let dependency = dependencies.first(where: { $0.component is T })?.component as? T else {
            fatalError()
        }
        return dependency
    }
    
    @resultBuilder
    struct DependencyBuilder {
        public static func buildBlock(_ dependency: Dependency) -> Dependency { dependency }
        public static func buildBlock(_ dependencies: Dependency...) -> [Dependency] { dependencies }
    }
    
    convenience init(@DependencyBuilder _ dependencies: () ->  [Dependency]) {
        self.init()
        dependencies().forEach { add(depenency: $0) }
    }
    
    convenience init(@DependencyBuilder _ dependency: () ->  Dependency) {
        self.init()
        add(depenency: dependency())
    }
    
}
