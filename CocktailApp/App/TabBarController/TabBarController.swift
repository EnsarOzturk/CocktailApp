
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
        static let randomTitle: String = "Random"
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
}
