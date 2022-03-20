//
//  SignInViewController.swift
//  ITindr
//
//  Created by Максим Неверовский on 12.10.2021.
//

import UIKit
import Alamofire

class SignInViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    
    
    @IBOutlet weak var MessageEmail: UILabel!
    @IBOutlet weak var MessagePassword: UILabel!
    
    
    @IBOutlet weak var SignInButton: UIButton!
    @IBOutlet weak var BackButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EmailTextField.delegate = self
        PasswordTextField.delegate = self
        self.setupToHideKeyboardOnTapOnView()
        
        MessageEmail.isHidden = true
        MessagePassword.isHidden = true
        
        SignInButton.layer.cornerRadius = 28
        SignInButton.addGradient()
        SignInButton.addShadow()
        BackButton.layer.cornerRadius = 28
        BackButton.addShadow()
    }
    
    @IBAction func GoToInterestsViewController(_ sender: Any) {
        MessageEmail.isHidden = true
        MessagePassword.isHidden = true
        
        chechEmail()
        checkPassword()
        var result: test?
        let apiMethod = "http://193.38.50.175/itindr/api/mobile/v1/auth/login"
        if MessageEmail.isHidden && MessagePassword.isHidden {
            AF.request(apiMethod, method: .post, parameters: ["email":EmailTextField.text!,"password": PasswordTextField.text!], encoding: JSONEncoding.default).responseData{ [self] response in
                switch response.result{
                case .success (let data):
                    print("Авторизация:", response.response!.statusCode)
                    result = try? JSONDecoder().decode(test.self, from: data)
                    
                    if response.response!.statusCode == 200{
                        let nextVC = UITabBarController()
                        navigationController?.pushViewController(nextVC, animated: false)
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
                    }
                    else if response.response!.statusCode == 400{
                        
                        let alert = UIAlertController(title: "Внимание", message: "Введите корректные данные", preferredStyle: .alert)
                        let okeyButton = UIAlertAction(title: "Ok", style: .cancel )
                        alert.addAction(okeyButton)
                        
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                    else if response.response!.statusCode == 404{
                        let alert = UIAlertController(title: "Внимание", message: "Такого пользователя не существует", preferredStyle: .alert)
                        let okeyButton = UIAlertAction(title: "Ok", style: .cancel )
                        alert.addAction(okeyButton)
                        
                        self.present(alert, animated: true, completion: nil)
                    }
                    else if response.response!.statusCode == 500{
                        let alert = UIAlertController(title: "Упс...", message: "Что-то пошло не так", preferredStyle: .alert)
                        let okeyButton = UIAlertAction(title: "Ok", style: .cancel )
                        alert.addAction(okeyButton)
                        
                        self.present(alert, animated: true, completion: nil)
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
       
        

        
    }
    
    @IBAction func GoToStartScreenViewController(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    fileprivate func chechEmail() {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        if (EmailTextField.text == "") {
            MessageEmail.isHidden = false
            MessageEmail.text = "Заполните поле!"
        }
        else if (NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: EmailTextField.text) == false) {
            MessageEmail.isHidden = false
            MessageEmail.text = "Введите корректный E-mail!"
        }
    }
    
    fileprivate func checkPassword() {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?.&#])[A-Za-z\\dd$@$!%*?.&#]{8,}"
        if (PasswordTextField.text == "") {
            MessagePassword.isHidden = false
            MessagePassword.text = "Заполните поле!"
        }
        else if (NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: PasswordTextField.text) == false) {
            MessagePassword.isHidden = false
            MessagePassword.text = "Формат пароля:[a-z A-Z 0-9 $@$!%.*?&#]"
        }
    }
    
}
