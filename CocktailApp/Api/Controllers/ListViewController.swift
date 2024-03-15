//
//  ListViewController.swift
//  CocktailApp
//
//  Created by Ensar on 25.12.2023.
//

import UIKit

class ListViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    private var viewModel: ListViewModel!
    private var listViewStyle: listViewStyle = .small
    var selectedCategory: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        viewModel = ListViewModel(networkManager: NetworkManager())
        viewModel.selectedCategory = selectedCategory

        viewModel.fetchDrinks { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success:
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    case .failure(let error):
                        print("Error fetching drinks: \(error)")
                    }
                }
        
        navigationTitleAttributes()
        setupNavigation()
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "ListCell", bundle: nil), forCellWithReuseIdentifier: ListCell.identifier)
        collectionView.register(UINib(nibName: "BigCardCell", bundle: nil), forCellWithReuseIdentifier: BigCardCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8)
        collectionView.backgroundColor = UIColor.white
        collectionView.indicatorStyle = .default
        collectionView.showsVerticalScrollIndicator = false
    }
    
    private func setupNavigation() {
        title = selectedCategory?.strCategory
            let viewStyleButton = UIBarButtonItem(image: UIImage(named: "BigCard"), style: .plain, target: self, action: #selector(viewStyleButtonTapped(_:)))
            navigationItem.rightBarButtonItem = viewStyleButton
            navigationController?.navigationBar.tintColor = .black
            view.backgroundColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
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
        return viewModel.numberOfDrinks()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let drink = viewModel.getDrink(at: indexPath.row) else {
            return UICollectionViewCell()
        }
        switch listViewStyle {
        case .small:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCell", for: indexPath) as! ListCell
            cell.configure(drink: drink)
            return cell
        case .big:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BigCardCell", for: indexPath) as! BigCardCell
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
        guard let selectedDrink = viewModel.getDrink(at: indexPath.row) else {
                return
            }
        if let drinkId = selectedDrink.idDrink {
                showDetailViewController(with: drinkId)
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
