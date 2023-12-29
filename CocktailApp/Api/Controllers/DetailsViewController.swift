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
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var IBALabel: UILabel!
    @IBOutlet weak var alcoholicLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var featureView: UIView!
    
    // ıngeredients
    @IBOutlet weak var ıngredientLabel1: UILabel!
    @IBOutlet weak var ıngredientLabel2: UILabel!
    @IBOutlet weak var ıngredientLabel3: UILabel!
    @IBOutlet weak var ıngredientLabel4: UILabel!
    @IBOutlet weak var ıngredientLabel5: UILabel!
    @IBOutlet weak var ıngredientLabel6: UILabel!
    @IBOutlet weak var ıngredientLabel7: UILabel!
    @IBOutlet weak var ıngredientLabel8: UILabel!
    @IBOutlet weak var ıngredientLabel9: UILabel!
    @IBOutlet weak var ıngredientView: UIView!
    @IBOutlet weak var ıngredientImageView: UIImageView!
    
    // measure
    @IBOutlet weak var measureLabel1: UILabel!
    @IBOutlet weak var measureLabel2: UILabel!
    @IBOutlet weak var measureLabel3: UILabel!
    @IBOutlet weak var measureLabel4: UILabel!
    @IBOutlet weak var measureLabel5: UILabel!
    @IBOutlet weak var measureLabel6: UILabel!
    @IBOutlet weak var measureLabel7: UILabel!
    @IBOutlet weak var measureImageView: UIImageView!
    
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
        categoryLabel.text = drink?.strCategory
        IBALabel.text = drink?.strIBA ?? "-"
        alcoholicLabel.text = drink?.strAlcoholic
        dateLabel.text = drink?.dateModified
        
        ıngredientLabel1.text = drink?.strIngredient1
        ıngredientLabel2.text = drink?.strIngredient2
        ıngredientLabel3.text = drink?.strIngredient3
        ıngredientLabel4.text = drink?.strIngredient4
        ıngredientLabel5.text = drink?.strIngredient5
        ıngredientLabel6.text = drink?.strIngredient6
        ıngredientLabel7.text = drink?.strIngredient7
        ıngredientLabel8.text = drink?.strIngredient8
        ıngredientLabel9.text = drink?.strIngredient9
        
        measureLabel1.text = drink?.strMeasure1
        measureLabel2.text = drink?.strMeasure2
        measureLabel3.text = drink?.strMeasure3
        measureLabel4.text = drink?.strMeasure4
        measureLabel5.text = drink?.strMeasure5
        measureLabel6.text = drink?.strMeasure6
        measureLabel7.text = drink?.strMeasure7
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
