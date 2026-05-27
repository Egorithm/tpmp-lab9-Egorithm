import XCTest
@testable import example1_2

final class example1_2Tests: XCTestCase {
    
    var sut: ViewController!

    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateInitialViewController() as? ViewController
        sut.loadViewIfNeeded()
        
        UserDefaults.standard.removeObject(forKey: "userLogin")
        UserDefaults.standard.removeObject(forKey: "isLoggedIn")
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testViewControllerNotNil() throws {
        XCTAssertNotNil(sut, "ViewController должен быть инициализирован")
    }

    func testInitialEmailFieldIsHidden() throws {
        XCTAssertTrue(sut.emailTextField.isHidden, "Поле email должно быть скрыто на экране входа")
    }

    func testInitialButtonTitle() throws {
        XCTAssertEqual(sut.actionButton.title(for: .normal), "Войти", "Кнопка должна называться 'Войти'")
    }

    func testSegmentChangeToRegistrationShowsEmail() throws {
        sut.authSegmentedControl.selectedSegmentIndex = 1
        sut.segmentChanged(sut.authSegmentedControl)
        
        XCTAssertFalse(sut.emailTextField.isHidden, "Поле email должно отображаться при регистрации")
        XCTAssertEqual(sut.actionButton.title(for: .normal), "Зарегистрироваться")
    }

    func testSegmentChangeBackToLogin() throws {
        sut.authSegmentedControl.selectedSegmentIndex = 1
        sut.segmentChanged(sut.authSegmentedControl) 
        sut.authSegmentedControl.selectedSegmentIndex = 0
        sut.segmentChanged(sut.authSegmentedControl) 
        
        XCTAssertTrue(sut.emailTextField.isHidden)
    }

    func testEmptyFieldsDoNotTriggerRegistration() throws {
        sut.authSegmentedControl.selectedSegmentIndex = 1
        sut.loginTextField.text = ""
        sut.passwordTextField.text = ""
        sut.actionButtonTapped(sut.actionButton)
        
        XCTAssertNil(UserDefaults.standard.string(forKey: "userLogin"), "Пустые поля не должны сохраняться")
    }

    func testRegistrationSavesToUserDefaults() throws {
        sut.authSegmentedControl.selectedSegmentIndex = 1
        sut.loginTextField.text = "testUser"
        sut.passwordTextField.text = "12345"
        sut.actionButtonTapped(sut.actionButton)
        
        XCTAssertEqual(UserDefaults.standard.string(forKey: "userLogin"), "testUser")
    }

    func testLoginSuccessSetsFlag() throws {
        UserDefaults.standard.set("testUser", forKey: "userLogin")
        
        sut.authSegmentedControl.selectedSegmentIndex = 0
        sut.loginTextField.text = "testUser"
        sut.passwordTextField.text = "12345"
        sut.actionButtonTapped(sut.actionButton)
        
        XCTAssertTrue(UserDefaults.standard.bool(forKey: "isLoggedIn"), "Флаг входа должен установиться в true")
    }

    func testTermsSwitchIsOnInitially() throws {
        XCTAssertTrue(sut.termsSwitch.isOn, "Согласие с правилами должно быть включено по умолчанию")
    }

    func testLoginFailureDoesNotSetFlag() throws {
        UserDefaults.standard.set("correctUser", forKey: "userLogin")
        
        sut.authSegmentedControl.selectedSegmentIndex = 0
        sut.loginTextField.text = "wrongUser"
        sut.passwordTextField.text = "12345"
        sut.actionButtonTapped(sut.actionButton)
        
        XCTAssertFalse(UserDefaults.standard.bool(forKey: "isLoggedIn"))
    }
}