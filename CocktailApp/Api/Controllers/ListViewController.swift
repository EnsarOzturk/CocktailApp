//
//  ListViewController.swift
//  CocktailApp
//
//  Created by Ensar on 25.12.2023.
//

import UIKit

class ListViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    private let network = NetworkManager()
    private var drinks: [Drink] = []
    var selectedCategory: Category?
    private var listViewStyle: listViewStyle = .small
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationTitleAttributes()
        fetchCoctailsCategory()
        // collectionView
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "ListCell", bundle: nil), forCellWithReuseIdentifier: ListCell.identifier)
        collectionView.register(UINib(nibName: "BigCardCell", bundle: nil), forCellWithReuseIdentifier: BigCardCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8)
        collectionView.backgroundColor = UIColor.white
        collectionView.indicatorStyle = .default
        collectionView.showsVerticalScrollIndicator = false
        // navigation
        title = selectedCategory?.strCategory
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationItem.rightBarButtonItem?.image = UIImage(named: "BigCard")
        // tabbar
        tabBarController?.tabBar.barTintColor = UIColor.white
        tabBarController?.tabBar.tintColor = UIColor.black
        // view
        view.backgroundColor = UIColor.white
    }
    
    private func navigationTitleAttributes() {
        if let titleAttributes = navigationController?.navigationBar.largeTitleTextAttributes {
            var updatedAttributes = titleAttributes
            updatedAttributes[.foregroundColor] = UIColor.black
            navigationController?.navigationBar.largeTitleTextAttributes = updatedAttributes
        } else {
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        }
    }
    
    func fetchCoctailsCategory() {
        guard let selectedCategory = selectedCategory,
              let originalCategory = selectedCategory.strCategory else {
            return
        }
        
        let endpoint = ListEndpointItem(category: originalCategory.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        network.request(type: ListResponse.self, item: endpoint) { result in
            switch result {
            case .success(let response):
                if let drinks = response.drinks {
                    self.drinks = drinks
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                } else {
                }
            case .failure(let error):
                print(error)
                endpoint.handle(error: error)
            }
        }
    }

    @IBAction func viewStyleButtonTapped(_ sender: UIBarButtonItem) {
        listViewStyle = listViewStyle == .small ? .big : .small
           collectionView.reloadData()
           if listViewStyle == .small {
               sender.image = UIImage(named: "BigCard")
               sender.tintColor = UIColor.black
           } else {
               sender.image = UIImage(named: "SmallCard")
               sender.tintColor = UIColor.black
           }
    }
}

extension ListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        drinks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch listViewStyle {
        case .small:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCell", for: indexPath) as! ListCell
            let drink: Drink
            drink = drinks[indexPath.row]
            cell.configure(drink: drink)
            return cell
        case .big:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BigCardCell", for: indexPath) as! BigCardCell
            let drink: Drink
            drink = drinks[indexPath.row]
            cell.configure(drink: drink)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedDrink = drinks[indexPath.row]
            if let drinkId = selectedDrink.idDrink {
                showDetailViewController(with: drinkId)
            } else {
    }
}
    
    func showDetailViewController(with drinkId: String) {
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           
           if let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController {
               detailVC.cocktailId = drinkId
               navigationController?.pushViewController(detailVC, animated: true)
           } else {
        }
    }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch listViewStyle {
        case .small:
            let width = (UIScreen.main.bounds.width - 32) / 3
            let height = width / 2 * 3
            return CGSize(width: width, height: height)
        case .big:
            let width = (UIScreen.main.bounds.width - 24) / 2
            let height = width / 2 * 3
            return CGSize(width: width, height: height)
        }
    }
}

enum viewStyle {
    case small
    case big
}
