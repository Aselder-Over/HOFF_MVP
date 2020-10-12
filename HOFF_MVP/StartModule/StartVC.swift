//
//  ViewController.swift
//  HOFF_MVP
//
//  Created by Асельдер on 13.09.2020.
//  Copyright © 2020 Асельдер. All rights reserved.
//

import UIKit

class StartVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //убираем название предыдущего экрана при переходе на новый
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    @IBAction func perehodAction(_ sender: Any) {
        // Засовываем в переменную файл сторибоарда
        let storyboard = UIStoryboard(name: "Catalog", bundle: nil)
        // ЗАсосываем во вторую перменную ВьюКонтроллер по ID
        let catalog = storyboard.instantiateViewController(identifier: "Catalog")
        // Пушим новый вью контроллер
        self.navigationController?.pushViewController(catalog, animated: true)
    }
    
}

