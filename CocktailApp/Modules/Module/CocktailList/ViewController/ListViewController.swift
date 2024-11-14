//
//  ListViewController.swift
//  CocktailApp
//
//  Created by Ensar on 25.12.2023.
//

import UIKit

protocol ListViewProtocol: AnyObject {
    func displayError(_ message: String)
}

struct Constants {
    //cell
    static let listCellIdentifier: String = "ListCell"
    static let bigCellIdentifier: String = "BigCardCell"
    static let bigCard: String = "BigCard"
    static let smallCard: String = "SmallCard"
    //collectionView
    static let top: Double = 8
    static let left: Double = 8
    static let button: Double = 0
    static let right: Double = 8
    static let lineSpacing: Double = 8
    //showDetail
    static let main: String = "Main"
    static let detailVcIdentifier: String = "DetailsViewController"
}

final class ListViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    private var viewModel: ListViewModelProtocol!
    private var listViewStyle: viewStyle = .small
    var selectedCategory: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupNavigation()
        navigationTitleAttributes()
        
        guard let category = selectedCategory else {
                displayError("Category not selected")
                return
            }
        
        viewModel = ListViewModel(networkManager: NetworkManager(), category: category)
        fetchDrinks()
    }
    
    private func fetchDrinks() {
        viewModel.fetchDrinks { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                
                switch result {
                    case .success:
                    self.collectionView.reloadData() 
                    case .failure(let error):
                    self.displayError(error.localizedDescription)
                }
            }
        }
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: Constants.listCellIdentifier, bundle: nil), forCellWithReuseIdentifier: ListCell.identifier)
        collectionView.register(UINib(nibName: Constants.bigCellIdentifier, bundle: nil), forCellWithReuseIdentifier: BigCardCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: Constants.top, left: Constants.left, bottom: Constants.button, right: Constants.right)
        collectionView.backgroundColor = UIColor.white
        collectionView.indicatorStyle = .default
        collectionView.showsVerticalScrollIndicator = false
    }
    
    private func setupNavigation() {
        title = selectedCategory?.strCategory
        let viewStyleButton = UIBarButtonItem(image: UIImage(named: Constants.bigCard), style: .plain, target: self, action: #selector(viewStyleButtonTapped(_:)))
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
               sender.image = UIImage(named: Constants.bigCard)
               sender.tintColor = UIColor.black
           } else {
               sender.image = UIImage(named: Constants.smallCard)
               sender.tintColor = UIColor.black
           }
        }
    }

extension ListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfDrinks
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let drink = viewModel.getDrink(at: indexPath.row) else {
            return UICollectionViewCell()
        }
        switch listViewStyle {
        case .small:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.listCellIdentifier, for: indexPath) as! ListCell
            cell.configure(drink: drink)
            return cell
        case .big:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.bigCellIdentifier, for: indexPath) as! BigCardCell
            cell.configure(drink: drink)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.lineSpacing
    }
}

extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedDrink = viewModel.getDrink(at: indexPath.row) else { return }
        if let drinkId = selectedDrink.idDrink {
            showDetailViewController(with: drinkId)
    }
}
    
    func showDetailViewController(with drinkId: String) {
        let storyboard = UIStoryboard(name: Constants.main, bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: Constants.detailVcIdentifier) as? DetailsViewController {
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

extension ListViewController: ListViewProtocol {
    func displayError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

enum viewStyle {
    case small
    case big
}
