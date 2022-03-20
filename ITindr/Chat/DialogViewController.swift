//
//  DialogViewController.swift
//  ITindr
//
//  Created by Максим Неверовский on 29.10.2021.
//

import UIKit

class DialogViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        setUpNavBar()
        
        // Do any additional setup after loading the view.
    }
    
    
    func setUpNavBar(){
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor(named: "fontColor") as Any]
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "fontColor")
        title = "Профиль"
        self.navigationController?.view.tintColor = UIColor(named: "fontColor")
        let backButton = UIBarButtonItem()
        backButton.title = "Назад"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    
    }
    
}
