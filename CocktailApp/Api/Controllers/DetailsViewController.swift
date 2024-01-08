//
//  DetailsViewController.swift
//  CocktailApp
//
//  Created by Ensar on 28.12.2023.
//

import UIKit
import SDWebImage

class DetailsViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var cocktailInfoStackView: UIStackView!
    @IBOutlet var contentsStackView: UIStackView!
    @IBOutlet var recipesStackView: UIStackView!
    @IBOutlet var recipeLabel: UILabel!
    var cocktailId: String?
    var drink: CocktailDetail?
    let network = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentsStackView.distribution = .fill
        recipesStackView.alignment = .fill
        recipesStackView.distribution = .fill
        recipesStackView.layoutIfNeeded()
        recipesStackView.spacing = 2.0
        cocktailInfoStackView.spacing = 2.0
        titleLabel.font = UIFont(name: "Arial", size: 25)
        navigationController?.navigationBar.tintColor = .black
        fetchCocktailDetails()
        
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
        if let cocktailId = cocktailId {
            let endpoint = DetailEndpointItem.cocktailDetails(cocktailID: cocktailId)
            network.request(type: CocktailDetailResponse.self, item: endpoint) { [weak self] result in
                switch result {
                case .success(let response):
                    if let drink = response.drinks.first {
                        self?.drink = drink
                        DispatchQueue.main.async {
                            self?.prepareCocktailContents(contents: drink.cocktailContents.filter { $0 != " "})
                            self?.prepareInformations(informations: drink.informations.filter { $0 != ""})
                            self?.titleLabel.text = drink.strDrink
                            self?.imageView.load(url: drink.strDrinkThumb)
                            self?.recipeLabel.text = drink.strInstructions
                        }
                    }
                case .failure(let error):
                    print("Error cocktail details: \(error)")
                }
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
}
