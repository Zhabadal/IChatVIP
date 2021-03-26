//
//  UIViewController + Extension.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 27.03.2021.
//

import UIKit

extension UIViewController {
    
    func showAlert(with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
}
