
import Foundation
import Alamofire

protocol ListViewModelProtocol: AnyObject {
    var selectedCategory: Category? { get set }
    var drinks: [Drink] { get }
    var didUpdateDrinks: ((Result<Void, NetworkError>) -> Void)? { get set }
    
    func fetchDrinks()
    func getDrink(at index: Int) -> Drink?
    func numberOfDrinks() -> Int
}

final class ListViewModel: ListViewModelProtocol {
    private let networkManager: NetworkManager
    private(set) var drinks: [Drink] = []
    var selectedCategory: Category?
    
    var didUpdateDrinks: ((Result<Void, NetworkError>) -> Void)?
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchDrinks() {
        guard let selectedCategory = selectedCategory,
              let originalCategory = selectedCategory.strCategory else {
            didUpdateDrinks?(.failure(.invalidParameters))
            return
        }
        
        let endpoint = ListEndpointItem(category: originalCategory.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        networkManager.request(type: ListResponse.self, item: endpoint) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                if let fetchedDrinks = response.drinks {
                    self.drinks = fetchedDrinks
                    self.didUpdateDrinks?(.success(()))
                } else {
                    self.didUpdateDrinks?(.failure(.noData))
                }
            case .failure:
                self.didUpdateDrinks?(.failure(.requestFailed))
            }
        }
    }
    
    func getDrink(at index: Int) -> Drink? {
        guard index >= 0, index < drinks.count else {
            return nil
        }
        return drinks[index]
    }
    
    func numberOfDrinks() -> Int {
        return drinks.count
    }
}

