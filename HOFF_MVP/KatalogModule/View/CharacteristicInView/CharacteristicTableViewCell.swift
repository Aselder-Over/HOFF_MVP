//
//  CharacteristicTableViewCell.swift
//  HOFF_MVP
//
//  Created by Асельдер on 14.09.2020.
//  Copyright © 2020 Асельдер. All rights reserved.
//

import UIKit

class CharacteristicTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //Оутлет
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    //Массив для заполнения RelatedCategories и релоуда
    var categoriesItemCharacteristic: [MenuItem.RelatedCategories] = [] { didSet { categoriesCollectionView.reloadData() } }
    
    //Заполняем массив категорий
    var delegate: MenuPresenterProtocol?
    
    //Заполняем массив категорий
    func setCharacteristic (product: [MenuItem.RelatedCategories], delegate: MenuPresenterProtocol) {
        self.categoriesItemCharacteristic = product
        self.delegate = delegate
        categoriesCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        delegate?.catalog?.relatedCategories.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //Получаем итемы
        if let item = delegate?.catalog?.relatedCategories[indexPath.item] {
            let cell = categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: "CharacteristicID", for: indexPath) as! CharacteristicCollecetionViewCell
            //Заполняем массив полученными итемами
            cell.setDataCharacteristic(item: item)
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    //ЖЦ
    override func awakeFromNib() {
        super.awakeFromNib()
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
