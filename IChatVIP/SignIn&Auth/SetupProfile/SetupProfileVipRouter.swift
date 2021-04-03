//
//  SetupProfileVipRouter.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 28.03.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol SetupProfileVipRoutingLogic {
    func showAlert(title: String, message: String)
    func routeToMainTabBar()
    func showImagePicker()
}

protocol SetupProfileVipDataPassing {
    var dataStore: SetupProfileVipDataStore? { get }
}

class SetupProfileVipRouter: NSObject, SetupProfileVipRoutingLogic, SetupProfileVipDataPassing {
    
    weak var viewController: SetupProfileVipViewController?
    var dataStore: SetupProfileVipDataStore?
    
    // MARK: Routing
    
    func showAlert(title: String, message: String) {
        if let viewController = viewController {
            let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { [weak self] _ in
                if self?.dataStore?.muser != nil {
                    self?.routeToMainTabBar()
                }
            }
            alertVC.addAction(okAction)
            presentFrom(source: viewController, destination: alertVC)
        }
    }
    
    func routeToMainTabBar() {
        if let viewController = viewController, let homeDS = dataStore, let muser = homeDS.muser {
            let mainTabBarVC = MainTabBarViewController(currentUser: muser)
            mainTabBarVC.modalPresentationStyle = .fullScreen
            presentFrom(source: viewController, destination: mainTabBarVC)
        }
    }
    
    func showImagePicker() {
        if let viewController = viewController {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = viewController
            imagePickerController.sourceType = .photoLibrary
            presentFrom(source: viewController, destination: imagePickerController)
        }
    }
    
    // MARK: Navigation
    
    private func presentFrom(source: UIViewController, destination: UIViewController) {
        source.present(destination, animated: true)
    }
}
