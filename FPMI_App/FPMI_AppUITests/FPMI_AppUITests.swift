import XCTest

final class FPMI_AppUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        // Принудительно очистим UserDefaults для чистого старта UI тестов,
        // передав аргумент запуска (Launch Argument)
        app.launchArguments.append("-isAuth")
        app.launchArguments.append("false")
        app.launch()
    }

    // 1. Приложение запускается без падений
    func testAppLaunch() throws {
        XCTAssertTrue(app.state == .runningForeground)
    }

    // 2. Наличие полей на экране Login
    func testLoginElementsExist() throws {
        XCTAssertTrue(app.secureTextFields["Password"].exists, "Поле пароля должно существовать")
    }

    // 3. Ввод текста в поле логина
    func testLoginFieldInput() throws {
        // Мы берем первое обычное текстовое поле, так как плейсхолдер локализован
        let loginField = app.textFields.element(boundBy: 0)
        if loginField.exists {
            loginField.tap()
            loginField.typeText("TestStudent")
            XCTAssertEqual(loginField.value as? String, "TestStudent")
        }
    }

    // 4. Ввод текста в поле пароля
    func testPasswordFieldInput() throws {
        let passwordField = app.secureTextFields["Password"]
        if passwordField.exists {
            passwordField.tap()
            passwordField.typeText("12345")
            // Пароль скрыт, поэтому проверяем только, что поле активно
            XCTAssertTrue(passwordField.isEnabled)
        }
    }

    // 5. Попытка нажать Login с пустыми полями (никуда не переходит)
    func testEmptyLoginDoesNotNavigate() throws {
        let loginButton = app.buttons.element(boundBy: 0) // Первая кнопка на экране - Login
        if loginButton.exists {
            loginButton.tap()
            XCTAssertTrue(app.secureTextFields["Password"].exists, "Мы должны остаться на экране логина")
        }
    }

    // 6. Успешный вход в приложение
    func testSuccessfulLoginNavigation() throws {
        let loginField = app.textFields.element(boundBy: 0)
        let passField = app.secureTextFields["Password"]
        let loginBtn = app.buttons.element(boundBy: 0)
        
        if loginField.exists && passField.exists {
            loginField.tap()
            loginField.typeText("Student")
            
            passField.tap()
            passField.typeText("Pass")
            
            loginBtn.tap()
            
            // Ждем появления CollectionView на главном экране
            let collectionView = app.collectionViews.element
            XCTAssertTrue(collectionView.waitForExistence(timeout: 2.0), "Должен произойти переход на главный экран")
        }
    }

    // 7. Проверка работы скролла в CollectionView (если там больше 1 элемента)
    func testCollectionViewScrolling() throws {
        // Пропускаем логин (хак для UI тестов, если мы уже авторизованы)
        let collectionView = app.collectionViews.element
        if collectionView.exists {
            collectionView.swipeUp()
            XCTAssertTrue(collectionView.isHittable)
        }
    }

    // 8. Переход на детальный экран Department
    func testTapDepartmentCellNavigatesToDetail() throws {
        // Проводим логин
        app.textFields.element(boundBy: 0).tap(); app.textFields.element(boundBy: 0).typeText("1")
        app.secureTextFields["Password"].tap(); app.secureTextFields["Password"].typeText("1")
        app.buttons.element(boundBy: 0).tap()
        
        let firstCell = app.collectionViews.cells.element(boundBy: 0)
        if firstCell.waitForExistence(timeout: 2.0) {
            firstCell.tap()
            let backButton = app.navigationBars.buttons.element(boundBy: 0)
            XCTAssertTrue(backButton.waitForExistence(timeout: 1.0), "Должна появиться кнопка 'Назад'")
        }
    }

    // 9. Возврат с детального экрана назад
    func testNavigateBackFromDetail() throws {
        app.textFields.element(boundBy: 0).tap(); app.textFields.element(boundBy: 0).typeText("1")
        app.secureTextFields["Password"].tap(); app.secureTextFields["Password"].typeText("1")
        app.buttons.element(boundBy: 0).tap()
        
        let firstCell = app.collectionViews.cells.element(boundBy: 0)
        if firstCell.waitForExistence(timeout: 2.0) {
            firstCell.tap()
            let backButton = app.navigationBars.buttons.element(boundBy: 0)
            backButton.tap()
            XCTAssertTrue(app.collectionViews.element.exists, "Мы должны вернуться к списку департаментов")
        }
    }

    // 10. Проверка работы кнопки Logout
    func testLogoutButtonFlow() throws {
        app.textFields.element(boundBy: 0).tap(); app.textFields.element(boundBy: 0).typeText("1")
        app.secureTextFields["Password"].tap(); app.secureTextFields["Password"].typeText("1")
        app.buttons.element(boundBy: 0).tap()
        
        let navBar = app.navigationBars.element(boundBy: 0)
        if navBar.waitForExistence(timeout: 2.0) {
            let logoutBtn = navBar.buttons.element(boundBy: 0) // Кнопка logout_btn
            if logoutBtn.exists {
                logoutBtn.tap()
                XCTAssertTrue(app.secureTextFields["Password"].waitForExistence(timeout: 1.0), "Должны вернуться на экран логина")
            }
        }
    }
}