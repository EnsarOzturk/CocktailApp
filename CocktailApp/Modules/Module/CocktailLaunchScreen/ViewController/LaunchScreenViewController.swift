import UIKit

final class LaunchScreenViewController: UIViewController {
    
    struct Constants {
        //constraint
        static let widthAnchor: Double = 100
        static let centerYAnchor: Double = -50
        static let heightAnchor: Double = 300
        //image
        static let imageNamed: String = "empty_glass"
        // Animations
        static let particleName: String = "particle"
        static let emitterwidth: Double = 70
        static let emitterheight: Double = 1
        static let emitterForKey: String = "moveDown"
        static let moveDownKeyPath: String = "emitterPosition.y"
        //label
        static let footerLabelText: String = "Product by Ensar Ozturk"
        static let footerLabelFont: String = "Apple Symbols"
        static let footerLabelSize: Double = 16
    }
    
    // Açılış ekranımda görüntülenecek bardak görüntüsü
    let glassImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: Constants.imageNamed))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var emitterLayer: CAEmitterLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(glassImageView)
        setupProductLabel()
        // Bardak görünümü için kısıtlamalar
        NSLayoutConstraint.activate([
            glassImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            glassImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: Constants.centerYAnchor),
            glassImageView.widthAnchor.constraint(equalToConstant: Constants.widthAnchor),
            glassImageView.heightAnchor.constraint(equalToConstant: Constants.heightAnchor)
        ])
        // Görünümü başlat
        setupEmitter()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateGlass()
    }
    
    private func setupProductLabel() {
        let footerLabel = UILabel()
        footerLabel.text = Constants.footerLabelText
        footerLabel.font = UIFont(name: Constants.footerLabelText, size: Constants.footerLabelSize)
        footerLabel.textColor = .darkGray // Adjust the color as needed
        footerLabel.textAlignment = .center
        footerLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(footerLabel)
        
        NSLayoutConstraint.activate([
            footerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            footerLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
    
    private func setupEmitter() {
        emitterLayer = CAEmitterLayer()
        emitterLayer.emitterPosition = CGPoint(x: view.bounds.midX, y: view.bounds.height / 2 + 50)
        emitterLayer.emitterSize = CGSize(width: Constants.emitterwidth, height: Constants.emitterheight)
        emitterLayer.emitterShape = .rectangle
        // Parçacık özelliklerini yapılandır
        let particle = CAEmitterCell()
        particle.contents = UIImage(named: Constants.particleName)?.cgImage
        particle.birthRate = 12
        particle.lifetime = 0.2
        particle.velocity = 0.1
        particle.velocityRange = 0.1
        particle.emissionRange = .pi / 2
        particle.scale = 0.01
        particle.scaleRange = 0.06
        
        emitterLayer.emitterCells = [particle]
        view.layer.addSublayer(emitterLayer)
        emitterLayer.birthRate = 0 // Başlangıçta parçacık yayılmaz
    }
    
    private func animateGlass() {
        // Bardak görünümünü döndür
        UIView.animate(withDuration: 1.5, delay: 0, options: [.curveEaseInOut], animations: {
            self.glassImageView.transform = CGAffineTransform(rotationAngle: .pi)
        }) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() - 1) {
                self.startParticles()
                self.animateParticles()
            }
        }
    }
    
    private func startParticles() {
        emitterLayer.birthRate = 1 // Parçacıkları harekete geçir
    }
    
    private func animateParticles() {
        let duration: TimeInterval = 1
        let moveDown = CABasicAnimation(keyPath: Constants.moveDownKeyPath)
        moveDown.fromValue = view.bounds.height / 2 + 50
        moveDown.toValue = view.bounds.height + 50
        moveDown.duration = duration
        moveDown.fillMode = .forwards
        moveDown.isRemovedOnCompletion = false
        
        emitterLayer.add(moveDown, forKey: Constants.emitterForKey)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.showMainScreen() // Ana ekrana geçiş
        }
    }
    
    private func showMainScreen() {
        // Create TabBarController
        let tabBarController = TabBarController()

        if let window = self.view.window {
            window.rootViewController = tabBarController
            window.makeKeyAndVisible()
        }
    }
}
