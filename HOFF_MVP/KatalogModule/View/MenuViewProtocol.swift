//
//  MenuViewProtocol.swift
//  HOFF_MVP
//
//  Created by Асельдер on 14.09.2020.
//  Copyright © 2020 Асельдер. All rights reserved.
//

import Foundation
import UIKit

protocol MenuViewProtocol {
    
    var menuItems: MenuItem? { get set }
    func setMenuItems(item: MenuItem?)
    func changeTitleVC(title: String)
    func loadingSucces()
    func showLoading()
    func hideLoading()
    func scrollOnTopCV()
}

extension CatalogVC: MenuViewProtocol, AlertDelegate, ItemsDelegate {
    
    //Реализуем функцию из АлертДелегата для вызова алерта
    func showAlert(completionHandler: @escaping (String) -> Void) {
        let alert = UIAlertController(title: "Сортировка", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Сначала популярные", style: .default, handler: {
            _ in
            
            //Меняем параметры запроса (Новый запрос, скрол КоллекшнВью и обнуление данных производится в пресетере)
            self.presenter?.sortTypes = .arc
            self.presenter?.sortBy = .popular
            completionHandler("Сначала популярные")
        }))
        
        alert.addAction(UIAlertAction(title: "Сначала дешевые", style: .default, handler: {
            _ in
            
            self.presenter?.sortTypes = .arc
            self.presenter?.sortBy = .price
            completionHandler("Сначала дешевые")
        }))
        
        alert.addAction(UIAlertAction(title: "Сначала дорогие", style: .default, handler: {
            _ in

            self.presenter?.sortTypes = .desc
            self.presenter?.sortBy = .price
            completionHandler("Сначала дорогие")
        }))
        
        alert.addAction(UIAlertAction(title: "По скидкам", style: .default, handler: {
            _ in
            
            self.presenter?.sortTypes = .discount
            self.presenter?.sortBy = .YN
            completionHandler("По скидкам")
        }))
        
        alert.addAction(UIAlertAction(title: "Отменить", style: .cancel, handler: {
            alert in print("Alert chek")
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //Меняем название тайтла во Вью Контроллере
    func changeTitleVC(title: String) {
        self.title = title
    }
    
    func loadingSucces() {
        itemTable.reloadData()
    }
    
    //Метод заполнения массива итемов (Объявляется в пресетере)
    func setMenuItems(item: MenuItem?) {
        menuItems = item
        itemTable.reloadData()
    }
    
    func showLoading() {
        self.itemTable.separatorStyle = .none
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    func loadMore() {
        presenter?.getMenuItems()
    }
    
    //Перемотка скрола наверх при смене типа сортировки
    func scrollOnTopCV() {
        //Получение ячейки
        for cell in itemTable.visibleCells {
            //Выбор нужной ячейки через as? и реализация перемотки
            (cell as? ItemTableViewCell)?.itemCollectionView.scrollToItem(at: IndexPath(index: 0), at: .top, animated: true)
        }
    }
}
