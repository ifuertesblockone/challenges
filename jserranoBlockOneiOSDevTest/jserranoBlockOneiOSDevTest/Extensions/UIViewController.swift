//
//  UIViewController.swift
//  jserranoBlockOneiOSDevTest
//
//  Created by Jonathand Alberto Serrano Serrano on 27/04/20.
//  Copyright © 2020 Jonathand Alberto Serrano Serrano. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func displayAlert(title: String, message: String, acceptButtonText: String, completion: (() -> Void)?) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: acceptButtonText, style: .default))
        
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else {
                return
            }
            strongSelf.present(alertController, animated: true, completion: completion)
        }
    }
    
    func displayLoadingAlert(title: String, message: String) {
        let loadingAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else {
                return
            }
            
            strongSelf.present(loadingAlert, animated: true, completion: nil)
        }
    }
}
