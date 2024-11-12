
import UIKit
import SDWebImage

final class ListCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var view: UIView!
    
    struct Constant {
        static let labelFont: String = "Apple Symbols"
        static let labelSize: Double = 15
    }
  
    func configure(drink: Drink) {
        imageView.setImage(with: drink.strDrinkThumb)
        label.text = drink.strDrink
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateUI()
    }
    
    private func updateUI() {
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = UIColor.systemBackground
        label.font = UIFont(name: Constant.labelFont, size: Constant.labelSize)
        // view
        view.layer.cornerRadius = 0.2
        // cell
        layer.borderWidth = 0.4
        layer.borderColor = UIColor.systemGray4.cgColor
        layer.cornerRadius = 3.0
    }
}

