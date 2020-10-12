//
//  IndicatorFooterCollectionReusableView.swift
//  HOFF_MVP
//
//  Created by Асельдер on 24.09.2020.
//  Copyright © 2020 Асельдер. All rights reserved.
//

import UIKit

class IndicatorFooterCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var footerIndicator: UIActivityIndicatorView!
 
    override func awakeFromNib() {
        super.awakeFromNib()
        footerIndicator.startAnimating()
    }
}
