//
//  CategoryViewController.swift
//  CocktailApp
//
//  Created by Ensar on 25.12.2023.
//

import UIKit

protocol CategoryViewProtocol: AnyObject {
    func reloadData()
    func displayError(_ message: String)
}

struct ViewConstants {
    static let title: String = "Categories"
    static let categoryCell: String = "CategoryCell"
    //list
    static let main: String = "Main"
    static let listVcIdentifier: String = "ListViewController"
    //cell
    static let LineSpacing: Double = 8
}

final class CategoryViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel: CategoryViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionView()
        viewModel = CategoryViewModel(networkManager: NetworkManager(), view: self)
        viewModel.fetchCategories()
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: ViewConstants.categoryCell, bundle: nil), forCellWithReuseIdentifier: CategoryCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.white
        title = ViewConstants.title
        tabBarController?.tabBar.barTintColor = UIColor.white
        tabBarController?.tabBar.tintColor = UIColor.black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension CategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfCategories
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else {
            fatalError("error CategoryCell")
        }
            if let category = viewModel.getCategory(at: indexPath.row) {
                cell.configure(category: category)
            }
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let category = viewModel.getCategory(at: indexPath.row) {
                   listViewController(category: category)
    }
}
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        Constants.lineSpacing
    }
}

extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 48) / 3
        let height = width / 2 * 3
        return CGSize(width: width, height: height)
    }
}

extension CategoryViewController: CategoryViewProtocol {
    func reloadData() {
        collectionView.reloadData()
    }
    
    func displayError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension CategoryViewController {
    func listViewController(category: Category) {
        let listVC = UIStoryboard(name: ViewConstants.main, bundle: nil).instantiateViewController(withIdentifier: ViewConstants.listVcIdentifier) as! ListViewController
            listVC.selectedCategory = category
            navigationController?.pushViewController(listVC, animated: true)
    }
}
