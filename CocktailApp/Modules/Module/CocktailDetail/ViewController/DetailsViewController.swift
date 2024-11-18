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
        // Title Label Styling
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 24)
        titleLabel.textColor = UIColor.label // Dinamik text rengi
        titleLabel.backgroundColor = .clear

        // Title View Styling
        titleView.layer.borderWidth = 0.5
        titleView.backgroundColor = UIColor.detailCellBackgroundColor// Dinamik arka plan rengi
        titleView.layer.borderColor = UIColor.customBorderColor.cgColor // Dinamik sınır rengi
        titleView.layer.cornerRadius = 6.0

        // Cocktail Info StackView Styling
        cocktailInfoStackView.spacing = 8.0
        cocktailInfoStackView.backgroundColor = UIColor.detailCellBackgroundColor // Dinamik arka plan rengi

        // Image View Styling
        imageView.layer.cornerRadius = 8.0
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.separator.cgColor // Dinamik sınır rengi
        imageView.layer.borderWidth = 0.3

        // Image Content View Styling
        imageContentView.layer.cornerRadius = 6.0
        imageContentView.layer.borderWidth = 0.5
        imageContentView.layer.borderColor = UIColor.customBorderColor.cgColor // Dinamik sınır rengi
        imageContentView.backgroundColor = UIColor.detailCellBackgroundColor // Dinamik arka plan rengi

        // Contents StackView Styling
        contentsStackView.distribution = .fill
        contentsStackView.backgroundColor = UIColor.detailCellBackgroundColor // Dinamik arka plan rengi
        contentsStackView.layer.borderWidth = 0.5
        contentsStackView.layer.borderColor = UIColor.customBorderColor.cgColor // Dinamik sınır rengi
        contentsStackView.layer.cornerRadius = 6.0

        // Recipes StackView Styling
        recipesStackView.alignment = .fill
        recipesStackView.distribution = .fill
        recipesStackView.spacing = 8.0
        recipesStackView.backgroundColor = UIColor.detailCellBackgroundColor // Dinamik arka plan rengi
        recipesStackView.layer.borderWidth = 0.5
        recipesStackView.layer.borderColor = UIColor.customBorderColor.cgColor // Dinamik sınır rengi
        recipesStackView.layer.cornerRadius = 6.0

        // Background and Navigation Bar
        view.backgroundColor = UIColor.systemBackground // Dinamik arka plan rengi
        navigationController?.navigationBar.tintColor = UIColor.label // Dinamik metin rengi
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
