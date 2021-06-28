//
//  FruitsListVC.swift
//  SampleTableAppB
//
//  Created by Mine Rala on 24.06.2021.
//

import UIKit

class FruitsListVC: UIViewController ,UITableViewDelegate,UITableViewDataSource,FruitDetailDelegate,AddNewItemDelegate {
    
    func passItem(fruit: Fruit) {
        arrFruits.append(fruit)
        tableViewFruits.reloadData()
    }

    var arrFruits: [Fruit] = []
    var canEdit : Bool = true
 
    private let tableViewFruits: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = UIColor.clear
        return tv
    }()
    
    private let labelEmptyScreen: UILabel = {
        let les = UILabel(frame: .zero)
        les.translatesAutoresizingMaskIntoConstraints = false
        les.backgroundColor = UIColor.clear
        les.text = "Fruit list is empty!"
        les.numberOfLines = 0
        les.textAlignment = .center
        les.adjustsFontForContentSizeCategory = true
        let font = UIFont(name: "Montserrat-Regular", size: 21)!
        les.font = UIFontMetrics.default.scaledFont(for: font)
        return les
    }()
    
    func reloadTableView() {
        if arrFruits.count == 0 {
            tableViewFruits.alpha = 0
            labelEmptyScreen.alpha = 1
        }else{
            tableViewFruits.alpha = 1
            labelEmptyScreen.alpha = 0
        }
        tableViewFruits.reloadData()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.reloadTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addItemClicked))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name:"Montserrat-Bold" , size: 20)!], for: .normal)
        setUpUI()
    }
    
    func configureNavigationBar()  {
        self.navigationItem.title = "Meyveler"
        self.navigationController?.navigationBar.barTintColor = .systemOrange
        self.navigationController?.navigationBar.backgroundColor = .systemOrange
        let attributes = [NSAttributedString.Key.foregroundColor:UIColor.systemRed, NSAttributedString.Key.font : UIFont(name: "Montserrat-Regular", size: 24)!]
        self.navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
    }
    
    func setUpUI() {
        self.view.backgroundColor = .white
        
        configureNavigationBar()
        self.view.addSubview(labelEmptyScreen)
        self.view.addSubview(tableViewFruits)
        
        tableViewFruits.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableViewFruits.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableViewFruits.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableViewFruits.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        tableViewFruits.register(FruitItemCell.self, forCellReuseIdentifier: "FruitItemCell")
        tableViewFruits.dataSource = self
        tableViewFruits.delegate = self
        
        labelEmptyScreen.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        labelEmptyScreen.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        labelEmptyScreen.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        labelEmptyScreen.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        arrFruits = Fruit.all()
        reloadTableView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFruits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewFruits.dequeueReusableCell(withIdentifier: "FruitItemCell",for: indexPath)as! FruitItemCell
        let fruit = arrFruits[indexPath.row]
        cell.updateCell(fruit: fruit)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = FruitsDetailVC()
        let fruit = arrFruits[indexPath.row]
        vc.fruit = fruit
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func fruitDetailDidTappedStar(fruit: Fruit) {
        print("fruit : \(fruit.title), is favored: \(fruit.isFavorited)")
        arrFruits.forEach { fr in
            if fr.title == fruit.title {
                fr.isFavorited = fruit.isFavorited
            }
        }
        reloadTableView()
    }
    
    @objc func addItemClicked() {
        let vc = FruitsAddVC()
        vc.modalPresentationStyle = .formSheet
        vc.delegate = self//aşağıdan yukarayı sürüklenen ekran
        self.present(vc, animated: true, completion: nil)
    }
 
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return canEdit
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == FruitItemCell.EditingStyle.delete{ //UITableViewCell
            arrFruits.remove(at: indexPath.row)
            reloadTableView()
        }
    }
}
