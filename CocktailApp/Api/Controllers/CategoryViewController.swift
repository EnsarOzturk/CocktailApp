//
//  CategoryViewController.swift
//  CocktailApp
//
//  Created by Ensar on 25.12.2023.
//

import UIKit

class CategoryViewController: UIViewController{
    @IBOutlet weak var collectionView: UICollectionView!
    private let network = NetworkManager()
    private var categories: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // collection
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: CategoryCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white
        
        // view
        view.backgroundColor = UIColor.white
        
        // navigation
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Categories"
        navigationController?.navigationBar.backgroundColor = UIColor.white
        
        // tabbar
        tabBarController?.tabBar.barTintColor = UIColor.white
        tabBarController?.tabBar.tintColor = UIColor.black
        
      
        
        // fetch network
        network.request(type: CategoryResponse.self, item: CategoryEndpointItem()) { result in
            switch result {
            case .success(let response):
                if let categories = response.drinks {
                    self.categories = categories
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
              }
            }
            case .failure(let error): print(error)
          }
        }
    }
}

extension CategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
        let category: Category
        category = categories[indexPath.row]
        cell.configure(category: category)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = categories[indexPath.row].strCategory
        if let selectedCategory = categories.first(where: { $0.strCategory == selectedCategory }) {
            listViewController(category: selectedCategory)
        } else {
      }
    }
    
    func listViewController(category: Category) {
        let listVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
        if let navigationController = navigationController {
            listVC.selectedCategory = category
            navigationController.pushViewController(listVC, animated: true)
        } else {
    }
}
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 48) / 3
        let height = width / 2 * 3
        return CGSize(width: width, height: height)
    }
}
