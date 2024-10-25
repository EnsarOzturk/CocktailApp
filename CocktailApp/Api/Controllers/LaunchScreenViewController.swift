import UIKit

final class LaunchScreenViewController: UIViewController {
    
    // Açılış ekranımda görüntülenecek bardak görüntüsü
    let glassImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "empty_glass"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var emitterLayer: CAEmitterLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Görünüm arka planını ve resim görünümünü ekleme
        view.backgroundColor = .white
        view.addSubview(glassImageView)
        
        // Bardak görünümü için kısıtlamalar
        NSLayoutConstraint.activate([
            glassImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            glassImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            glassImageView.widthAnchor.constraint(equalToConstant: 100),
            glassImageView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        // Görünümü başlat
        setupEmitter()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Görünüm göründüğünde bardak animasyonunu başlat
        animateGlass()
    }
    
    private func setupEmitter() {
        emitterLayer = CAEmitterLayer()
        emitterLayer.emitterPosition = CGPoint(x: view.bounds.midX, y: view.bounds.height / 2 + 50)
        emitterLayer.emitterSize = CGSize(width: 70, height: 1)
        emitterLayer.emitterShape = .rectangle
        
        // Parçacık özelliklerini yapılandır
        let particle = CAEmitterCell()
        particle.contents = UIImage(named: "particle")?.cgImage
        particle.birthRate = 12
        particle.lifetime = 0.2
        particle.velocity = 0.1
        particle.velocityRange = 0.1
        particle.emissionRange = .pi / 2
        particle.scale = 0.01
        particle.scaleRange = 0.06
        
        emitterLayer.emitterCells = [particle]
        view.layer.addSublayer(emitterLayer)
        emitterLayer.birthRate = 0 // Başlangıçta hiçbir parçacık yayılmaz
    }
    
    private func animateGlass() {
        // Bardak görünümünü döndür
        UIView.animate(withDuration: 1.0, delay: 0, options: [.curveEaseInOut], animations: {
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
        let duration: TimeInterval = 1.5
        let moveDown = CABasicAnimation(keyPath: "emitterPosition.y")
        moveDown.fromValue = view.bounds.height / 2 + 50
        moveDown.toValue = view.bounds.height + 50
        moveDown.duration = duration
        moveDown.fillMode = .forwards
        moveDown.isRemovedOnCompletion = false
        
        emitterLayer.add(moveDown, forKey: "moveDown")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.showMainScreen() // Ana ekrana geçiş
        }
    }
    
    private func showMainScreen() {
        // Animasyon sonrası ana ekran geçişi
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController {
            tabBarController.modalTransitionStyle = .crossDissolve
            tabBarController.modalPresentationStyle = .fullScreen
            self.present(tabBarController, animated: true, completion: nil)
        }
    }
}
