//
//  ProfileViewController.swift
//  ITindr
//
//  Created by Максим Неверовский on 28.10.2021.
//

import UIKit
import Alamofire
import TagListView

struct profile: Codable {
    var name: String
    var aboutMyself: String?
    var avatar: String?
}

class ProfileViewController: UIViewController, TagListViewDelegate {
    
    @IBOutlet weak var editButtonView: UIView!
    @IBOutlet weak var tagListView: TagListView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var aboutMeTextView: UITextView!
    
    var tags = [String]()
    var tagArray = [String]()
    var finArray = [String]()
    
    var accessToken = ""
    var refreshToken = ""
    var output: profile?
    var result: [topic]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editButtonView.layer.cornerRadius = 28
        editButtonView.addShadow()
        
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
        
        AF.request("http://193.38.50.175/itindr/api/mobile/v1/profile",
                   method: .get,
                   encoding: JSONEncoding.default,
                   headers: ["Authorization":"Bearer \(accessToken)"]).responseData{ [self]response in
            switch response.result{
            case .success (let data):
                print("Мой профиль", response.response!.statusCode)
                output = try? JSONDecoder().decode(profile.self, from: data)
                
                if response.response!.statusCode == 200{
                    userNameLabel.text = output?.name
                    aboutMeTextView.text = output?.aboutMyself
                }
                
            case .failure (let error):
                print(error)
                let alert = UIAlertController(title: "Внимание", message: "Проверьте соединение с сервером", preferredStyle: .alert)
                let okeyButton = UIAlertAction(title: "Ok", style: .cancel )
                alert.addAction(okeyButton)
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func goToEditViewConroller(_ sender: Any) {
        let vc = InterestsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    
    
}
