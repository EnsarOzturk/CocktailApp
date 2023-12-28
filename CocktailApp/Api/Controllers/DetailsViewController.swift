//
//  DetailsViewController.swift
//  CocktailApp
//
//  Created by Ensar on 28.12.2023.
//

import UIKit
import SDWebImage

class DetailsViewController: UIViewController {
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    // features
    
    
    var cocktailId: String?
    var drink: DrinkDetail?
    let network = NetworkManager()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCocktailDetails()
        
    }
    
    func fetchCocktailDetails() {
        if let cocktailId = cocktailId {
            let endpoint = DetailEndpointItem.cocktailDetails(cocktailID: cocktailId)
            network.request(type: DetailResponse.self, item: endpoint) { [weak self] result in
                switch result {
                case .success(let response):
                    if let fetchDrink = response.drinks.first {
                    self?.drink = fetchDrink
                    self?.updateUI()
            }
                case .failure(let error):
                print("Error cocktail details: \(error)")
        }
      }
    }
  }
    
    func updateUI() {
        if let imageUrl = URL(string: drink?.strDrinkThumb ?? "") {
            imageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "Cocktail"))
        } else {
            
        }
        nameLabel.text = drink?.strDrink
    }
    
    @IBAction func recipeShowButton(_ sender: UIButton) {
        let recipe = drink?.strInstructions ?? "Sorry recipe not available :/"
        let alertController = UIAlertController(
                    title: "Drink Recipe",
                    message: recipe,
                    preferredStyle: .alert )
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alertController.addAction(okAction)
                
        let backAction = UIAlertAction(title: "Back to list", style: .default) { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            
    }
                alertController.addAction(backAction)
                present(alertController, animated: true, completion: nil)
    }
}
