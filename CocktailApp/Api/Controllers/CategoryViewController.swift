
import UIKit

final class CategoryViewController: UIViewController{
    @IBOutlet weak var collectionView: UICollectionView!
    private var viewModel: CategoryViewModelProtocol!

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = UIColor.white
            title = "Categories"
            setupCollectionView()
            setupBindings()
            viewModel.fetchCategories()
        }
        
        private func setupBindings() {
            viewModel.didUpdateCategories = { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        self?.collectionView.reloadData()
                    case .failure(let error):
                        print("Error fetching categories: \(error)")
                        // Handle error, show alert if needed
                    }
                }
            }
        }

        private func setupCollectionView() {
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: CategoryCell.identifier)
            collectionView.showsVerticalScrollIndicator = false
            collectionView.backgroundColor = UIColor.white
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        // Inject view model (e.g., from a coordinator or directly in app setup)
        func configure(viewModel: CategoryViewModelProtocol) {
            self.viewModel = viewModel
        }
    }

    extension CategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return viewModel.numberOfCategories()
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else {
                fatalError("Error dequeuing CategoryCell")
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
    }

    extension CategoryViewController: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = (UIScreen.main.bounds.width - 48) / 3
            let height = width / 2 * 3.5
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
