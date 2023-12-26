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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCoctailsCategory()
        
        // collectionView
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ListCell", bundle: nil), forCellWithReuseIdentifier: ListCell.identifier)
//        collectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)

        // navigation
        title = selectedCategory?.strCategory
    }
    
    func fetchCoctailsCategory() {
        guard let selectedCategory = selectedCategory,
              let originalCategory = selectedCategory.strCategory else {
            print("Error: selectedCategory is nil")
            return
        }
        
        let endpoint = ListEndpointItem(category: originalCategory.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        
        print("Request URL: \(endpoint.url)")
       
        network.request(type: ListResponse.self, item: endpoint) { result in
            switch result {
            case .success(let response):
                if let drinks = response.drinks {
                    self.drinks = drinks
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                } else {
                    print("API Response nil")
                }
            case .failure(let error):
                print(error)
                endpoint.handle(error: error)
            }
        }
    }
}

extension ListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        drinks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCell", for: indexPath) as! ListCell
        let drink: Drink
        drink = drinks[indexPath.row]
        cell.configure(drink: drink)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 48) / 2
        let height = width / 2 * 3
        return CGSize(width: width, height: height)
    }
    
}
