//
//  ItemTableViewCell.swift
//  HOFF_MVP
//
//  Created by Асельдер on 14.09.2020.
//  Copyright © 2020 Асельдер. All rights reserved.
//

import UIKit

protocol ItemsDelegate {
    func loadMore()
}

class ItemTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // Оутлет
    @IBOutlet weak var itemCollectionView: UICollectionView!
    
    var productItem: [MenuItem.Product] = [] {
        didSet {
            itemCollectionView.reloadData()
        }
    }
    
    //Делегат
    private var delegate: ItemsDelegate!
    
    //Для футера
    var isLoading = false
    
    //ЖЦ
    override func awakeFromNib() {
        super.awakeFromNib()
        
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        
        // Регистрируем ячейку
        let catalogNib = UINib(nibName: "KatalogViewNib", bundle: nil)
        itemCollectionView.register(catalogNib, forCellWithReuseIdentifier: "CatalogNib")
        
        // Регистрируем Nib футера в Collection View
        let loadingReusableNib = UINib(nibName: "LoadingNib", bundle: nil)
        itemCollectionView.register(loadingReusableNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "IndicatorIdNib")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //Заполняем массив категорий
    func setProductItem (product: [MenuItem.Product], delegate: ItemsDelegate) {
        self.productItem = product
        self.delegate = delegate
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        productItem.count
    }
    
    // Регистрируем ячейку
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = itemCollectionView.dequeueReusableCell(withReuseIdentifier: "CatalogNib", for: indexPath) as? ItemCollectionViewCell {
            
            //Заполняем массив продуктов
            cell.setDataItem(item: productItem[indexPath.row])
            
            cell.layer.cornerRadius = 4
            cell.layer.shadowPath = UIBezierPath(rect: cell.bounds).cgPath
            cell.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.04567101884)
            cell.layer.shadowOpacity = 1
            cell.layer.shadowOffset = CGSize(width: 0, height: 2)
            cell.layer.shadowRadius = 6
            cell.clipsToBounds = false
            cell.layer.masksToBounds = false
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    // Размер ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //Динамический размер ячейки КВС
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidth = (collectionView.frame.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right - flowLayout.minimumInteritemSpacing) / 2
        let cellHeight = cellWidth * 1.8
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    //Paginig
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let indexPathCount = indexPath.row + 2
        
        if indexPathCount == productItem.count && !self.isLoading {
            print("True iteration")
            loadMoreData()
        } else {
            print("False iteration count - \(productItem.count), indexPathRow - \(indexPathCount)")
        }
    }
    
    // Вызов подгрузки данных из презентера
    func loadMoreData() {
        if !self.isLoading {
            self.isLoading = true
            self.delegate?.loadMore()
            self.isLoading = false
        }
    }
    
    // Задаем размер футера
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        if productItem.isEmpty {
            print("Indicator is invisible")
            return CGSize.zero
        } else {
            print("Indicator is visible")
            return CGSize(width: collectionView.bounds.size.width, height: 55)
        }
    }
    
    // Возврат самого футера
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let aFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "IndicatorIdNib", for: indexPath) as! IndicatorFooterCollectionReusableView
            return aFooterView
        }
        return UICollectionReusableView()
    }
}
