//
//  SignUpViewController.swift
//  ITindr
//
//  Created by Максим Неверовский on 12.10.2021.
//

import UIKit
import Alamofire

struct test: Codable{
    var accessToken: String
    var refreshToken: String
}

class SignUpViewController: UIViewController, UITextFieldDelegate{
    
    
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var PasswordRepeatTextField: UITextField!
    
    @IBOutlet weak var testView: UIView!
    
    
    @IBOutlet weak var MessageEmail: UILabel!
    @IBOutlet weak var MessagePassword: UILabel!
    @IBOutlet weak var MessageRepeatPassword: UILabel!
    
    
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var BackButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EmailTextField.delegate = self
        PasswordTextField.delegate = self
        PasswordRepeatTextField.delegate = self
        self.setupToHideKeyboardOnTapOnView()
        
        MessageEmail.isHidden = true
        MessagePassword.isHidden = true
        MessageRepeatPassword.isHidden = true
        
        
        
        SignUpButton.layer.cornerRadius = 28
        SignUpButton.addGradient()
        SignUpButton.addShadow()
        BackButton.layer.cornerRadius = 28
        BackButton.addShadow()
    }
    
    var result: test?
    
    @IBAction func GoToInterestsViewController(_ sender: Any) {
        
        
        
        MessageEmail.isHidden = true
        MessagePassword.isHidden = true
        MessageRepeatPassword.isHidden = true
        
        chechEmail()
        checkPassword()
        checkRepeatPassword()
        
        
        var result: test?
        let apiMethod = "http://193.38.50.175/itindr/api/mobile/v1/auth/register"
        if MessageEmail.isHidden && MessagePassword.isHidden && MessageRepeatPassword.isHidden{
            AF.request(apiMethod, method: .post, parameters: ["email":EmailTextField.text!,"password": PasswordTextField.text!], encoding: JSONEncoding.default).responseData{ [self] response in
                switch response.result{
                case .success (let data):
                    print("Регистрация:", response.response!.statusCode)
                    result = try? JSONDecoder().decode(test.self, from: data)
                    
                    if response.response!.statusCode == 200{
                        let vc = InterestsViewController()
                        vc.accessToken = result!.accessToken
                        vc.refreshToken = result!.refreshToken
                        navigationController?.pushViewController(vc, animated: true)
                    }
                    else if response.response!.statusCode == 400{
                        
                        let alert = UIAlertController(title: "Внимание", message: "Введите корректные данные", preferredStyle: .alert)
                        let okeyButton = UIAlertAction(title: "Ok", style: .cancel )
                        alert.addAction(okeyButton)
                        
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                    else if response.response!.statusCode == 409{
                        let alert = UIAlertController(title: "Внимание", message: "Такой пользователь уже существует", preferredStyle: .alert)
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
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%.*?&#])[A-Za-z\\dd$@$!%.*?&#]{8,}"
        if (PasswordTextField.text == "") {
            MessagePassword.isHidden = false
            MessagePassword.text = "Заполните поле!"
        }
        else if (NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: PasswordTextField.text) == false) {
            MessagePassword.isHidden = false
            MessagePassword.text = "Формат пароля:[a-z A-Z 0-9 $@$!%.*?&#]"
        }
    }
    
    
    fileprivate func checkRepeatPassword() {
        if (PasswordRepeatTextField.text == "") {
            MessageRepeatPassword.isHidden = false
            MessageRepeatPassword.text = "Повторите пароль!"
        }
        else if (PasswordTextField.text != PasswordRepeatTextField.text) {
            MessageRepeatPassword.isHidden = false
            MessageRepeatPassword.text = "Пароли не совпадают!"
        }
    }
}
