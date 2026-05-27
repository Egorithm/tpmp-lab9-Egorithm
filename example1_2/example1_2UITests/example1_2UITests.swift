import XCTest

final class example1_2UITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testAppLaunch() throws {
        XCTAssertTrue(app.state == .runningForeground)
    }

    func testSegmentedControlExists() throws {
        XCTAssertTrue(app.segmentedControls.element.exists)
    }

    func testTapRegistrationSegment() throws {
        let registerSegment = app.segmentedControls.buttons["Регистрация"]
        registerSegment.tap()
        XCTAssertTrue(registerSegment.isSelected)
    }

    func testLoginTextFieldExists() throws {
        let loginField = app.textFields["Login"]
        XCTAssertTrue(loginField.exists)
    }

    func testEmailFieldHiddenOnStart() throws {
        let emailField = app.textFields["E-mail"]
        XCTAssertFalse(emailField.exists)
    }

    func testEmailFieldAppearsOnRegistration() throws {
        app.segmentedControls.buttons["Регистрация"].tap()
        let emailField = app.textFields["E-mail"]
        XCTAssertTrue(emailField.waitForExistence(timeout: 2.0))
    }

    func testLoginButtonExists() throws {
        let loginBtn = app.buttons["Войти"]
        XCTAssertTrue(loginBtn.exists)
    }

    func testButtonTextChangesToRegistration() throws {
        app.segmentedControls.buttons["Регистрация"].tap()
        let registerBtn = app.buttons["Зарегистрироваться"]
        XCTAssertTrue(registerBtn.exists)
    }

    func testTermsSwitchExists() throws {
        let termsSwitch = app.switches.element
        XCTAssertTrue(termsSwitch.exists)
    }

    func testTypingInLoginField() throws {
        let loginField = app.textFields["Login"]
        loginField.tap()
        
        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: 5)
        loginField.typeText(deleteString)
        loginField.typeText("TestUser123")
        
        XCTAssertEqual(loginField.value as? String, "TestUser123")
    }
}