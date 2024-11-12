
import UIKit
import SDWebImage

final class SmallCardCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var view: UIView!
    
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
        // cell
        layer.borderWidth = 0.4
        layer.borderColor = UIColor.systemGray4.cgColor
        layer.cornerRadius = 3.0
    }
}
