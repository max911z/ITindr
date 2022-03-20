//
//  FlowViewController.swift
//  ITindr
//
//  Created by Максим Неверовский on 28.10.2021.
//

import UIKit
import Alamofire
import TagListView

class FlowViewController: UIViewController, TagListViewDelegate {
    
    var tagArray = [String]()
    var tags = [String]()
    
    var accessTokenTabBar = ""
    var refreshTokenTabBar = ""
    
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var missButton: UIButton!
    @IBOutlet weak var likeButtonView: UIView!
    @IBOutlet weak var missButtonView: UIView!
    @IBOutlet weak var tagListView: TagListView!
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = false
        
        textView.text = "saldkfnkasdjfasjdfkasdjfbkadsjfbkasdjfbkasdjfbkasdjbfkasjdf"
        
        likeButtonView.layer.cornerRadius = 28
        likeButtonView.addGradient()
        likeButtonView.addShadow()
        missButtonView.layer.cornerRadius = 28
        missButtonView.addShadow()
        
        tagListView.delegate = self
        tagListView.textFont = UIFont(name: "Montserrat-Bold", size: 14)!
        tagListView.textColor = .white
        tagListView.tagBackgroundColor = UIColor(named: "fontColor")!
        tagListView.borderColor = UIColor(named: "fontColor")
        
        tagListView.borderWidth = 1
        tagListView.alignment = .center
        tagListView.paddingX = 11
        tagListView.paddingY = 5
        tagListView.marginY = 8
        tagListView.marginX = 8
        tagListView.cornerRadius = 12
        
        tagListView.addTags(["Koltin","Android","iOS","Backend","ML","SwiftUI","Jetpack Compose","Java","Ktor","Spring",".Net","JavaScript","SQL","Koltin","Android","iOS","Backend","ML","SwiftUI","Jetpack Compose","Java","Ktor","Spring",".Net","JavaScript","SQL"])
    }
    
    
    @IBAction func likeButtonAction(_ sender: Any) {
        print("like")
        guard let navigationController = self.navigationController else { return }
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        var navigationArray = navigationController.viewControllers
        let temp = navigationArray.last
        navigationArray.removeAll()
        navigationArray.append(temp!)
        self.navigationController?.viewControllers = navigationArray
        let popUpVC = PopUpViewController()
        self.addChild(popUpVC)
        popUpVC.view.frame = self.view.frame
        self.view.addSubview(popUpVC.view)
        
        
        popUpVC.didMove(toParent: self) // 5
    }
    
    @IBAction func missButtonAction(_ sender: Any) {
        print("miss")
    }
    
    
    var window: UIWindow?
    @IBAction func goToPhotoProfile(_ sender: Any) {
        print("success")
        
        
        guard let navigationController = self.navigationController else { return }
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        var navigationArray = navigationController.viewControllers
        let temp = navigationArray.last
        navigationArray.removeAll()
        navigationArray.append(temp!)
        self.navigationController?.viewControllers = navigationArray
        
        let vc = ProfilePhotoViewController()
        navigationController.pushViewController(vc, animated: true)
        
    }
    
}
