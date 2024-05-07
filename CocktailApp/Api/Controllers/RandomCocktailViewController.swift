//
//  RandomCocktailViewController.swift
//  CocktailApp
//
//  Created by Ensar on 3.01.2024.
//

import UIKit
import SDWebImage
import Alamofire
import AVFoundation

class RandomCocktailViewController: UIViewController {
    var viewModel: RandomCocktailViewModel!
    let randomCocktailService = RandomCocktailService()
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var button: UIButton!
    
    private var timer: Timer?
    private var audioPlayer: AVAudioPlayer?
    private let soundFileName = "Suffle"
    private let soundFileExtension = "mp3"

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = RandomCocktailViewModel(randomCocktailService: randomCocktailService)
        imageView.layer.borderWidth = 0.1
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 2.0
        button.layer.borderWidth = 0.2
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 30
        nameLabel.text = "Elderflower Caipirinha"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.barTintColor = UIColor.black
        tabBarController?.tabBar.tintColor = UIColor.white
    }

    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.barTintColor = UIColor.white
        tabBarController?.tabBar.tintColor = UIColor.black
    }

        @IBAction func bringRandomButtonTapped(_ sender: UIButton) {
            startUpdatingCocktails()
        }

    func startUpdatingCocktails() {
        timer?.invalidate()
        timer = nil
        timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(updateRandomCocktail), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.timer?.invalidate()
            self?.timer = nil
        }
        updateRandomCocktail()
    }

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

    func updateUI(with cocktail: RandomCocktail) {
        nameLabel.text = cocktail.strDrink

        if let imageUrl = URL(string: cocktail.strDrinkThumb ?? "") {
            imageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "defaultCocktail"))
        }
    }
}
