//
//  FruitsAddVC.swift
//  FruitsApp
//
//  Created by Mine Rala on 25.06.2021.
//

import Foundation
import UIKit

protocol AddNewItemDelegate {
    func passItem(fruit: Fruit)
}

class FruitsAddVC : UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    var delegate: AddNewItemDelegate!
    var fruit : Fruit!
    var arrFruits: [Fruit] = []
    
    private let imViewFruit: UIImageView = {
        let imView = UIImageView(frame: .zero)
        imView.translatesAutoresizingMaskIntoConstraints = false
        imView.backgroundColor = .systemGray
        imView.isUserInteractionEnabled = true
        return imView
    }()
    
    private let textFieldTitle: UITextField = {
        let tft = UITextField(frame: .zero)
        tft.translatesAutoresizingMaskIntoConstraints = false
        tft.textAlignment = NSTextAlignment.justified
        tft.placeholder = "Enter fruit title"
        tft.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        tft.backgroundColor = .white
        tft.textColor = .black
        tft.autocorrectionType = .no
        tft.autocapitalizationType = .none
        tft.borderStyle = UITextField.BorderStyle.roundedRect
        return tft
    }()
    
    private let textViewDesc: UITextView = {
        let tvd = UITextView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        tvd.translatesAutoresizingMaskIntoConstraints = false
        tvd.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        tvd.backgroundColor = .white
        tvd.textColor = .black
        tvd.autocorrectionType = .no
        tvd.autocapitalizationType = .none
        tvd.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        tvd.layer.borderWidth = 1
        tvd.layer.cornerRadius = 8
        return tvd
    }()

    private let addButton: UIButton = {
        let back = UIButton(frame: .zero)
        back.backgroundColor = .systemOrange
        back.setTitle("AddItem", for: .normal)
        back.translatesAutoresizingMaskIntoConstraints = false
        return back
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func setUpUI() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(imViewFruit)
        imViewFruit.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 16).isActive = true
        imViewFruit.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        imViewFruit.widthAnchor.constraint(equalToConstant: 128).isActive = true
        imViewFruit.heightAnchor.constraint(equalToConstant: 128).isActive = true
        
        self.view.addSubview(textFieldTitle)
        textFieldTitle.topAnchor.constraint(equalTo: imViewFruit.bottomAnchor, constant: 16).isActive = true
        textFieldTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        textFieldTitle.widthAnchor.constraint(equalToConstant: 300).isActive = true
        textFieldTitle.heightAnchor.constraint(equalToConstant: 32).isActive = true

        self.view.addSubview(textViewDesc)
        textViewDesc.topAnchor.constraint(equalTo: textFieldTitle.bottomAnchor, constant: 16).isActive = true
        textViewDesc.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        textViewDesc.widthAnchor.constraint(equalToConstant: 380).isActive = true
        textViewDesc.heightAnchor.constraint(greaterThanOrEqualToConstant: 500).isActive = true
      
        self.view.addSubview(addButton)
        addButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -64).isActive = true
        addButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32).isActive = true
        addButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.addButton.addTarget(self, action: #selector(addButtonSaveItem), for: .touchUpInside)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTap))
        imViewFruit.addGestureRecognizer(tapGesture) // imViewFruit(Resim seçme) tıklanma özelliği verildi.
    }
    
    @objc func addButtonSaveItem() {
        guard validateFruits() == true else {
            let alert = UIAlertController(title: "Error", message: inValidatedFieldsMessage(), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        saveNewItem()
    }
    
    func validateFruits () -> Bool {
        if textFieldTitle.text?.count == 0 {
            return false
        }
        else if textViewDesc.text.count == 0{
         return false
        }
        else if  imViewFruit.image == nil {
         return false
        }
        return true
    }
    
    func saveNewItem() {
        fruit = Fruit()
        fruit.image = imViewFruit.image
        fruit.title = textFieldTitle.text!
        fruit.desc = textViewDesc.text!
        delegate.passItem(fruit: fruit)
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
          return
        }
        imViewFruit.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func imageViewTap() {
        print("Tapped")
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        pickerController.mediaTypes = ["public.image", "public.movie"]
        pickerController.sourceType = .photoLibrary
        self.present(pickerController, animated: true, completion: nil)
    }
    
    func inValidatedFieldsMessage() -> String {
        var str = ""
        if imViewFruit.image == nil {
            str += "You must choose photo."
        }
        if textFieldTitle.text?.count == 0 {
            str += "You must enter fruit title."
        }
        if textViewDesc.text.count == 0 {
            str += "You must enter fruit description."
        }
        return str
    }
}
