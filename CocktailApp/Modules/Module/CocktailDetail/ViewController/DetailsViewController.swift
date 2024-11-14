//
//  DetailsViewController.swift
//  CocktailApp
//
//  Created by Ensar on 28.12.2023.
//

import UIKit
import SDWebImage

final class DetailsViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var titleView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var imageContentView: UIView!
    @IBOutlet var cocktailInfoStackView: UIStackView!
    @IBOutlet var contentsStackView: UIStackView!
    @IBOutlet var recipesStackView: UIStackView!
    @IBOutlet var recipeLabel: UILabel!
    
    private var viewModel: DetailViewModelProtocol!
    var cocktailId: String?

    override func viewDidLoad() {
        super.viewDidLoad()
            
        setupViewModel()
        setupUI()
        fetchCocktailDetails()
    }
    
    private func setupUI() {
        
        titleLabel.font = UIFont(name: "Arial", size: 25)
        titleLabel.backgroundColor = .systemBackground
        titleView.layer.borderWidth = 0.2
        titleView.backgroundColor = .systemBackground
        titleView.layer.borderColor = UIColor.lightGray.cgColor
        titleView.layer.cornerRadius = 4.0
        
        cocktailInfoStackView.spacing = 2.0
        cocktailInfoStackView.backgroundColor = .systemBackground
        cocktailInfoStackView.layer.cornerRadius = 4.0
        cocktailInfoStackView.layer.borderColor = UIColor.lightGray.cgColor
        cocktailInfoStackView.layer.borderWidth = 0.2
        
        imageView.layer.cornerRadius = 4.0
        imageContentView.layer.borderWidth = 0.2
        imageContentView.layer.borderColor = UIColor.lightGray.cgColor
        imageContentView.backgroundColor = .systemBackground
        
        contentsStackView.distribution = .fill
        contentsStackView.backgroundColor = .systemBackground
        contentsStackView.layer.borderWidth = 0.2
        contentsStackView.layer.borderColor = UIColor.lightGray.cgColor
        contentsStackView.layer.cornerRadius = 4.0
        
        recipesStackView.alignment = .fill
        recipesStackView.distribution = .fill
        recipesStackView.spacing = 2.0
        recipesStackView.backgroundColor = .systemBackground
        recipesStackView.layer.borderWidth = 0.2
        recipesStackView.layer.borderColor = UIColor.lightGray.cgColor
        recipesStackView.layer.cornerRadius = 4.0
        
        view.backgroundColor = .systemBackground
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
    
    private func setupViewModel() {
        viewModel = DetailViewModel(networkManager: NetworkManager(), cocktailId: cocktailId)
    }
   
    private func fetchCocktailDetails() {
        viewModel.fetchCocktailDetails { [weak self] result in
            switch result {
            case .success(let drink):
                DispatchQueue.main.async {
                    self?.configureView(with: drink)
                }
            case .failure(let error):
                print("Error fetching cocktail details: \(error)")
            }
        }
    }
    
    private func configureView(with drink: CocktailDetail) {
        titleLabel.text = drink.strDrink
        imageView.sd_setImage(with: URL(string: drink.strDrinkThumb ?? ""))
        recipeLabel.text = drink.strInstructions
        prepareCocktailContents(contents: drink.cocktailContents.filter { !$0.isEmpty })
        prepareInformations(informations: drink.informations.filter { !$0.isEmpty })
        }
        
    private func prepareCocktailContents(contents: [String]) {
        contentsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        let filteredContents = contents.filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }
        for content in filteredContents {
            let label = UILabel()
            label.text = "• \(content)"
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
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
}
