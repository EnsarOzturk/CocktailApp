
import UIKit
import SDWebImage

struct RandomConstants {
    //button
    static let buttonTitle: String = "Shuffle"
    static let buttonBorderWidth: Double = 0.6
    //image
    static let defaultCocktail: String = "MeasureBackground"
    static let imageRadius: Double = 16
    static let imageShadowRadius: Double = 5
    static let imageShadowWidth: Double = 0
    static let imageShadowHeight: Double = 4
    static let imageShadowOpacity: Double = 0.3
    static let imageAlpha: Double = 0.0
    static let imageBorderWidth: Double = 0.5
    //label
    static let labelFont: String = "HelveticaNeue-Bold"
    static let labeltext: String = ""
    static let labelSize: Double = 24
    static let labelRadius: Double = 10
    static let labelColorAlpha: Double = 0.6
    static let labelAlpha: Double = 0.0
    //view
    static let viewColor: UIColor = UIColor.white
    //animations
    static let withDuration: Double = 0.2
    static let transformScaleX: Double = 0.9
    static let transformY: Double = 0.9
    static let timeInterval: Double = 0.5
    static let timerDeadline: Double = 3.0
    //detailVC
    static let detailVcIdentifier: String = "DetailsViewController"
}

final class RandomCocktailViewController: UIViewController {
    var viewModel: RandomCocktailViewModelProtocol!
    let randomCocktailService = RandomCocktailService()
    private var timer: Timer?
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        viewModel = RandomCocktailViewModel(randomCocktailService: randomCocktailService)
    }
    
    private func updateUI() {
        updateView()
        updateLabel()
        updateButton()
        updateImage()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            updateUI()
        }
    }
    
    private func updateImage() {
        imageView.layer.borderWidth = RandomConstants.imageBorderWidth
        imageView.layer.borderColor = UIColor.randomBorderColor.cgColor
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = RandomConstants.imageRadius
        imageView.layer.masksToBounds = true
        imageView.layer.shadowColor = UIColor.randomBorderColor.cgColor
        imageView.layer.shadowOffset = CGSize(width: RandomConstants.imageShadowWidth, height: RandomConstants.imageShadowHeight)
        imageView.layer.shadowOpacity = Float(RandomConstants.imageShadowOpacity)
        imageView.layer.shadowRadius = RandomConstants.imageShadowRadius
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        imageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func updateButton() {
        button.layer.borderWidth = RandomConstants.buttonBorderWidth
        button.layer.borderColor = UIColor.randomBorderColor.cgColor
        button.backgroundColor = .randomBackgroundColor
        button.setTitle(RandomConstants.buttonTitle, for: .normal)
        button.setTitleColor(.randomTextColor, for: .normal)
        
        // Make the button circular
        let buttonSize = min(button.frame.size.width, button.frame.size.height)
        button.layer.cornerRadius = buttonSize / 2
    }
    
    private func updateLabel() {
        nameLabel.font = UIFont(name: RandomConstants.labelFont, size: RandomConstants.labelSize)
        nameLabel.textColor = .randomTextColor
        nameLabel.backgroundColor = .randomBackgroundColor
        nameLabel.layer.cornerRadius = RandomConstants.labelRadius
        nameLabel.layer.masksToBounds = true
        nameLabel.text = RandomConstants.labeltext
    }
    
    private func updateView() {
        view.backgroundColor = .randomBackgroundColor
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .randomTextColor
        navigationController?.navigationBar.backgroundColor = .randomBackgroundColor
        title = "Random Cocktail"
    }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            tabBarController?.tabBar.barTintColor = .randomBackgroundColor
            tabBarController?.tabBar.tintColor = .randomTextColor
        }
    

    // Button action to shuffle and update cocktail
    @IBAction func bringRandomButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: RandomConstants.withDuration, animations: {
            sender.transform = CGAffineTransform(scaleX: RandomConstants.transformScaleX, y: RandomConstants.transformY)
        }) { _ in
            UIView.animate(withDuration: RandomConstants.withDuration) {
                sender.transform = CGAffineTransform.identity
            }
            self.startUpdatingCocktails()  // Start updating cocktails
        }
    }
    
    // Start updating cocktails with a timer
    func startUpdatingCocktails() {
        timer?.invalidate()
        timer = nil
        timer = Timer.scheduledTimer(timeInterval: RandomConstants.timeInterval, target: self, selector: #selector(updateRandomCocktail), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
        
        // Stop after 3 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + RandomConstants.timerDeadline) { [weak self] in
            self?.timer?.invalidate()
            self?.timer = nil
        }
        updateRandomCocktail()
    }
    
    // Tap gesture handler to show details for the cocktail
    @objc func imageViewTapped() {
        guard let cocktailId = viewModel.randomCocktail?.idDrink else {
            return
        }
        navigateToDetailsViewController(cocktailId: cocktailId)
    }
    
    // Function to navigate to the cocktail details view
    func navigateToDetailsViewController(cocktailId: String) {
        if let detailsVC = storyboard?.instantiateViewController(withIdentifier: RandomConstants.detailVcIdentifier) as? DetailsViewController {
            detailsVC.cocktailId = cocktailId
            navigationController?.pushViewController(detailsVC, animated: true)
        } else {
            print("DetailsViewController not loaded")
        }
    }
    // Update the random cocktail data
    @objc func updateRandomCocktail() {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        viewModel.fetchRandomCocktail { [weak self] result in
            DispatchQueue.main.async {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
                switch result {
                case .success(let randomCocktail):
                    self?.updateUI(with: randomCocktail)
                case .failure(let error):
                print("Error fetching random cocktail: \(error.localizedDescription)")
                }
            }
        }
    }
        
        // Update UI components with new cocktail data
    func updateUI(with cocktail: RandomCocktail) {
        nameLabel.alpha = RandomConstants.labelAlpha
        imageView.alpha = RandomConstants.imageAlpha
            
        // Update the cocktail name
        nameLabel.text = cocktail.strDrink
            
        // Animate name label fade-in
        UIView.animate(withDuration: RandomConstants.withDuration, animations: {
            self.nameLabel.alpha = 1.0
        })
            
        // Load the cocktail image with animation
        if let imageUrl = URL(string: cocktail.strDrinkThumb ?? "") {
            imageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: RandomConstants.defaultCocktail)) { [weak self] _, _, _, _ in
                
                UIView.transition(with: self!.imageView, duration: RandomConstants.withDuration, options: .transitionCrossDissolve, animations: {
                        
                    self?.imageView.alpha = 1.0
                })
            }
        }
    }
}
