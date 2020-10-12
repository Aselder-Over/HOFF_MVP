//
//  CharacteristicCollecetionViewCellCollectionViewCell.swift
//  HOFF_MVP
//
//  Created by Асельдер on 14.09.2020.
//  Copyright © 2020 Асельдер. All rights reserved.
//

import UIKit

class CharacteristicCollecetionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoriesLabel: UILabel!
    
    // Заполнение ячейки данными
    func setDataCharacteristic(item: MenuItem.RelatedCategories) { categoriesLabel.text = item.name }

}
