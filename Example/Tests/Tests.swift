import XCTest
import SceneCoordinator

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // 1. Do A normal push
        SceneCoordinator<Main>.push(to: .mainViewController, animated: true)
        XCTAssertEqual(SceneCoordinator<Main>.description, "0: UITabBarController \n")
        
        // 2. Do a Presentation
        SceneCoordinator<Main>.presentView(scene: .firstViewController, animated: true)
        SceneCoordinator<Main>.push(to: .secondViewController, animated: true)
        XCTAssertEqual(SceneCoordinator<Main>.description, "0: UITabBarController \n1: FirstViewController \n")
        
        // 3. Do a NavBar Navigation
        SceneCoordinator<Main>.presentNav(with: .firstViewController, animated: true)
        XCTAssertEqual(SceneCoordinator<Main>.description, "0: UITabBarController \n1: FirstViewController \n2: UINavigationController \n")
        
        // 3. Dismiss
        SceneCoordinator<Nav>.dismiss(animated: true)
        XCTAssertEqual(SceneCoordinator<Main>.description, "0: UITabBarController \n1: FirstViewController \n")
        
        // 4. Dismiss Again
        SceneCoordinator<Nav>.dismiss(animated: true)
        XCTAssertEqual(SceneCoordinator<Main>.description, "0: UITabBarController \n")
        
    }
    
    
}
