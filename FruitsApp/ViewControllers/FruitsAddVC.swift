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

class FruitsAddVC : UIViewController {
    var delegate: AddNewItemDelegate!
    var fruit : Fruit!
    var arrFruits: [Fruit] = []
    
    private let imViewFruit: UIImageView = {
        let imView = UIImageView(frame: .zero)
        imView.translatesAutoresizingMaskIntoConstraints = false
        imView.backgroundColor = .systemGray
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
        let tfd = UITextView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        tfd.translatesAutoresizingMaskIntoConstraints = false
        tfd.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        tfd.backgroundColor = .white
        tfd.textColor = .black
        tfd.autocorrectionType = .no
        tfd.autocapitalizationType = .none
        tfd.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        tfd.layer.borderWidth = 1
        tfd.layer.cornerRadius = 8
        return tfd
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
        //imViewFruit.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        imViewFruit.widthAnchor.constraint(equalToConstant: 128).isActive = true
        imViewFruit.heightAnchor.constraint(equalToConstant: 128).isActive = true
        
        self.view.addSubview(textFieldTitle)
        textFieldTitle.topAnchor.constraint(equalTo: imViewFruit.bottomAnchor, constant: 16).isActive = true
        textFieldTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
       // lblTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
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
    
    }
    
    @objc func addButtonSaveItem(){
        guard validateFruits() == true else {
            print("Validation failed!")
            return
        }
        saveNewItem()
    }
    
    func saveNewItem(){
        fruit = Fruit()
        fruit.image = "muz"
        fruit.title = textFieldTitle.text!
        fruit.desc = textViewDesc.text!
        delegate.passItem(fruit: fruit)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func validateFruits () -> Bool{
        if textFieldTitle.text?.count == 0 {
            return false
        }
        else if textViewDesc.text.count == 0{
         return false
        }
        return true
    }
}


