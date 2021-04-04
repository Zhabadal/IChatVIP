//
//  ChatsRouter.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 04.04.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ChatsRoutingLogic {
    func showAlert(title: String?, message: String)
    func showImagePicker()
}

protocol ChatsDataPassing {
    var dataStore: ChatsDataStore? { get }
}

class ChatsRouter: NSObject, ChatsRoutingLogic, ChatsDataPassing {
    
    weak var viewController: ChatsViewController?
    var dataStore: ChatsDataStore?
    
    // MARK: Routing
    
    func showAlert(title: String?, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alertVC.addAction(okAction)
        presentFrom(source: viewController!, destination: alertVC)
    }
    
    func showImagePicker() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = viewController
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePickerController.sourceType = .camera
        } else {
            imagePickerController.sourceType = .photoLibrary
        }
        
        presentFrom(source: viewController!, destination: imagePickerController)
    }

    // MARK: Navigation
    
    private func presentFrom(source: UIViewController, destination: UIViewController) {
        source.present(destination, animated: true)
    }

}
