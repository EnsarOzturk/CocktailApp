
import UIKit

final class TabBarController: UITabBarController {
    
    struct Constants {
        static let storyBoard: String = "Main"
        // viewControllerID
        static let categoryVC: String = "CategoryViewController"
        static let searchVC: String = "SearchViewController"
        static let randomVC: String = "RandomCocktailViewController"
        // title
        static let categoryTitle: String = "Categories"
        static let searchTitle: String = "Search"
        static let randomTitle: String = "Luck"
        // image
        static let categoryImage: String = "house"
        static let searchImage: String = "magnifyingglass"
        static let randomImage: String = "questionmark.app"
        // tag
        static let houseTag: Int = 0
        static let searchTag: Int = 1
        static let randomTag: Int = 2
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initiateTabbarViewControllers()
        configureTabBarAppearance()
    }
    
    private func initiateTabbarViewControllers() {
        let storyBoard = UIStoryboard(name: Constants.storyBoard, bundle: nil)
        // TabBarItem
        let tabbarItems: [(viewControllerID: String, viewControllerType: UIViewController.Type, title: String, imageName: String, tag: Int)] = [
            (Constants.categoryVC, CategoryViewController.self, Constants.categoryTitle, Constants.categoryImage, Constants.houseTag),
            (Constants.searchVC, SearchViewController.self, Constants.searchTitle, Constants.searchImage, Constants.searchTag),
            (Constants.randomVC, RandomCocktailViewController.self, Constants.randomTitle, Constants.randomImage, Constants.randomTag)
        ]
        
        var viewControllers: [UIViewController] = []
        
        for tabbarItem in tabbarItems {
            let viewController = storyBoard.instantiateViewController(withIdentifier: tabbarItem.viewControllerID)
            
            if let categoriesVC = viewController as? CategoryViewController {
                let categoriesViewModel = CategoryViewModel(networkManager: NetworkManager(), view: categoriesVC)
                categoriesVC.viewModel = categoriesViewModel
            }
           
            let navigationController = UINavigationController(rootViewController: viewController)
                navigationController.tabBarItem = UITabBarItem(title: tabbarItem.title, image: UIImage(systemName: tabbarItem.imageName), tag: tabbarItem.tag)
                viewControllers.append(navigationController)
        }
            self.viewControllers = viewControllers
    }
    
    private func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        
        // Arka plan rengini belirle
        appearance.backgroundColor = UIColor.customTabBarBackgroundColor
        
        // Seçili ikon ve başlık rengi
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor.customTabBarTintColor
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor.customTabBarTintColor
        ]
        
        // Seçili olmayan ikon ve başlık rengi
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.systemGray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.systemGray
        ]
        
        // TabBar'a görünümü uygula
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            configureTabBarAppearance()
        }
    }
}
