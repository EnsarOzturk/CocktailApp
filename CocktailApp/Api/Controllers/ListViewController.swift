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
        
        navigationTitleAttributes()
        fetchCoctailsCategory()
        // view
        view.backgroundColor = UIColor.systemGray6
        
        // collectionView
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "ListCell", bundle: nil), forCellWithReuseIdentifier: ListCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8)
        collectionView.backgroundColor = UIColor.systemGray6
        
        // navigation
        title = selectedCategory?.strCategory
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = UIColor.darkGray
        
        // tabbar
        tabBarController?.tabBar.barTintColor = UIColor.systemGray6
        tabBarController?.tabBar.tintColor = UIColor.darkGray
        
        // view
        view.backgroundColor = UIColor.systemGray6
    }
    
    private func navigationTitleAttributes() {
        if let titleAttributes = navigationController?.navigationBar.largeTitleTextAttributes {
                var updatedAttributes = titleAttributes
                updatedAttributes[.foregroundColor] = UIColor.darkGray
                navigationController?.navigationBar.largeTitleTextAttributes = updatedAttributes
            } else {
                navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
            }
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
    
    @IBAction func viewStyleButtonTapped(_ sender: UIBarButtonItem) {
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
        let width = (UIScreen.main.bounds.width - 32) / 3
        let height = width / 2 * 3
        return CGSize(width: width, height: height)
    }
    
}
