//
//  RandomCocktailViewController.swift
//  CocktailApp
//
//  Created by Ensar on 3.01.2024.
//

import UIKit
import SDWebImage

class RandomCocktailViewController: UIViewController {
  
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    private let randomCocktailService = RandomCocktailService()
    private let network = NetworkManager()
    private var cocktails: [RandomCocktail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func bringRandomButtonTapped(_ sender: UIButton) {
        fetchRandomCocktail()
    }
    
    func fetchRandomCocktail() {
         randomCocktailService.getRandomCocktail { [weak self] result in
             switch result {
             case .success(let randomCocktailResponse):
                 if let randomCocktail = randomCocktailResponse.drinks.first {
                     self?.updateUI(with: randomCocktail)
                 } else {
                     self?.showError(message: "No random cocktails found.")
                 }
             case .failure(let error):
                 self?.showError(message: "Error fetching random cocktail: \(error.localizedDescription)")
             }
         }
     }
    
    func updateUI(with cocktail: RandomCocktail) {
           nameLabel.text = cocktail.strDrink
           if let imageUrl = URL(string: cocktail.strDrinkThumb ?? "") {
               imageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
           }
       }
    
    func showError(message: String) {
         let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
         let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
         alertController.addAction(okAction)
         present(alertController, animated: true, completion: nil)
     }
 }

