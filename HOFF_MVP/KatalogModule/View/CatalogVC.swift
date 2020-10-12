//
//  File.swift
//  HOFF_MVP
//
//  Created by Асельдер on 13.09.2020.
//  Copyright © 2020 Асельдер. All rights reserved.
//

import UIKit
import SDWebImage

class CatalogVC: UIViewController {
    
    // Protocol
    var presenter: MenuPresenterProtocol?
    var networking = Networking()
    
    //Reload TV
    var menuItems: MenuItem?
    
    //Переменная - для доступа к КольшекшнВью
//    var tvcParam: ItemTableViewCell?
    
    // Outlet
    @IBOutlet weak var itemTable: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = MenuPresenter(view: self, networking: networking)
        
        itemTable.delegate = self
        itemTable.dataSource = self
        itemTable.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
        itemTable.separatorStyle = .none
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        title = "Диваны"
        
        //Нав бар
        self.navigationController?.navigationBar.tintColor = .black
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
    }
}

extension CatalogVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Иф/Елс для индивидуальной конфигурации ячеек
        if indexPath.row == 0 {
            
            let filterCell = itemTable.dequeueReusableCell(withIdentifier: "Filter", for: indexPath) as! FilterTableViewCell
            filterCell.initCell(delegate: self)
            
            return filterCell
        
        } else if indexPath.row == 1 {
            
            let characteristicTableViewCell = itemTable.dequeueReusableCell(withIdentifier: "Characteristic", for: indexPath) as! CharacteristicTableViewCell
            //Заполнение ячейки данными. Продукт пустой массив так как заполнение данными происходит в самой ячейке
            characteristicTableViewCell.setCharacteristic(product: [], delegate: presenter!)

            return characteristicTableViewCell
        } else if indexPath.row == 2 {
            
            let item = itemTable.dequeueReusableCell(withIdentifier: "Item", for: indexPath) as! ItemTableViewCell
            //тоже что и во 2й ячейке
            item.setProductItem(product: menuItems?.items ?? [], delegate: self)
            
            return item
        } else {
            return UITableViewCell()
        }
    }
    
    //Размер ячеек
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        var height: CGFloat = CGFloat()

        if indexPath.row == 0 {
            height = 48
            return height
        } else if indexPath.row == 1 {
            height = 56
            return height
        } else if indexPath.row == 2 {
            height = itemTable.frame.height - 104
        }
        return height
    }
}
