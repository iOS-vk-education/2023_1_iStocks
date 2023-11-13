import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setTabBar()
    }
    
    private func generateTabBar() {
        viewControllers = [
            generateVC(
                viewController: MainViewController(),
                title: "Главная",
                image: "main"
            ),
            generateVC(
                viewController: SubscriptionsViewController(),
                title: "Подписки",
                image: "settings"
            ),
            generateVC(
                viewController: SettingsViewController(),
                title: "Настройки",
                image: "settings"
            )
        ]
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: String) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = UIImage(named: image)
        viewController.tabBarItem.selectedImage = UIImage(named: "\(image).fill")
        
        return viewController
    }
    
    private func setTabBar() {
        self.tabBar.backgroundColor = .tabBarColor
        tabBar.tintColor = .tabBarItemColor
        tabBar.unselectedItemTintColor = .tabBarItemColor
    }
}
