//
//  UIViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Dinar Ilalov on 29/03/2019.
//  Copyright © 2019 ekireev. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func addChild(_ viewController: UIViewController, andPlaceAt view: UIView?) {
        
        let viewToPlace: UIView = view ?? viewController.view
        
        self.addChild(viewController)
        viewToPlace.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
    
}
