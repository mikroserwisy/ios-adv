import XCTest
@testable import GoodWeather

class CalculatorTests: XCTestCase {

    private var sut: Calculator!
    
    override func setUp() {
        sut = Calculator()
    }
    
    func test_given_two_numbers_when_add_then_returns_their_sum() {
        // Given/Arrange
        let firstNumber = 1
        let secondNumber = 2
        // When/Act
        let actual = sut.add(leftHandSide: firstNumber, rightHandSide: secondNumber)
        // Then/Assert
        XCTAssertEqual(actual, 3)
    }
    
    func test_given_divisor_equals_zero_when_divide_then_throws_exception() {
        XCTAssertThrowsError(try sut.divide(leftHandSide: 1, rightHandSide: 0))
    }
    
    func test_when_get_random_prime_then_returns_prime_number() {
        let expectation = expectation(description: "Prime is returned")
        var result: Int?
        sut.getRandomPrime { prime in
            result = prime
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10)
        XCTAssertEqual(result, 5)
    }
    
    func test_when_get_random_prime_then_returns_prime_number_with_await() throws {
        let result = try asyncCall(sut.getRandomPrime)
        XCTAssertEqual(result, 5)
    }

}

extension XCTestCase {
    
    func asyncCall<T>(_ function: (@escaping (T) -> Void) -> Void) throws -> T {
        let expectation = expectation(description: "Async call")
        var result: T?
        
        function() { value in
            result = value
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10)
        guard let unwrapperdResult = result else {
            fatalError()
        }
        return unwrapperdResult
    }
    
}
