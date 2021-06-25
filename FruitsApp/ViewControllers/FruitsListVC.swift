//
//  FruitsListVC.swift
//  SampleTableAppB
//
//  Created by Mine Rala on 24.06.2021.
//

import UIKit

class FruitsListVC: UIViewController ,UITableViewDelegate,UITableViewDataSource,FruitDetailDelegate{

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
        les.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        les.textAlignment = .center
        return les
    }()
    
    func reloadTableView(){
        if arrFruits.count == 0 {
            tableViewFruits.alpha = 0
            labelEmptyScreen.alpha = 1
        }else{
            tableViewFruits.alpha = 1
            labelEmptyScreen.alpha = 0
        }
        tableViewFruits.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func configureNavigationBar()  {
        self.navigationItem.title = "Meyveler"
        self.navigationController?.navigationBar.barTintColor = .systemOrange
        self.navigationController?.navigationBar.backgroundColor = .systemOrange
        let attributes = [NSAttributedString.Key.foregroundColor:UIColor.systemRed, NSAttributedString.Key.font:UIFont(name: "Verdana", size: 20)]
        self.navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
    }
    
    func setUpUI() {
        self.view.backgroundColor = .white
        //self.navigationItem.title = "Meyveler"
        
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
        //aamdm
        
        
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
 
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return canEdit
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == FruitItemCell.EditingStyle.delete{ //UITableViewCell
            arrFruits.remove(at: indexPath.row)
            reloadTableView()
        }
    }
    //itemların hepsi silinince hiç meyve yok uyarısı versin,tablo doluysa ne varsa o görünsün
    // uygulama içinde Montserrat fontunu kullanıcaz
    // add meyve sayfası textfield, text,image
}
