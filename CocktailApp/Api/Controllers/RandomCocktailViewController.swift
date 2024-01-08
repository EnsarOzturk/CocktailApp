//
//  RandomCocktailViewController.swift
//  CocktailApp
//
//  Created by Ensar on 3.01.2024.
//

import UIKit
import SDWebImage
import AVFoundation

class RandomCocktailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var button: UIButton!
    private let randomCocktailService = RandomCocktailService()
    private let network = NetworkManager()
    private var cocktails: [RandomCocktail] = []
    private var timer: Timer?
    private var audioPlayer: AVAudioPlayer?
    private let soundFileName = "Suffle"
    private let soundFileExtension = "mp3"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.layer.borderWidth = 0.1
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 4.0
        button.layer.borderWidth = 0.1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 40
        nameLabel.text = "Elderflower Caipirinha"
    }
    
    private func playSound() {
        guard let soundURL = Bundle.main.url(forResource: soundFileName, withExtension: soundFileExtension) else {
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
        }
    }
    
    private func stopSound() {
        audioPlayer?.stop()
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
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateRandomCocktail), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            self?.timer?.invalidate()
            self?.timer = nil
            self?.stopSound()
        }
        updateRandomCocktail()
    }
    
    @objc func updateRandomCocktail() {
        fetchRandomCocktail()
        playSound()
    }

    func fetchRandomCocktail() {
         randomCocktailService.getRandomCocktail { [weak self] result in
             switch result {
             case .success(let randomCocktailResponse):
                 if let randomCocktail = randomCocktailResponse.drinks.first {
                    self?.updateUI(with: randomCocktail)
                 }
             case .failure(let error):
                 self?.showError(message: "Error random cocktail: \(error.localizedDescription)")
             }
         }
     }
    func updateUI(with cocktail: RandomCocktail) {
           nameLabel.text = cocktail.strDrink
        
           if let imageUrl = URL(string: cocktail.strDrinkThumb ?? "") {
               imageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "defaultCocktail"))
           }
    }
    
    func showError(message: String) {
         let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
         let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
         alertController.addAction(okAction)
         present(alertController, animated: true, completion: nil)
     }
 }

