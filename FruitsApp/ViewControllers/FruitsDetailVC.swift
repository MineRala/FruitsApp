//
//  FruitsDetail.swift
//  SampleTableAppB
//
//  Created by Mine Rala on 24.06.2021.
//

import Foundation
import UIKit

protocol FruitDetailDelegate {
    func fruitDetailDidTappedStar(fruit: Fruit)
}

class FruitsDetailVC: UIViewController{

    var delegate: FruitDetailDelegate!
    var fruit : Fruit!
    
    private let imViewFruit: UIImageView = {
        let imView = UIImageView(frame: .zero)
        imView.translatesAutoresizingMaskIntoConstraints = false
        return imView
    }()
    
    private let lblTitle: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        lbl.textColor = .black
        return lbl
    }()
    
    private let lblDesc: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        lbl.textColor = .black
        lbl.numberOfLines = 0
        return lbl
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private let imViewStar: UIButton = {
        let button = UIButton(frame: .zero)
        button.tintColor = .orange
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let back: UIButton = {
        let back = UIButton(frame: .zero)
        back.backgroundColor = .black
        back.setTitle("Back", for: .normal)
        back.translatesAutoresizingMaskIntoConstraints = false
        return back
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func setUpUI(){
        self.view.backgroundColor = .white
        self.view.addSubview(imViewFruit)
        imViewFruit.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        imViewFruit.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 0).isActive = true
        imViewFruit.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        imViewFruit.heightAnchor.constraint(equalToConstant: 414).isActive = true

        self.view.addSubview(lblTitle)
        lblTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        lblTitle.topAnchor.constraint(equalTo: self.imViewFruit.bottomAnchor, constant: 16).isActive = true
        lblTitle.heightAnchor.constraint(equalToConstant: 29).isActive = true

        self.view.addSubview(imViewStar)
        imViewStar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -13).isActive = true
        imViewStar.widthAnchor.constraint(equalToConstant: 39).isActive = true
        imViewStar.heightAnchor.constraint(equalToConstant: 39).isActive = true

        self.view.addSubview(lblDesc)
        lblDesc.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 16).isActive = true
        lblDesc.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        lblDesc.leadingAnchor.constraint(equalTo: self.lblTitle.leadingAnchor, constant: 0).isActive = true

        self.view.addSubview(back)
        back.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 48).isActive = true
        back.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        back.widthAnchor.constraint(equalToConstant: 73 ).isActive = true
        back.heightAnchor.constraint(equalToConstant: 39).isActive = true
        imViewStar.centerYAnchor.constraint(equalTo: lblTitle.centerYAnchor, constant: 0).isActive = true
        
        self.back.addTarget(self, action: #selector(backClicked), for: .touchUpInside)
        self.imViewStar.addTarget(self, action: #selector(starClicked), for: .touchUpInside)
        
        imViewFruit.image =  fruit.image
        lblTitle.text = fruit.title
        lblDesc.text = fruit.desc
        if fruit.isFavorited == true{
            imViewStar.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }else{
            imViewStar.setImage(UIImage(systemName: "star"), for: .normal)
        }
        
    }
    
    @objc func backClicked(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func starClicked(){
        if fruit.isFavorited == true {
            fruit.isFavorited = false
            imViewStar.setImage(UIImage(systemName: "star"), for: .normal)
        } else {
            fruit.isFavorited = true
            imViewStar.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
        delegate.fruitDetailDidTappedStar(fruit: fruit)
    }
}
    

