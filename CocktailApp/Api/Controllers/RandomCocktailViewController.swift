
import UIKit
import SDWebImage
import Alamofire
import AVFoundation

final class RandomCocktailViewController: UIViewController {
    var viewModel: RandomCocktailViewModel!
    let randomCocktailService = RandomCocktailService()
    private var timer: Timer?
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var button: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
            
            // Initialize ViewModel and UI components
            viewModel = RandomCocktailViewModel(randomCocktailService: randomCocktailService)
            
            // Style the background and UI elements
            view.backgroundColor = UIColor(named: "darkBackground")
            imageView.layer.borderWidth = 0.1
            imageView.layer.borderColor = UIColor.white.cgColor
            imageView.isUserInteractionEnabled = true
            imageView.contentMode = .scaleAspectFill
            imageView.layer.cornerRadius = 16
            imageView.layer.masksToBounds = true  // Rounded corners
            imageView.layer.shadowColor = UIColor.black.cgColor
            imageView.layer.shadowOffset = CGSize(width: 0, height: 4)
            imageView.layer.shadowOpacity = 0.3
            imageView.layer.shadowRadius = 5
            
            // Button styling
            button.layer.borderWidth = 0.6
            button.layer.borderColor = UIColor.white.cgColor
            button.backgroundColor = UIColor.black
            button.setTitle("Shuffle", for: .normal)
            button.setTitleColor(.white, for: .normal)
            
            // Make the button circular
            let buttonSize = min(button.frame.size.width, button.frame.size.height)
            button.layer.cornerRadius = buttonSize / 2

            // Styling the name label
            nameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 24)
            nameLabel.textColor = UIColor.white
            nameLabel.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            nameLabel.layer.cornerRadius = 10
            nameLabel.layer.masksToBounds = true
            
            // Add a tap gesture recognizer to the image view for navigation
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
            imageView.addGestureRecognizer(tapGestureRecognizer)
            
            // Set initial text
            nameLabel.text = "Elderflower Caipirinha"
        }
        
        // Configure tab bar appearance when view appears
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            tabBarController?.tabBar.barTintColor = UIColor.black
            tabBarController?.tabBar.tintColor = UIColor.white
        }
        
        // Reset tab bar appearance when view disappears
        override func viewWillDisappear(_ animated: Bool) {
            tabBarController?.tabBar.barTintColor = UIColor.white
            tabBarController?.tabBar.tintColor = UIColor.black
        }

        // Button action to shuffle and update cocktail
        @IBAction func bringRandomButtonTapped(_ sender: UIButton) {
            UIView.animate(withDuration: 0.2, animations: {
                sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }) { _ in
                UIView.animate(withDuration: 0.2) {
                    sender.transform = CGAffineTransform.identity
                }
                self.startUpdatingCocktails()  // Start updating cocktails
            }
        }

        // Start updating cocktails with a timer
        func startUpdatingCocktails() {
            timer?.invalidate()
            timer = nil
            timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateRandomCocktail), userInfo: nil, repeats: true)
            RunLoop.main.add(timer!, forMode: .common)
            
            // Stop after 3 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
                self?.timer?.invalidate()
                self?.timer = nil
            }
            updateRandomCocktail()
        }
        
        // Tap gesture handler to show details for the cocktail
        @objc func imageViewTapped() {
            guard let cocktailId = viewModel.randomCocktail?.idDrink else {
                print("No cocktail ID found")
                return
            }
            
            print("Navigating to details with cocktail ID: \(cocktailId)")
            navigateToDetailsViewController(cocktailId: cocktailId)
        }
        
        // Function to navigate to the cocktail details view
        func navigateToDetailsViewController(cocktailId: String) {
            if let detailsVC = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController {
                detailsVC.cocktailId = cocktailId
                navigationController?.pushViewController(detailsVC, animated: true)
            } else {
                print("DetailsViewController not loaded")
            }
        }

        // Update the random cocktail data
        @objc func updateRandomCocktail() {
            viewModel.fetchRandomCocktail { [weak self] result in
                switch result {
                case .success(let randomCocktail):
                    self?.updateUI(with: randomCocktail)
                case .failure(let error):
                    print("Error fetching random cocktail: \(error.localizedDescription)")
                }
            }
        }
        
        // Update UI components with new cocktail data
        func updateUI(with cocktail: RandomCocktail) {
            nameLabel.alpha = 0.0
            imageView.alpha = 0.0
            
            // Update the cocktail name
            nameLabel.text = cocktail.strDrink
            
            // Animate name label fade-in
            UIView.animate(withDuration: 0.5, animations: {
                self.nameLabel.alpha = 1.0
            })
            
            // Load the cocktail image with animation
            if let imageUrl = URL(string: cocktail.strDrinkThumb ?? "") {
                imageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "defaultCocktail")) { [weak self] _, _, _, _ in
                    UIView.transition(with: self!.imageView, duration: 0.5, options: .transitionCrossDissolve, animations: {
                        self?.imageView.alpha = 1.0
                    })
                }
            }
        }
}
