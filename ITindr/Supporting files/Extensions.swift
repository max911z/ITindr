//
//  Extensions.swift
//  ITindr
//
//  Created by Максим Неверовский on 23.11.2021.
//

import Foundation
import UIKit

extension UIView {
    func addShadow() {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 24
        self.layer.shadowOpacity = 1
    }
    
    
    func addGradient() {
        let gradientLayer = CAGradientLayer();
        
        let color1 = UIColor(red: 250/255, green: 19/255, blue: 171/255, alpha: 1.0).cgColor;
        let color2 = UIColor(red: 232/255, green: 19/255, blue: 250/255, alpha: 1.0).cgColor;
        
        gradientLayer.colors = [color1, color2];
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5);
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5);
        
        gradientLayer.frame = self.bounds;
        gradientLayer.cornerRadius = 28
        self.layer.masksToBounds = true
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension UIViewController
{
    func setupToHideKeyboardOnTapOnView()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}

extension InterestsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        userImageView.image = info[.originalImage] as? UIImage
        addPhotoButton.setTitle("Удалить фото", for: .normal)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
