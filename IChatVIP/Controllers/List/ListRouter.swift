//
//  ListRouter.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 02.04.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ListRoutingLogic {
    //func routeToSomewhere()
}

protocol ListDataPassing {
    var dataStore: ListDataStore? { get }
}

class ListRouter: NSObject, ListRoutingLogic, ListDataPassing {
    
    weak var viewController: ListViewController?
    var dataStore: ListDataStore?
    
    // MARK: Routing
    
//    func routeToSomewhere() {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
//        var destinationDS = destinationVC.router!.dataStore!
//        passDataToSomewhere(source: dataStore!, destination: &destinationDS)
//        navigateToSomewhere(source: viewController!, destination: destinationVC)
//    }

    // MARK: Navigation
    
//    func navigateToSomewhere(source: ListViewController, destination: SomewhereViewController) {
//        source.show(destination, sender: nil)
//    }

    // MARK: Passing data
    
//    func passDataToSomewhere(source: ListDataStore, destination: inout SomewhereDataStore) {
//        destination.name = source.name
//    }

}
