//
//  CategoryViewController.swift
//  CocktailApp
//
//  Created by Ensar on 25.12.2023.
//

import UIKit

class CategoryViewController: UIViewController{
    @IBOutlet weak var collectionView: UICollectionView!
    private var viewModel: CategoryViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "Categories"
        tabBarController?.tabBar.barTintColor = UIColor.white
        tabBarController?.tabBar.tintColor = UIColor.black
        setupCollectionView()
        fetchCategories()
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: CategoryCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white
    }
    
    private func fetchCategories() {
        viewModel = CategoryViewModel(networkManager: NetworkManager())
        viewModel.fetchCategories { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success:
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                case .failure(let error):
                    print("Error fetching categories: \(error)")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension CategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfCategories()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else {
            fatalError("Could not dequeue CategoryCell")
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

extension CategoryViewController {
    func listViewController(category: Category) {
        let listVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
            listVC.selectedCategory = category
            navigationController?.pushViewController(listVC, animated: true)
    }
}
    
