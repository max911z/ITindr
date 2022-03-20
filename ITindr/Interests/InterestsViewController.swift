//
//  InterestsViewController.swift
//  ITindr
//
//  Created by Максим Неверовский on 13.10.2021.
//

import UIKit
import TagListView
import Alamofire

struct topic: Codable {
    var id: String
    var title: String
}

var arrTopic: [topic] = []


struct info: Codable {
    var name: String
    var aboutMyself: String?
    var topics = [String]()
}






class InterestsViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, TagListViewDelegate{
    
    var accessToken = ""
    var refreshToken = ""
    
    let imagePicker = UIImagePickerController()
    var startImage: UIImage? = nil
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var aboutMeTextView: UITextView!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var tagListView: TagListView!
    
    var tags = [String]()
    var output: [topic]?
    var finArray = [String]()
    var photoURL = "http://193.38.50.175/itindr/api/mobile/v1/profile/avatar"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startImage = userImageView.image
        self.nameTextField.delegate = self
        self.aboutMeTextView.delegate = self
        tagListView.delegate = self
        
        self.setupToHideKeyboardOnTapOnView()
        
        signUpButton.layer.cornerRadius = 28
        signUpButton.addGradient()
        signUpButton.addShadow()
        
        aboutMeTextView.text = "О себе"
        aboutMeTextView.textColor = UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
        aboutMeTextView.font = UIFont(name: "Montserrat-Regular", size: 16)
        
        
        
        
        tagListView.textFont = UIFont(name: "Montserrat-Regular", size: 14)!
        tagListView.textColor = UIColor(named: "fontColor")!
        tagListView.tagBackgroundColor = .white
        tagListView.borderColor = UIColor(named: "fontColor")
        
        tagListView.borderWidth = 1
        tagListView.alignment = .leading
        tagListView.paddingX = 11
        tagListView.paddingY = 5
        tagListView.marginY = 8
        tagListView.marginX = 8
        
        var tagArray = [String]()
        tagListView.cornerRadius = 12
        
        
        AF.request("http://193.38.50.175/itindr/api/mobile/v1/topic",
                   method: .get,
                   encoding: JSONEncoding.default,
                   headers: ["Authorization":"Bearer \(accessToken)"]).responseData{ [self]response in
                    switch response.result{
                    case .success (let data):
                        print("Топики", response.response!.statusCode)
                        output = try? JSONDecoder().decode([topic].self, from: data)
                        print(output as Any)
                        
                        if response.response!.statusCode == 200{
                            print("Топики успешно возвращены")
                            output!.forEach { (topic) in
                                tagArray.append(topic.title)
                                
                            }
                            tagListView.addTags(tagArray)
                        }
                        else if response.response!.statusCode == 400{
                            print("Неправильный запрос")
                            
                        }
                        else if response.response!.statusCode == 401{
                        }
                        else if response.response!.statusCode == 403{
                            print("Обновите токены")
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
    
    
    
    @IBAction func takePhoto(_ sender: Any) {
        if (startImage == userImageView.image){
            
            imagePicker.delegate = self
            addPhotoButton.setTitle("Выбрать фото", for: .normal)
            let alert = UIAlertController(title: "Источник фото", message: "Выберите источник", preferredStyle: .actionSheet)
            let cameraButton = UIAlertAction(title: "Камера", style: .default, handler:{(action:UIAlertAction) in
                self.imagePicker.sourceType = .camera
                self.imagePicker.allowsEditing = false
                self.present(self.imagePicker, animated: true, completion: nil)
                
            })
            let galleryButton = UIAlertAction(title: "Галерея", style: .default, handler:{(action:UIAlertAction) in
                self.imagePicker.sourceType = .photoLibrary
                self.imagePicker.allowsEditing = false
                self.present(self.imagePicker, animated: true, completion: nil)
            })
            let cancelButton = UIAlertAction(title: "Отмена", style: .cancel, handler:nil)
            
            alert.addAction(cameraButton)
            alert.addAction(galleryButton)
            alert.addAction(cancelButton)
            
            present(alert, animated: true, completion: nil)
        }else{
            addPhotoButton.setTitle("Выбрать фото", for: .normal)
            userImageView.image = startImage
        }
    }
    
    
    @IBAction func goToTabBar(_ sender: Any) {
        
        var aboutMeValue = aboutMeTextView.text
        print("aboutMeValue:", aboutMeValue as Any)
        print("textView:", aboutMeTextView.text as Any)
        
        if aboutMeValue == "О себе"{
            aboutMeValue = ""
        }
        print("posle:",aboutMeValue as Any)
        var result: info?
        let apiMethod = "http://193.38.50.175/itindr/api/mobile/v1/profile"
        AF.request(apiMethod,
                   method: .patch,
                   parameters: ["name": nameTextField.text as Any,
                                "aboutMyself": aboutMeValue as Any,
                                "topics": finArray],
                   encoding: JSONEncoding.default,
                   headers: ["Authorization":"Bearer \(accessToken)"]).responseData{ [self] response in
                    switch response.result{
                    case .success (let data):
                        print("Profile update:", response.response!.statusCode)
                        print("Username", nameTextField.text as Any)
                        result = try? JSONDecoder().decode(info.self, from: data)
                        
                        if response.response!.statusCode == 200{
                            AF.upload(multipartFormData: { multipartFormData in
                                        multipartFormData.append(userImageView.image!.jpegData(compressionQuality: 0.5)!, withName: "avatar" , fileName: "file.jpeg", mimeType: "image/jpeg")}, to: photoURL, method: .post , headers: ["Authorization":"Bearer \(accessToken)"]).responseData{ [self] response in
                                            switch response.result{
                                            case .success (let data):
                                                print("Photo upload:", response.response!.statusCode)
                                                result = try? JSONDecoder().decode(info.self, from: data)
                                                
                                            case .failure (let error):
                                                print(error)
                                                let alert = UIAlertController(title: "Внимание", message: "Проверьте соединение с сервером", preferredStyle: .alert)
                                                let okeyButton = UIAlertAction(title: "Ok", style: .cancel )
                                                alert.addAction(okeyButton)
                                                
                                                self.present(alert, animated: true, completion: nil)
                                            }
                                        }
                        }
                        
                    case .failure (let error):
                        print(error)
                        let alert = UIAlertController(title: "Внимание", message: "Проверьте соединение с сервером", preferredStyle: .alert)
                        let okeyButton = UIAlertAction(title: "Ok", style: .cancel )
                        alert.addAction(okeyButton)
                        
                        self.present(alert, animated: true, completion: nil)
                    }
                   }
        guard nameTextField.text != "" else {
            
            let alert = UIAlertController(title: "Внимание!", message: "Введите ваше имя", preferredStyle: .alert)
            let okeyButton = UIAlertAction(title: "Ok", style: .cancel )
            alert.addAction(okeyButton)
            
            present(alert, animated: true, completion: nil)
            return
        }
        
        let nextVC = UITabBarController()
        
        
        nextVC.self.tabBar.backgroundColor = .white
        nextVC.self.tabBar.tintColor = UIColor(named: "fontColor")
        
        
        let flow = FlowViewController()
        
        flow.title = "Поток"
        let people = PeopleViewController()
        people.title = "Люди"
        let chat = ChatViewController()
        chat.title = "Чаты"
        let profile = ProfileViewController()
        profile.title = "Профиль"
        
        
        flow.tabBarItem.image = #imageLiteral(resourceName: "ri_checkbox-multiple-blank-line")
        people.tabBarItem.image = #imageLiteral(resourceName: "ri_group-line")
        chat.tabBarItem.image = #imageLiteral(resourceName: "ri_chat-1-line")
        profile.tabBarItem.image = #imageLiteral(resourceName: "ri_user-3-line")
        nextVC.setViewControllers([flow, people, chat, profile], animated: false)
        navigationController?.pushViewController(nextVC, animated: true)
        print(finArray)
        print(aboutMeValue as Any)
    }
    
    internal func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22) {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "О себе"
            textView.textColor = UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
            textView.font = UIFont(name: "Montserrat-Regular", size: 16)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView)
    {
        tagView.isSelected = !tagView.isSelected
        tagView.selectedBackgroundColor = UIColor(named: "fontColor")
        if tagView.isSelected{
            tagView.textFont = UIFont(name: "Montserrat-Bold", size: 14)!
            tagView.paddingX = 1
            tagView.paddingY = 1
        }else {
            tagView.textFont = UIFont(name: "Montserrat-Regular", size: 14)!
        }
        
        tagView.selectedTextColor = .white
        
        for i in 0 ..< tags.count {
            if tags[i] == title{
                tags.remove(at: i)
                return
            }
        }
        tags.append(title)
        
        output!.forEach { (topic) in
            if topic.title == title{
                finArray.append(topic.id)
            }
        }
    }
}








