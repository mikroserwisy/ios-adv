import Combine

protocol ProfileStore {
    
    var user: AnyPublisher<User, Never> { get }
    
    func update(user: User)
    
}
