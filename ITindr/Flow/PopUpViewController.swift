//
//  PopUpViewController.swift
//  ITindr
//
//  Created by Максим Неверовский on 29.10.2021.
//

import UIKit

class PopUpViewController: UIViewController {
    
    @IBOutlet weak var chatButton: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        
        chatButton.layer.cornerRadius = 28
        chatButton.addGradient()
        chatButton.addShadow()
        
        moveIn()
    }
    
    @IBAction func goToChatViewController(_ sender: UIButton) {
        moveOut()
        let vc = DialogViewController()
        navigationController?.pushViewController(vc, animated: false)
        
        
        
        
    }
    
    func moveIn() {
        self.view.transform = CGAffineTransform(scaleX: 1.35, y: 1.35)
        self.view.alpha = 0.0
        
        UIView.animate(withDuration: 0.24) {
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.view.alpha = 1.0
        }
    }
    
    func moveOut() {
        UIView.animate(withDuration: 0.24, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.35, y: 1.35)
            self.view.alpha = 0.0
        }) { _ in
            self.view.removeFromSuperview()
        }
    }
}
