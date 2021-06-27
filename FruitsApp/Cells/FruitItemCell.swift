//
//  FruitItemCell.swift
//  SampleTableAppB
//
//  Created by Mine Rala on 24.06.2021.
//

import Foundation
import UIKit

class FruitItemCell: UITableViewCell {
    
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
    
    private let imViewStar: UIImageView = {
        let imView = UIImageView(frame: .zero)
        imView.tintColor = .orange
        imView.translatesAutoresizingMaskIntoConstraints = false
        return imView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        
        self.addSubview(imViewFruit)
        imViewFruit.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        imViewFruit.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        imViewFruit.widthAnchor.constraint(equalToConstant: 128).isActive = true
        imViewFruit.heightAnchor.constraint(equalToConstant: 128).isActive = true
        
        self.addSubview(lblTitle)
        lblTitle.topAnchor.constraint(equalTo: imViewFruit.topAnchor,constant: 0).isActive = true
        lblTitle.leadingAnchor.constraint(equalTo: imViewFruit.trailingAnchor,constant: 8).isActive = true
        lblTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -8).isActive = true
        lblTitle.heightAnchor.constraint(equalToConstant: 21 ).isActive = true
        
        self.addSubview(lblDesc)
        lblDesc.topAnchor.constraint(equalTo: lblTitle.bottomAnchor,constant: 4).isActive = true
        lblDesc.leadingAnchor.constraint(equalTo: lblTitle.leadingAnchor,constant: 0).isActive = true
        lblDesc.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4).isActive = true
        let bottomAnchorDesc = lblDesc.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -64)
        bottomAnchorDesc.priority = .defaultHigh
        bottomAnchorDesc.isActive = true
        
        self.addSubview(imViewStar)
        imViewStar.topAnchor.constraint(equalTo: imViewFruit.bottomAnchor, constant: 9).isActive = true
        imViewStar.leadingAnchor.constraint(equalTo: imViewFruit.leadingAnchor, constant: 0).isActive = true
        let bottomAnchorStar = imViewStar.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -32)
        bottomAnchorStar.priority = .defaultLow
        bottomAnchorStar.isActive = true
        imViewStar.heightAnchor.constraint(equalToConstant: 24).isActive = true
        imViewStar.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
    }
    
    func updateCell(fruit:Fruit) {
        
        imViewFruit.image = UIImage(named: fruit.image)
        lblTitle.text = fruit.title
        lblDesc.text = fruit.desc
        
        if fruit.isFavorited == true{
            imViewStar.image = UIImage(systemName: "star.fill")
        }else{
            imViewStar.image = UIImage(systemName: "star")
        }
        self.layoutIfNeeded()
    }
}
