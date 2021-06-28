//
//  FruitsListVC.swift
//  SampleTableAppB
//
//  Created by Mine Rala on 24.06.2021.
//

import UIKit

// MARK: - Fruit List VC
class FruitsListVC: UIViewController {
    
    private var filteredFruits: [Fruit] = []
    private var arrFruits: [Fruit] = []
    private var canEdit : Bool = true
    private let searchController = UISearchController(searchResultsController: nil)
    
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

}

extension FruitsListVC {
    private func configureNavigationBar()  {
        self.navigationItem.title = "Meyveler"
        self.navigationController?.navigationBar.barTintColor = .systemOrange
        self.navigationController?.navigationBar.backgroundColor = .systemOrange
        let attributes = [NSAttributedString.Key.foregroundColor:UIColor.systemRed, NSAttributedString.Key.font : UIFont(name: "Montserrat-Regular", size: 24)!]
        self.navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
    }
    
    private func setUpUI() {
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
        filteredFruits = arrFruits
        reloadTableView()
    }
    
}

extension FruitsListVC {
    private func reloadTableView() {
        if filteredFruits.count == 0 {
            tableViewFruits.alpha = 0
            labelEmptyScreen.alpha = 1
        }else{
            tableViewFruits.alpha = 1
            labelEmptyScreen.alpha = 0
        }
        tableViewFruits.reloadData()
    }
}

// MARK: - actions
extension FruitsListVC {
    @objc func addItemClicked() {
        let vc = FruitsAddVC()
        vc.modalPresentationStyle = .formSheet
        vc.delegate = self//aşağıdan yukarayı sürüklenen ekran
        self.present(vc, animated: true, completion: nil)
    }
}


// MARK: - lifecycle
extension FruitsListVC {
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
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Fruit"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addItemClicked))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name:"Montserrat-Bold" , size: 20)!], for: .normal)
        
        setUpUI()
    }
}

// MARK: - UISearchResultsUpdating
extension FruitsListVC: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    guard let searchText = searchController.searchBar.text else{
        return
    }
    if searchText.count == 0 {
        filteredFruits = arrFruits
    }else{
        filteredFruits = arrFruits.filter({ (fruit) -> Bool in
            return fruit.title.lowercased().contains(searchText.lowercased())
        })
    }
    self.reloadTableView()
  }
}

// MARK: - Table view delegate / datasource
extension FruitsListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFruits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewFruits.dequeueReusableCell(withIdentifier: "FruitItemCell",for: indexPath)as! FruitItemCell
        let fruit = filteredFruits[indexPath.row]
        cell.updateCell(fruit: fruit)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = FruitsDetailVC()
        let fruit = filteredFruits[indexPath.row]
        vc.fruit = fruit
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return canEdit
    }
    
    func tableView(_ tableView: UITableView,
                   editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView,
                       trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let trash = UIContextualAction(style: .destructive,title: "Trash") { [weak self] (action, view, completionHandler) in
            guard let self = self else{
                completionHandler(false)
                return
            }
            self.handleDelete(indexPath: indexPath)
            completionHandler(true)
            
        }
        trash.backgroundColor = .systemRed
        
        let update = UIContextualAction(style: .normal,title: "Update") { [weak self] (action, view, completionHandler) in
            guard let self = self else{
                completionHandler(false)
                return
            }
            self.handleUpdate(indexPath: indexPath)
            completionHandler(true)
        }
        update.backgroundColor = .systemBlue
        let configuration = UISwipeActionsConfiguration(actions: [trash,update])
        return configuration
    }
    
    private func handleDelete(indexPath: IndexPath) {
        self.arrFruits.remove(at: indexPath.row)
        self.filteredFruits = self.arrFruits
        self.reloadTableView()
    }
    
    private func handleUpdate(indexPath: IndexPath){
        let vc = FruitsAddVC()
        vc.state =  .update
        vc.fruit = filteredFruits[indexPath.row]
        vc.delegate = self
        self.navigationController?.present(vc, animated: true, completion: nil)
        
    }
}

// MARK: - Fruit detail delegate
extension FruitsListVC: FruitDetailDelegate {
    func fruitDetailDidTappedStar(fruit: Fruit) {
        print("fruit : \(fruit.title), is favored: \(fruit.isFavorited)")
        filteredFruits.forEach { fr in
            if fr.title == fruit.title {
                fr.isFavorited = fruit.isFavorited
            }
        }
        reloadTableView()
    }
}

//MARK: - Add new item delegate
extension FruitsListVC: AddNewItemDelegate {
    func passItem(fruit: Fruit) {
        var newArray = arrFruits.filter { (fr) -> Bool in
            return fr.id != fruit.id
        }
        newArray.append(fruit)
        arrFruits = newArray
        updateSearchResults(for: self.searchController)
        tableViewFruits.reloadData()
    }
}

// MARK: - navigation bar delegate
extension FruitsListVC: UINavigationBarDelegate {
  func position(for bar: UIBarPositioning) -> UIBarPosition {
    return .topAttached
    }
}

