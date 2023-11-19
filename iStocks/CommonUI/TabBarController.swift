import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setTabBar()
    }
    
    private func generateTabBar() {
        viewControllers = [
            generate(
                MainViewController(),
                title: "Главная",
                image: "main"
            ),
            generate(
                SubscriptionsViewController(),
                title: "Заметки",
                image: "notes"
            ),
            generate(
                SettingsViewController(),
                title: "Настройки",
                image: "settings"
            )
        ]
    }
    
    private func generate(_ viewController: UIViewController, title: String, image: String) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: viewController)
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = UIImage(named: "\(image)")
        viewController.tabBarItem.selectedImage = UIImage(named: "\(image).fill")
        
        return navigationController
    }
    
    private func setTabBar() {
        tabBar.backgroundColor = UIColor(named: "tabBar")
        tabBar.tintColor = UIColor(named: "tabBarItem")
        tabBar.unselectedItemTintColor = UIColor(named: "tabBarItem")
    }
}
