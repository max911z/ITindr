//
//  StartScreenViewController.swift
//  ITindr
//
//  Created by Максим Неверовский on 11.10.2021.
//

import UIKit

class StartScreenViewController: UIViewController {
    
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false);
        
        btn.layer.cornerRadius = 28
        btn.addGradient()
        btn.addShadow()
        signInButton.layer.cornerRadius = 28
        signInButton.addShadow()
    }
    
    @IBAction func GoToSignUp(_ sender: Any) {
        let vc = SignUpViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func GoToSignIn(_ sender: Any) {
        let vc = SignInViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
