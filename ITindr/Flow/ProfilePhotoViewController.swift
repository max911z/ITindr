//
//  ProfilePhotoViewController.swift
//  ITindr
//
//  Created by Максим Неверовский on 14.11.2021.
//

import UIKit
import TagListView

class ProfilePhotoViewController: UIViewController, TagListViewDelegate {

    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var tagListView: TagListView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
            setUpNavBar()
        
        tagListView.delegate = self
        tagListView.textFont = UIFont(name: "Montserrat-Bold", size: 14)!
        tagListView.textColor = .white
        tagListView.tagBackgroundColor = UIColor(named: "fontColor")!
        tagListView.borderColor = UIColor(named: "fontColor")
        tagListView.borderWidth = 1
        tagListView.alignment = .leading
        tagListView.paddingX = 11
        tagListView.paddingY = 5
        tagListView.marginY = 8
        tagListView.marginX = 8
        tagListView.cornerRadius = 12
        
       tagListView.addTags(["Koltin","Android","iOS","Backend","ML","SwiftUI","Jetpack Compose","Java","Ktor","Spring",".Net","JavaScript","SQL","Koltin","Android","iOS","Backend","ML","SwiftUI","Jetpack Compose","Java","Ktor","Spring",".Net","JavaScript","SQL"])
        
    }

    func setUpNavBar(){
        
        self.navigationController?.view.tintColor = UIColor.white
        let backButton = UIBarButtonItem()
        backButton.title = "Назад"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    
    }

}
