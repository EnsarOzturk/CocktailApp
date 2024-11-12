
import UIKit
import SDWebImage

final class SearchListCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var view: UIView!
    
    struct Constant {
        static let borderWidth: Double = 0.4
        static let cornerRadius: Double = 3.0
    }
    
    func configure(with cocktail: Cocktail) {
        imageView.setImage(with: cocktail.strDrinkThumb)
        label.text = cocktail.strDrink
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateUI()
    }
    
    private func updateUI() {
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .white
        view.backgroundColor = .white
        // image
        imageView.contentMode = .scaleAspectFill
        //cell
        layer.borderWidth = Constant.borderWidth
        layer.cornerRadius = Constant.cornerRadius
        layer.borderColor = UIColor.systemGray4.cgColor
    }
}
