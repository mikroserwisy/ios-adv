import Foundation
import Combine
import Resolver

final class ProfileViewModel: ObservableObject {
    
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var passwordConfirmation = ""
    @Published var birthday = Date()
    @Published var subscriber = false
    @Published var cardNumber = ""
    @Published var cardCvv = ""
    @Published var cardExpirationDate = Date()
    @Published var isFormValid = false
    @Injected
    private var profileStore: ProfileStore
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        let isValid = Publishers.CombineLatest3(
            emailIsValid(),
            passwordIsValid(),
            passwordMatchingConfirmation()
        )
        .debounce(for: .milliseconds(1000), scheduler: RunLoop.main)
        .map { $0 && $1 && $2 }
        isValid.assign(to: &$isFormValid)

        isValid
            .filter { $0 }
            .map { _ in User(firstName: self.firstName, subscriber: self.subscriber) }
            .sink(receiveValue: profileStore.update)
            .store(in: &subscriptions)
    }
    
    private func emailIsValid() -> AnyPublisher<Bool, Never> {
        $email.map { $0.contains("@") && $0.contains(".") }.eraseToAnyPublisher()
    }
    
    private func passwordIsValid() -> AnyPublisher<Bool, Never> {
        $password.map { $0.count > 6 }.eraseToAnyPublisher()
    }
    
    private func passwordMatchingConfirmation() -> AnyPublisher<Bool, Never> {
        $password.combineLatest($passwordConfirmation)
            .map { $0 == $1 }
            .eraseToAnyPublisher()
    }
    
}
