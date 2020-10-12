//
//  UserDefolts.swift
//  HOFF_MVP
//
//  Created by Асельдер on 14.09.2020.
//  Copyright © 2020 Асельдер. All rights reserved.
//

import Foundation

final class CustomUserDefaults {
    
    //Observer keys
    let actuallyFilter = "OLD_FILTER"
    let changeFilter   = "NEW_FILTER"
    let nameFilter     = "NAME_FILTER"
    
    //сингл тон
    static let shared = CustomUserDefaults()
    
    //сингл тон
    private let key = "ru.diit.tipo_HOFF"
    private var catalogItems: [MenuItem.Product] = []
    
    // MARK: - Init
    private init() {
        guard
            let data = UserDefaults.standard.data(forKey: key),
            let catalogFromDataBase = try? JSONDecoder().decode([MenuItem.Product].self, from: data)
                else
                { return }
        catalogItems.append(contentsOf: catalogFromDataBase)
    }
    
    // MARK: - Public methods
    func isFavorite(item: MenuItem.Product) -> Bool {
        
        if (catalogItems.firstIndex(where: { $0.id == item.id}) != nil) {
            return true
        } else {
            return false
        }
    }
    
    func checkFavoriteOnClick(item: MenuItem.Product) -> Bool {
        if let index = catalogItems.firstIndex(where: { $0.id == item.id}) {
            catalogItems.remove(at: index)
            
            //обновление данных юзерфалс
            synchronize()
            return true
        } else {
            catalogItems.append(item)
            synchronize()
            return false
        }
    }
    
    func clear() {
        catalogItems.removeAll()
        synchronize()
    }
    
    // MARK: - Private methods
    private func synchronize() {
        
        //обновление данных
        guard let catalog = try? JSONEncoder().encode(catalogItems) else { return }
        UserDefaults.standard.set(catalog, forKey: key)
    }
}
