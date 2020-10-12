//
//  FilterTableViewCell.swift
//  HOFF_MVP
//
//  Created by Асельдер on 14.09.2020.
//  Copyright © 2020 Асельдер. All rights reserved.
//

import UIKit


protocol AlertDelegate {
    
    //Замыкание в данном методе нужно для захвата текста из ВьюПротокола и передачи данного текста в Данный класс
    func showAlert(completionHandler: @escaping (String) -> Void)
}

class FilterTableViewCell: UITableViewCell {
    
    // Outlet
    @IBOutlet weak var showPopUpFilterView: UIView!
    @IBOutlet weak var filterNameLabel: UILabel!
    
    // Делегат
    private var delegate: AlertDelegate!
    
    // Инит делеагата
    func initCell(delegate: AlertDelegate) {
        self.delegate = delegate
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        showPopUpFilterView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showAlert)))
        selectionStyle = .none
    }
    
    //Метод делегата
    @objc func showAlert() {
        delegate.showAlert { (filterName) in
            self.filterNameLabel.text = filterName
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
