//
//  SignUpVipRouter.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 28.03.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SignUpVipRoutingLogic {
    func routeToParent()
    func showAlert(title: String, message: String, type: SignUpVip.AlertType)
    func routeToSetupProfile()
}

protocol SignUpVipDataPassing {
    var dataStore: SignUpVipDataStore? { get }
}

class SignUpVipRouter: NSObject, SignUpVipRoutingLogic, SignUpVipDataPassing {
    
    weak var viewController: SignUpVipViewController?
    var dataStore: SignUpVipDataStore?
    
    // MARK: Routing
    
    func routeToParent() {
        let destinationVC = viewController?.presentingViewController as! AuthVipViewController
        navigateToParent(source: viewController!, destination: destinationVC)
    }
    
    func showAlert(title: String, message: String, type: SignUpVip.AlertType) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            switch type {
            case .registered:
                self.routeToSetupProfile()
            case .other:
                break
            }
        }
        alertVC.addAction(okAction)
        presentFrom(source: viewController!, destination: alertVC)
    }
    
    func routeToSetupProfile() {        
        let destinationVC = SetupProfileVipViewController()
        var destinationDS = destinationVC.router!.dataStore!
        passDataToSetupProfile(source: dataStore!, destination: &destinationDS)
        presentFrom(source: viewController!, destination: destinationVC)
    }
    
    // MARK: - Navigation
    
    private func navigateToParent(source: SignUpVipViewController, destination: AuthVipViewController) {
        source.dismiss(animated: true) {
            destination.router?.routeToLogin()
        }
    }
    
    private func presentFrom(source: UIViewController, destination: UIViewController) {
        source.present(destination, animated: true)
    }
    
    // MARK: - Passing data
    
    private func passDataToSetupProfile(source: SignUpVipDataStore, destination: inout SetupProfileVipDataStore) {
        destination.user = source.user
    }
}
