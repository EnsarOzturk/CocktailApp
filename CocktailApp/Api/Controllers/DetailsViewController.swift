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
    @IBOutlet weak var glassLabel: UILabel!
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
    @IBOutlet weak var measureView: UIView!
    @IBOutlet weak var measureImageView: UIImageView!
    
    // recipe
    @IBOutlet weak var recibeButton: UIButton!
    @IBOutlet weak var recipeView: UIView!
    
    
    var cocktailId: String?
    var drink: DrinkDetail?
    let network = NetworkManager()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCocktailDetails()
        designComponents()
        navigationController?.navigationBar.backgroundColor = UIColor.white

     
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
        glassLabel.text = drink?.strGlass
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
    
    func designComponents() {
        featureView.layer.cornerRadius = 6
        featureView.layer.borderWidth = 0.2
        featureView.layer.borderColor = UIColor.brown.cgColor
        
        imageView.layer.cornerRadius = 6
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.darkGray.cgColor
        
        ıngredientView.layer.cornerRadius = 6
        ıngredientImageView.layer.cornerRadius = 6
        ıngredientView.layer.borderWidth = 0.5
        ıngredientView.layer.borderColor = UIColor.black.cgColor
        
        measureView.layer.cornerRadius = 6
        measureImageView.layer.cornerRadius = 6
        measureView.layer.borderWidth = 1
        measureView.layer.borderColor = UIColor.darkGray.cgColor
        
        recipeView.layer.cornerRadius = 6
        
        configureMeasureLabel(label: measureLabel1)
        configureMeasureLabel(label: measureLabel2)
        configureMeasureLabel(label: measureLabel3)
        configureMeasureLabel(label: measureLabel4)
        configureMeasureLabel(label: measureLabel5)
        configureMeasureLabel(label: measureLabel6)
        configureMeasureLabel(label: measureLabel7)
        
        configureIngredientLabel(label: ıngredientLabel1)
        configureIngredientLabel(label: ıngredientLabel2)
        configureIngredientLabel(label: ıngredientLabel3)
        configureIngredientLabel(label: ıngredientLabel4)
        configureIngredientLabel(label: ıngredientLabel5)
        configureIngredientLabel(label: ıngredientLabel6)
        configureIngredientLabel(label: ıngredientLabel7)
        configureIngredientLabel(label: ıngredientLabel8)
        configureIngredientLabel(label: ıngredientLabel9)
        
        configureFeaturesLabel(label: categoryLabel)
        configureFeaturesLabel(label: IBALabel)
        configureFeaturesLabel(label: alcoholicLabel)
        configureFeaturesLabel(label: glassLabel)
        configureFeaturesLabel(label: dateLabel)
        
        nameLabelDesign()
        
    }
    
    func nameLabelDesign() {
        nameLabel.layer.borderWidth = 0.3
        nameLabel.layer.borderColor = UIColor.darkGray.cgColor
        nameLabel.layer.cornerRadius = 6
    }
    
    func configureMeasureLabel(label: UILabel?) {
        label?.layer.borderWidth = 0.5
        label?.layer.borderColor = UIColor.white.cgColor
        label?.layer.cornerRadius = 4
    }
    
    func configureIngredientLabel(label: UILabel?) {
        label?.layer.borderWidth = 0.3
        label?.layer.borderColor = UIColor.black.cgColor
        label?.layer.cornerRadius = 4
    }
    
    func configureFeaturesLabel(label: UILabel?) {
        label?.layer.borderWidth = 0.2
        label?.layer.borderColor = UIColor.black.cgColor
        label?.layer.cornerRadius = 4
    }
    
    @IBAction func recipeShowButton(_ sender: UIButton) {
        let recipe = drink?.strInstructions ?? "Sorry recipe not available :/"
        let popUpVC = UIViewController()
        popUpVC.view.backgroundColor = .white
        
        let recipeLabel = UILabel()
        recipeLabel.text = recipe
        recipeLabel.font = UIFont.systemFont(ofSize: 20)
        recipeLabel.textAlignment = .center
        recipeLabel.numberOfLines = 0
        popUpVC.view.addSubview(recipeLabel)
        
        recipeLabel.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    recipeLabel.centerXAnchor.constraint(equalTo: popUpVC.view.centerXAnchor),
                    recipeLabel.centerYAnchor.constraint(equalTo: popUpVC.view.centerYAnchor),
                    recipeLabel.widthAnchor.constraint(equalTo: popUpVC.view.widthAnchor, constant: -20)
                ])
       
        popUpVC.preferredContentSize = CGSize(width: 300, height: 200)
        popUpVC.view.layer.cornerRadius = 10
        
        popUpVC.modalPresentationStyle = .popover
                if let popoverPresentationController = popUpVC.popoverPresentationController {
                    popoverPresentationController.sourceView = sender
                    popoverPresentationController.sourceRect = sender.bounds
                    popoverPresentationController.permittedArrowDirections = [.up]
                    present(popUpVC, animated: true, completion: nil)
                }
            }
    }

