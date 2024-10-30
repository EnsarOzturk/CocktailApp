//
//  CocktailTimer.swift
//  CocktailApp
//
//  Created by Ensar on 30.10.2024.
//

import Foundation
import Combine

class CocktailTimer: ObservableObject {
    @Published var isUpdating = false
    private var timer: Timer?
    private var viewModel: RandomCocktailViewModel

    init(viewModel: RandomCocktailViewModel) {
        self.viewModel = viewModel
    }

    // hız
    func startUpdatingCocktails() {
        isUpdating = true
        timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { [weak self] _ in
            self?.fetchRandomCocktail()
        }
        
        // zamanlayıcı süresi 2 saniye
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.stopUpdatingCocktails()
        }
    }

    func stopUpdatingCocktails() {
        isUpdating = false
        timer?.invalidate()
        timer = nil
    }
    
    private func fetchRandomCocktail() {
        viewModel.fetchRandomCocktail { result in
            switch result {
            case .success(let cocktail):
                print("Cocktail: \(cocktail.strDrink)")
            case .failure(let error):
                print("Error fetch cocktail: \(error.localizedDescription)")
            }
        }
    }
}

