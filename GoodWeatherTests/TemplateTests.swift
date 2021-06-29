import Foundation
import XCTest
@testable import GoodWeather

class TemplateTests: XCTestCase {
    
    private let textWithoutExpressions = "My name is Jan Kowalski"
    private let textWithExpressions = "My name is ${firstName} ${lastName}"
    
    func test_given_a_text_without_expression_when_evaluate_then_returns_the_text() {
        let template = Template(textWithoutExpressions)
        XCTAssertEqual(textWithoutExpressions, try template.evaluate(with: [:]))
    }
    
    func test_given_a_text_with_expressions_when_evaluate_then_return_the_text_with_substituted_parameters() {
        let template = Template(textWithExpressions)
        XCTAssertEqual(textWithoutExpressions, try template.evaluate(with: ["firstName": "Jan", "lastName": "Kowalski"]))
    }
    
    func test_given_a_text_with_expressions_when_evaluate_without_providing_all_parameters_then_throws_exception() {
        let template = Template(textWithExpressions)
        XCTAssertThrowsError(try template.evaluate(with: [:]))
    }
    
}
