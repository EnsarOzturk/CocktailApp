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
    @IBOutlet var ingredientsStackView: UIStackView!
    @IBOutlet var measureStackView: UIStackView!
    
    
    var cocktailId: String?
    var drink: CocktailDetail?
    let network = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCocktailDetails()
        navigationController?.navigationBar.backgroundColor = UIColor.white
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
                            self?.prepareIngredients(ingredients: drink.ingredients.filter { $0 != "" })
                            self?.prepareMeasurements(measurements: drink.measurements.filter { $0 != "" })
                        }
                    }
                case .failure(let error):
                    print("Error cocktail details: \(error)")
                }
            }
        }
    }
    
    func prepareIngredients(ingredients: [String]) {
        
        for ingredient in ingredients {
            var label = UILabel()
            label.text = ingredient
            ingredientsStackView.addArrangedSubview(label)
        }
    }
    
    func prepareMeasurements(measurements: [String]) {
        for measurements in measurements {
            var label = UILabel()
            label.text = measurements
            measureStackView.addArrangedSubview(label)
        }
    }
}
