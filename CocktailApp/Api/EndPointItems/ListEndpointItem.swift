
import Foundation

struct ListEndpointItem: Endpoint {
    var path: String {
        return "/filter.php?c=\(category)"
    }

    let category: String

    init(category: String) {
        self.category = category
    }
}
