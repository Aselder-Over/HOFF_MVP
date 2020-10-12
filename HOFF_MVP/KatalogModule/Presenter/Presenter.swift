//
//  Presenter.swift
//  HOFF_MVP
//
//  Created by Асельдер on 14.09.2020.
//  Copyright © 2020 Асельдер. All rights reserved.
//

import Foundation
import Alamofire

protocol MenuPresenterProtocol: class {
    
    init(view: MenuViewProtocol, networking: NetworkServiceProtocol)
    var catalog: MenuItem? { get set }
    var sortTypes: SortTypes { get set }
    var sortBy: SortByes { get set }
    var allLoaded: Bool { get }
    func getMenuItems()
}

//Параметры сортировки
enum SortTypes: String {
    case discount = "discount"
    case desc = "desc"
    case arc = "arc"
}
//Параметры сортировки
enum SortByes: String {
    case YN = "Y"
    case popular = "popular"
    case price = "price"
}

class MenuPresenter: MenuPresenterProtocol {
    
    // MARK: - init
    required init (view: MenuViewProtocol, networking: NetworkServiceProtocol) {
        self.view = view
        self.networking = networking
        getMenuItems()
    }
    
    // MARK: - getItems
    let view: MenuViewProtocol?
    let networking: NetworkServiceProtocol
    
    var catalog: MenuItem? // Массив для последующего заполнения из getCatalog() 
    
    var sortTypes: SortTypes = .arc {
        didSet {
            self.view?.scrollOnTopCV()
        }
    }
    
    var sortBy: SortByes = .popular {
        didSet {
            DispatchQueue.main.async {
                self.view?.showLoading()
                self.myReloadData()
                self.view?.scrollOnTopCV()
            }
        }
    }
    
    // Пагинация
    var allLoaded = false
    private var isLoading = false
    private var offset = "0" // Отступ от нулевого элемента. Количество, которое я уже загрузил
    private var limit = "10" // Количество, которое я запрашиваю с сервера в данный момент
    
    //Получение итемов
    func getMenuItems() {
        // Если allLoaded == false и isLoading == false, тогда выполняем функцию
        guard !allLoaded && !isLoading else { return }
        
        isLoading = true
        
        // Задаем значение allLoaded путем вызова функции из networkService
        self.allLoaded = networking.getCatalog(limit: limit, offset: offset, sotrType: sortTypes.rawValue, sortBy: sortBy.rawValue, onSuccess: { [weak self] (catalog) in
            
            self?.isLoading = false
            
            // Устанавливаем слабую ссылку на self для предотвращения утечки памяти
            guard let self = self else { return }
            
            // Если каталог не инициализирован, то инициализировать. Иначе пополнить массив итемов
            if self.catalog == nil {
                self.catalog = catalog
                
                self.view?.setMenuItems(item: catalog)
                self.view?.hideLoading()
                //Меняем название тайтла во вью контроллере
                self.view?.changeTitleVC(title: catalog.categoryName)
            } else {
                self.catalog?.items += catalog.items
                self.view?.setMenuItems(item: self.catalog)
                self.view?.hideLoading()
            }
        }, onFailure: { (error) in
            print(error)
        })
        
        // Прибавляем к общему количетсву загружженых элементов новые загружаемые
        self.offset = String(Int(self.offset)! + Int(self.limit)!)
    }
    
    //
    func myReloadData() {
        self.catalog?.items = []
        self.offset = "0"
        self.getMenuItems()
    }
}
