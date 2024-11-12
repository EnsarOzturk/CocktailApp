
import UIKit
import SDWebImage

final class DetailsViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var cocktailInfoStackView: UIStackView!
    @IBOutlet var contentsStackView: UIStackView!
    @IBOutlet var recipesStackView: UIStackView!
    @IBOutlet var recipeLabel: UILabel!
    
    var cocktailId: String?
        var viewModel: DetailsViewModelProtocol!

        override func viewDidLoad() {
            super.viewDidLoad()
            
            setupUI()
            fetchCocktailDetails()
        }

        private func setupUI() {
            contentsStackView.distribution = .fill
            recipesStackView.alignment = .fill
            recipesStackView.distribution = .fill
            recipesStackView.layoutIfNeeded()
            recipesStackView.spacing = 2.0
            cocktailInfoStackView.spacing = 2.0
            titleLabel.font = UIFont(name: "Arial", size: 25)
            navigationController?.navigationBar.tintColor = .black
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            navigationController?.navigationBar.prefersLargeTitles = false
        }

        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            recipesStackView.arrangedSubviews.forEach { subview in
                if let label = subview as? UILabel {
                    label.preferredMaxLayoutWidth = recipesStackView.bounds.width
                }
            }
            recipesStackView.layoutIfNeeded()
        }

        func fetchCocktailDetails() {
            viewModel.fetchCocktailDetails { [weak self] result in
                switch result {
                case .success(let drink):
                    DispatchQueue.main.async {
                        self?.prepareCocktailContents(contents: drink.cocktailContents.filter { $0 != " " })
                        self?.prepareInformations(informations: drink.informations.filter { $0 != "" })
                        self?.titleLabel.text = drink.strDrink
                        self?.imageView.load(url: drink.strDrinkThumb)
                        self?.recipeLabel.text = drink.strInstructions
                    }
                case .failure(let error):
                    print("Error fetching cocktail details: \(error)")
                    // Handle the error (e.g., show an alert)
                }
            }
        }
            
        func prepareCocktailContents(contents: [String]) {
            for content in contents {
                let label = UILabel()
                label.text = "• \(content)"
                label.numberOfLines = 0
                contentsStackView.addArrangedSubview(label)
            }
        }

        func prepareInformations(informations: [String]) {
            for information in informations {
                let label = UILabel()
                label.text = "• \(information)"
                cocktailInfoStackView.addArrangedSubview(label)
            }
            let view = UIView()
            view.backgroundColor = .clear
            cocktailInfoStackView.addArrangedSubview(view)
        }
        
        // Inject view model (e.g., in app setup or via a coordinator)
        func configure(viewModel: DetailsViewModelProtocol) {
            self.viewModel = viewModel
        }
    }
