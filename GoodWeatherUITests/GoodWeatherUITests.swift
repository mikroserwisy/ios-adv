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
    
    func testRefreshForecastForLocation() {
        let app = XCUIApplication()
        app.launch()
        let location = app.images["location"]
        location.tap()
        allowLocationUpdates()
        location.tap()
        sleep(3)
        XCTAssertEqual(app.staticTexts["city"].label, "Cupertino")
    }
    
    private func allowLocationUpdates() {
        let app = XCUIApplication(bundleIdentifier: "com.apple.springboard")
        let button = app.alerts.firstMatch.buttons["Allow While Using App"]
        _ = button.waitForExistence(timeout: 100)
        button.tap()
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
