//
//  ErrorAlert.swift
//  PracticeProject
//
//  Created by Rodney Zhang on 2024-08-05.
//

import Foundation
import UIKit

class ErrorAlertController {
    static func presentErrorAlert(on viewController: UIViewController, message: String, retryHandler: @escaping () -> Void) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let retryAction = UIAlertAction(title: "Retry", style: .default) { _ in
            retryHandler()
        }
        alertController.addAction(okAction)
        alertController.addAction(retryAction)
        DispatchQueue.main.async {
            viewController.present(alertController, animated: true, completion: nil)
        }
        
    }
}
