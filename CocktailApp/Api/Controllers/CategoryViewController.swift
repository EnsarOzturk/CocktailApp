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

        // collectionView
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: CategoryCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        
        // navigation
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Categories"
        
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

extension CategoryViewController: UICollectionViewDataSource {
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
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
