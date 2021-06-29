import XCTest

class GoodWeatherUITests: XCTestCase {

    func testRefreshForecastForCity() throws {
        let app = XCUIApplication()
        app.launch()
        app.images["settings"].tap()
        let cityTextField = app.textFields.firstMatch
        cityTextField.clear()
        cityTextField.typeText("Berlin")
        app.buttons["close"].tap()
        sleep(3)
        XCTAssertEqual(app.staticTexts["city"].label, "Berlin")
    }

}

extension XCUIElement {
    
    func clear() {
        guard let value = self.value as? String else {
            return
        }
        tap()
        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: value.count)
        typeText(deleteString)
    }
    
}
