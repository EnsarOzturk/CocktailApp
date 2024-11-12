
import Foundation
import Alamofire

protocol CategoryViewModelProtocol: AnyObject {
    var categories: [Category] { get }
    var didUpdateCategories: ((Result<Void, NetworkError>) -> Void)? { get set }
    
    func fetchCategories()
    func getCategory(at index: Int) -> Category?
    func numberOfCategories() -> Int
}

final class CategoryViewModel: CategoryViewModelProtocol {
    private let networkManager: NetworkManager
    private(set) var categories: [Category] = []
    
    var didUpdateCategories: ((Result<Void, NetworkError>) -> Void)?
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchCategories() {
        networkManager.request(type: CategoryResponse.self, item: CategoryEndpointItem()) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                if let fetchedCategories = response.drinks {
                    self.categories = fetchedCategories
                    self.didUpdateCategories?(.success(()))
                } else {
                    self.didUpdateCategories?(.failure(.noData))
                }
            case .failure:
                self.didUpdateCategories?(.failure(.requestFailed))
            }
        }
    }
    
    func getCategory(at index: Int) -> Category? {
        guard index >= 0, index < categories.count else {
            return nil
        }
        return categories[index]
    }
    
    func numberOfCategories() -> Int {
        return categories.count
    }
}

