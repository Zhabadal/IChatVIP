//
//  LoginVipRouter.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 28.03.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol LoginVipRoutingLogic {
    func routeToParent()
    func showAlert(title: String, message: String, type: LoginVip.AlertType)
    func routeToMainTabBar()
    func routeToSetupProfile()
}

protocol LoginVipDataPassing {
    var dataStore: LoginVipDataStore? { get }
}

class LoginVipRouter: NSObject, LoginVipRoutingLogic, LoginVipDataPassing {
    
    weak var viewController: LoginVipViewController?
    var dataStore: LoginVipDataStore?
    
    // MARK: Routing
    
    func routeToParent() {
        let destinationVC = viewController?.presentingViewController as! AuthVipViewController
        navigateToParent(source: viewController!, destination: destinationVC)
    }
    
    func showAlert(title: String, message: String, type: LoginVip.AlertType) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            switch type {
            case .authorized:
                self.routeToMainTabBar()
            case .registered:
                self.routeToSetupProfile()
            case .other:
                break
            }
        }
        alertVC.addAction(okAction)
        presentFrom(source: viewController!, destination: alertVC)
    }
    
    func routeToMainTabBar() {
        let mainTabBarVC = MainTabBarViewController(currentUser: dataStore!.muser!)
        mainTabBarVC.modalPresentationStyle = .fullScreen
        presentFrom(source: viewController!, destination: mainTabBarVC)
    }
    
    func routeToSetupProfile() {
        let destinationVC = SetupProfileVipViewController()
        var destinationDS = destinationVC.router!.dataStore!
        passDataToSetupProfile(source: dataStore!, destination: &destinationDS)
        presentFrom(source: viewController!, destination: destinationVC)
    }
    
    // MARK: - Navigation
    
    func navigateToParent(source: LoginVipViewController, destination: AuthVipViewController) {
        source.dismiss(animated: true) {
            destination.router?.routeToSignUp()
        }
    }
    
    private func presentFrom(source: UIViewController, destination: UIViewController) {
        source.present(destination, animated: true)
    }
    
    // MARK: - Passing data
    
    private func passDataToSetupProfile(source: LoginVipDataStore, destination: inout SetupProfileVipDataStore) {
        destination.user = source.user
    }
    
}
