//
//  UIViewController + Extension.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 27.03.2021.
//

import UIKit

extension UIViewController {
    
    func  showAlert(with title: String, message: String, completion: @escaping () -> Void = {}) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default) { _ in
            completion()
        }
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    func configure<T: SelfConfiguringCell, U: Hashable>(collectionView: UICollectionView, cellType: T.Type, with value: U, for indexPath: IndexPath) -> T {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(cellType)")
        }
        
        cell.configure(with: value)
        return cell
    }
    
}
