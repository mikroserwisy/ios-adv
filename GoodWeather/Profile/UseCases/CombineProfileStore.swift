import Combine
import Foundation

final class CombineProfileStore: ProfileStore {
    
    private let subject = CurrentValueSubject<User, Never>(User(firstName: "", subscriber: false))
    
    var user: AnyPublisher<User, Never>
    
    init() {
        user = subject.eraseToAnyPublisher()
    }
    
    func update(user: User) {
        subject.send(user)
    }
    
}
