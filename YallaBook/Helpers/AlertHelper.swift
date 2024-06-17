//
//  AlertHelper.swift
//  YallaBook
//
//  Created by Moe on 09/06/2024.
//

import UIKit

class AlertHelper {
    
    static func showAcknowledgmentAlert(on viewController: UIViewController, alertTitle: String, alertMessage: String, completion: (() -> Void)?) {
        
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) {_ in
                completion?()
        }
                
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
        
    }
    
    static func showFailureAlert(on viewController: UIViewController, alertTitle: String, alertMessage: String) {
        
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
        
    }
}
