//
//  ProfileRouter.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 02.04.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ProfileRoutingLogic {
    //func routeToSomewhere()
}

protocol ProfileDataPassing {
    var dataStore: ProfileDataStore? { get }
}

class ProfileRouter: NSObject, ProfileRoutingLogic, ProfileDataPassing {
    
    weak var viewController: ProfileViewController?
    var dataStore: ProfileDataStore?
    
    // MARK: Routing
    
//    func routeToSomewhere() {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
//        var destinationDS = destinationVC.router!.dataStore!
//        passDataToSomewhere(source: dataStore!, destination: &destinationDS)
//        navigateToSomewhere(source: viewController!, destination: destinationVC)
//    }

    // MARK: Navigation
    
//    func navigateToSomewhere(source: ProfileViewController, destination: SomewhereViewController) {
//        source.show(destination, sender: nil)
//    }

    // MARK: Passing data
    
//    func passDataToSomewhere(source: ProfileDataStore, destination: inout SomewhereDataStore) {
//        destination.name = source.name
//    }

}
