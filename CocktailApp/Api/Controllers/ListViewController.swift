
import UIKit

final class ListViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    private var viewModel: ListViewModelProtocol!
        private var listViewStyle: viewStyle = .small
        var selectedCategory: Category?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            setupCollectionView()
            setupBindings()
            
            viewModel.selectedCategory = selectedCategory
            viewModel.fetchDrinks()
            
            navigationTitleAttributes()
            setupNavigation()
        }
        
        private func setupBindings() {
            viewModel.didUpdateDrinks = { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        self?.collectionView.reloadData()
                    case .failure(let error):
                        print("Error fetching drinks: \(error)")
                        // Handle the error, e.g., show an alert
                    }
                }
            }
        }
        
        private func setupCollectionView() {
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(UINib(nibName: "ListCell", bundle: nil), forCellWithReuseIdentifier: ListCell.identifier)
            collectionView.register(UINib(nibName: "BigCardCell", bundle: nil), forCellWithReuseIdentifier: BigCardCell.identifier)
            collectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8)
            collectionView.backgroundColor = .white
            collectionView.showsVerticalScrollIndicator = false
        }
        
        private func setupNavigation() {
            title = selectedCategory?.strCategory
            let viewStyleButton = UIBarButtonItem(image: UIImage(named: "BigCard"), style: .plain, target: self, action: #selector(viewStyleButtonTapped(_:)))
            navigationItem.rightBarButtonItem = viewStyleButton
            navigationController?.navigationBar.tintColor = .black
        }
        
        private func navigationTitleAttributes() {
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        }
        
        @IBAction func viewStyleButtonTapped(_ sender: UIBarButtonItem) {
            listViewStyle = listViewStyle == .small ? .big : .small
            collectionView.reloadData()
            
            let buttonImage = listViewStyle == .small ? "BigCard" : "SmallCard"
            sender.image = UIImage(named: buttonImage)
        }
        
        // Inject view model (e.g., in app setup or via a coordinator)
        func configure(viewModel: ListViewModelProtocol) {
            self.viewModel = viewModel
        }
    }

    extension ListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
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
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            guard let selectedDrink = viewModel.getDrink(at: indexPath.row) else { return }
            showDetailViewController(with: selectedDrink.idDrink ?? "")
        }
        
        func showDetailViewController(with drinkId: String) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
            detailVC.cocktailId = drinkId
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }

    extension ListViewController: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width: CGFloat
            let height: CGFloat
            
            switch listViewStyle {
            case .small:
                width = (UIScreen.main.bounds.width - 32) / 3
                height = width / 2 * 3
            case .big:
                width = (UIScreen.main.bounds.width - 24) / 2
                height = width / 2 * 3
            }
            
            return CGSize(width: width, height: height)
        }
    }

    enum viewStyle {
        case small
        case big
    }
