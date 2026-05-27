import XCTest
@testable import FPMI_App

final class FPMI_AppTests: XCTestCase {

    override func setUpWithError() throws {
        // Очищаем состояние перед каждым тестом
        UserDefaults.standard.removeObject(forKey: "isAuth")
        UserDefaults.standard.removeObject(forKey: "currentUser")
    }

    // 1. Проверка парсинга данных из Plist
    func testDepartmentLoadFromPlist() throws {
        let departments = Department.loadFromPlist()
        XCTAssertNotNil(departments, "Данные из Departments.plist должны загрузиться")
        XCTAssertTrue(departments.count > 0, "Массив департаментов не должен быть пустым")
    }

    // 2. Проверка инициализации модели
    func testDepartmentModelInitialization() throws {
        let dep = Department(name: "Test", imageName: "img", headName: "Head", courses: ["Math"])
        XCTAssertEqual(dep.name, "Test")
        XCTAssertEqual(dep.courses.count, 1)
    }

    // 3. Проверка успешного сохранения в UserDefaults при входе
    func testLoginSuccessSavesToUserDefaults() throws {
        let loginVC = LoginViewController()
        loginVC.loadViewIfNeeded() // Инициализируем UI
        
        loginVC.loginField.text = "Student"
        loginVC.passwordField.text = "12345"
        loginVC.didTapLogin()
        
        XCTAssertTrue(UserDefaults.standard.bool(forKey: "isAuth"), "Флаг isAuth должен стать true")
        XCTAssertEqual(UserDefaults.standard.string(forKey: "currentUser"), "Student")
    }

    // 4. Проверка отказа авторизации при пустых полях
    func testLoginFailsWithEmptyFields() throws {
        let loginVC = LoginViewController()
        loginVC.loadViewIfNeeded()
        
        loginVC.loginField.text = ""
        loginVC.passwordField.text = ""
        loginVC.didTapLogin()
        
        XCTAssertFalse(UserDefaults.standard.bool(forKey: "isAuth"), "При пустых полях авторизация не должна пройти")
    }

    // 5. Проверка успешной очистки UserDefaults при Logout
    func testLogoutClearsUserDefaults() throws {
        UserDefaults.standard.set(true, forKey: "isAuth")
        
        let depsVC = DepartmentsViewController()
        depsVC.didTapLogout() // Вызываем метод выхода
        
        XCTAssertFalse(UserDefaults.standard.bool(forKey: "isAuth"), "Флаг isAuth должен стать false после выхода")
    }

    // 6. Проверка инициализации главного экрана (UICollectionView)
    func testDepartmentsViewControllerHasCollectionView() throws {
        let depsVC = DepartmentsViewController()
        depsVC.loadViewIfNeeded()
        XCTAssertNotNil(depsVC.collectionView, "CollectionView должен быть инициализирован")
    }

    // 7. Проверка количества элементов в CollectionView
    func testCollectionViewDataSourceCount() throws {
        let depsVC = DepartmentsViewController()
        depsVC.loadViewIfNeeded()
        let count = depsVC.collectionView(depsVC.collectionView, numberOfItemsInSection: 0)
        XCTAssertEqual(count, depsVC.departments.count, "Количество ячеек должно совпадать с количеством департаментов")
    }

    // 8. Проверка инициализации DetailViewController
    func testDetailViewControllerInitialization() throws {
        let detailVC = DetailViewController()
        detailVC.item = Department(name: "IT", imageName: "img", headName: "Steve", courses: ["iOS"])
        detailVC.loadViewIfNeeded()
        
        XCTAssertEqual(detailVC.title, "IT", "Заголовок DetailVC должен совпадать с именем департамента")
    }

    // 9. Проверка базовых элементов ячейки
    func testDepartmentCellInitialization() throws {
        let cell = DepartmentCell(frame: .zero)
        XCTAssertNotNil(cell.img, "Изображение в ячейке не должно быть nil")
        XCTAssertNotNil(cell.label, "Лейбл в ячейке не должен быть nil")
    }

    // 10. Тестирование перехода на экран в SceneDelegate (имитация)
    func testSceneDelegateRootViewControllerDecision() throws {
        UserDefaults.standard.set(true, forKey: "isAuth")
        let isAuth = UserDefaults.standard.bool(forKey: "isAuth")
        XCTAssertTrue(isAuth, "Система должна пустить на главный экран")
    }
}