
import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initiateTabbarViewControllers()
    }
    
    private func initiateTabbarViewControllers() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        // TabBarItem bilgilerini tutan bir yapı
        let tabbarItems: [(viewControllerID: String, viewControllerType: UIViewController.Type, title: String, imageName: String, tag: Int)] = [
            ("CategoryViewController", CategoryViewController.self, "Categories", "house", 0),
            ("SearchViewController", SearchViewController.self, "Search", "magnifyingglass", 1),
            ("RandomCocktailViewController", RandomCocktailViewController.self, "Random", "questionmark.app", 2)
        ]
        
        var viewControllers: [UIViewController] = []
        
        // Her bir tab için ilgili view controller'ı oluşturup düzenliyoruz
        for tabbarItem in tabbarItems {
            let viewController = storyBoard.instantiateViewController(withIdentifier: tabbarItem.viewControllerID)
            
            if let categoriesVC = viewController as? CategoryViewController {
                let categoriesViewModel = CategoryViewModel(networkManager: NetworkManager())
//                categoriesVC.configure(viewModel: categoriesViewModel)
                print("CategoryViewController'a ViewModel atandı.")
            }
           
            let navigationController = UINavigationController(rootViewController: viewController)
                navigationController.tabBarItem = UITabBarItem(title: tabbarItem.title, image: UIImage(systemName: tabbarItem.imageName), tag: tabbarItem.tag)
                viewControllers.append(navigationController)
        }
            self.viewControllers = viewControllers
    }
}
