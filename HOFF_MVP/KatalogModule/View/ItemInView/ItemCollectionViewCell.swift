//
//  ItemCollectionViewCell.swift
//  HOFF_MVP
//
//  Created by Асельдер on 14.09.2020.
//  Copyright © 2020 Асельдер. All rights reserved.
//

import UIKit
import Cosmos
import SDWebImage

class ItemCollectionViewCell: UICollectionViewCell {
    
    //Outlet
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var isFavoriteButton: UIButton!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var newPriceLabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    
    //Констрейнт ширины из сторибоарда
    @IBOutlet weak var imageWidthConstraint: NSLayoutConstraint!
    
    var currentItem: MenuItem.Product!
    
    func setDataItem(item: MenuItem.Product) {
        
        currentItem = item
        
        // Изображения
        itemImage.sd_setImage(with: URL(string: item.image), completed: nil)
        imageWidthConstraint.constant = self.frame.width
        
        // Плашка лучшая цена / скидка
        self.discountLabel.layer.cornerRadius = 2
        self.discountLabel.textColor = .white
        
        if item.isBestPrice == true || item.prices.old <= item.prices.new {
            self.oldPriceLabel.isHidden = true
            self.discountLabel.isHidden = false
            self.discountLabel.layer.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.7333333333, blue: 0, alpha: 1)
            self.discountLabel.text = "Лучшая цена" + "    "
        } else {
            if item.prices.old > item.prices.new {
                let discount = 100 - (item.prices.new * 100 / item.prices.old)
                self.oldPriceLabel.isHidden = false
                self.discountLabel.isHidden = false

                let oldPriseStriked = NSAttributedString(string: "\(item.prices.old)", attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])

                self.oldPriceLabel.attributedText = oldPriseStriked
                self.discountLabel.layer.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0, blue: 0, alpha: 1)
                self.discountLabel.text = "-\(discount)%" + "    "
            } else {
                self.oldPriceLabel.isHidden = true
                self.discountLabel.isHidden = true
            }
        }
        
        //Цена с отступами в тысячах
        self.oldPriceLabel.text = String(item.prices.old.stringFormatedWithSepator) + " ₽"
        self.newPriceLabel.text = String(item.prices.new.stringFormatedWithSepator) + " ₽"
        
        //Имена
        self.nameLabel.text = item.name
        self.statusLabel.text = item.statusText
        
        //Звезды
//        self.ratingView.rating = item.rating ?? 0.0
        self.ratingView.rating = 4.0
        self.ratingView.text = "160"
//        self.ratingView.text = "(\(item.numberOfReviews))"
        
        // Проверка ЮсерДефаултс
        if CustomUserDefaults.shared.isFavorite(item: item) {
            self.isFavoriteButton.setImage(#imageLiteral(resourceName: "HeartTrue"), for: .normal)
        } else {
            self.isFavoriteButton.setImage(#imageLiteral(resourceName: "HeartFalse"), for: .normal)
        }
    }
    
    @IBAction func isFavoriteAction(_ sender: Any) {
            let _ = CustomUserDefaults.shared.checkFavoriteOnClick(item: currentItem)
            if CustomUserDefaults.shared.isFavorite(item: currentItem) {
                self.isFavoriteButton.setImage(#imageLiteral(resourceName: "HeartTrue"), for: .normal)
            } else {
                self.isFavoriteButton.setImage(#imageLiteral(resourceName: "HeartFalse"), for: .normal)
            }
        }
    }
