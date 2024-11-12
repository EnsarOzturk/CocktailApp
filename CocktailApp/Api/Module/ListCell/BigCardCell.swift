
import UIKit
import SDWebImage

final class BigCardCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var view: UIView!
    
    func configure(drink: Drink) {
        imageView.setImage(with: drink.strDrinkThumb)
        label.text = drink.strDrink
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateUI()
    }
    
    private func updateUI() {
        backgroundColor = UIColor.white
        // label
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = UIColor.white
        label.font = UIFont(name: "Apple Symbols", size: 20)
        // view
        view.layer.cornerRadius = 4
        view.backgroundColor = UIColor.white
        // cell
        layer.borderWidth = 0.4
        layer.borderColor = UIColor.systemGray5.cgColor
        layer.cornerRadius = 3.0
    }
}
