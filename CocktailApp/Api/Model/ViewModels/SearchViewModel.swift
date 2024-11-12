
import Foundation
import Alamofire

protocol SearchViewModelProtocol: AnyObject {
    var cocktails: [Cocktail] { get set }
    var filteredCocktails: [Cocktail] { get set }
    var searchText: String { get set }
    var viewStyle: ListViewStyle { get set }

    func fetchCocktails(searchQuery: String, completion: @escaping (Result<Void, NetworkError>) -> Void)
    func filterCocktailsForSearchText(_ searchText: String)
    func getCocktail(at index: Int) -> Cocktail
    var numberOfItems: Int { get }
    var isFiltering: Bool { get }
    func toggleViewStyle()
}

final class SearchViewModel: SearchViewModelProtocol {
    let networkManager: NetworkManager
    var cocktails: [Cocktail] = []
    var filteredCocktails: [Cocktail] = []
    var searchText: String = ""
    var viewStyle: ListViewStyle = .small

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    func fetchCocktails(searchQuery: String, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        let endpoint = searchQuery.isEmpty ? SearchEndpointItem.popularCocktails : SearchEndpointItem.cocktailName(name: searchQuery)

        networkManager.request(type: SearchResponse.self, item: endpoint) { [weak self] result in
            switch result {
            case .success(let response):
                self?.cocktails = response.drinks
                completion(.success(()))
            case .failure(let error):
                if let afError = error as? AFError {
                    switch afError {
                    case .invalidURL:
                        completion(.failure(.invalidParameters))
                    case .responseSerializationFailed:
                        completion(.failure(.requestFailed))
                    default:
                        completion(.failure(.requestFailed))
                    }
                } else {
                    completion(.failure(.requestFailed))
                }
            }
        }
    }

    func filterCocktailsForSearchText(_ searchText: String) {
        self.searchText = searchText
        filteredCocktails = cocktails.filter { $0.strDrink.lowercased().contains(searchText.lowercased()) }
    }

    func getCocktail(at index: Int) -> Cocktail {
        return isFiltering ? filteredCocktails[index] : cocktails[index]
    }

    var numberOfItems: Int {
        return isFiltering ? filteredCocktails.count : cocktails.count
    }

    var isFiltering: Bool {
        return !searchText.isEmpty
    }

    func toggleViewStyle() {
        viewStyle = (viewStyle == .big) ? .small : .big
    }
}
