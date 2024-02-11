import UIKit

class InfoViewController: UIViewController {
    
    var buttonAlertOne = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(buttonAlertOne)
        buttonAlertOne.frame = CGRect(x: 0, y: 0, width: 150, height: 100)
        buttonAlertOne.layer.cornerRadius = 12
        buttonAlertOne.center = view.center
        buttonAlertOne.backgroundColor = .green
        buttonAlertOne.setTitle("AlertOne", for: .normal)
        buttonAlertOne.addTarget(self, action: #selector(startAlert), for: .touchUpInside)
        
    }
    
    @objc func startAlert() {
        showAlert()
    }
}
    //MARK: Extention

extension InfoViewController {
    func showAlert() {
        let alertController = UIAlertController(title: "AlertOne", message: "Message one", preferredStyle: .alert)
        
        let okActionButton = UIAlertAction(title: "Да", style: .default) {_ in
            print("Yes action")
        }
        alertController.addAction(okActionButton)
        
        let noActionButton = UIAlertAction(title: "Нет", style: .destructive) {_ in
            print("No action")
        }
        alertController.addAction(noActionButton)
        
        present(alertController, animated: true)
    }
}
