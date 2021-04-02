//
//  PeopleRouter.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 02.04.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol PeopleRoutingLogic {
    func showAlert(title: String?, message: String)
    func routeToAuth()
}

protocol PeopleDataPassing {
    var dataStore: PeopleDataStore? { get }
}

class PeopleRouter: NSObject, PeopleRoutingLogic, PeopleDataPassing {
    
    weak var viewController: PeopleViewController?
    var dataStore: PeopleDataStore?
    
    // MARK: Routing
    
    func showAlert(title: String?, message: String) {
        if let viewController = viewController {
            let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            let signOutAction = UIAlertAction(title: "Sign Out", style: .destructive) { _ in
                viewController.interactor?.makeRequest(request: .signOut)
            }
            alertVC.addAction(cancelAction)
            alertVC.addAction(signOutAction)
            presentFrom(source: viewController, destination: alertVC)
        }
    }
    
    func routeToAuth() {
        //UIApplication.shared.keyWindow?.rootViewController = AuthVipViewController()
        
        let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        
        keyWindow?.rootViewController = AuthVipViewController()
    }
    
//    func routeToSomewhere() {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
//        var destinationDS = destinationVC.router!.dataStore!
//        passDataToSomewhere(source: dataStore!, destination: &destinationDS)
//        navigateToSomewhere(source: viewController!, destination: destinationVC)
//    }

    // MARK: Navigation
    
    private func presentFrom(source: UIViewController, destination: UIViewController) {
        source.present(destination, animated: true)
    }
    
//    func navigateToSomewhere(source: PeopleViewController, destination: SomewhereViewController) {
//        source.show(destination, sender: nil)
//    }

    // MARK: Passing data
    
//    func passDataToSomewhere(source: PeopleDataStore, destination: inout SomewhereDataStore) {
//        destination.name = source.name
//    }

}
