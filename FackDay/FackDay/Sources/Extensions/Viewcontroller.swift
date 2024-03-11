//
//  Viewcontroller.swift
//  FackDay
//
//  Created by Vegeta on 22/03/2021.
//

import UIKit
import SnapKit
import Foundation
import StoreKit

extension UIViewController {
    func topSafe() -> ConstraintItem {
        return self.view.safeAreaLayoutGuide.snp.top
    }
    func botSafe() -> ConstraintItem {
        return self.view.safeAreaLayoutGuide.snp.bottom
    }
}

extension UIViewController {
    func showAlert(title: String? = nil, message: String? = nil, actionTile: String = "OK", cancel: Bool = false, completion: ((Bool) -> Void)? = nil) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTile, style: .default, handler: { _ in
            if completion != nil {
                completion!(true)
            }
        })
        alertVC.addAction(action)
        if let popoverController = alertVC.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
        }
        
        if cancel {
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
                if completion != nil {
                    completion!(false)
                }
            })
            alertVC.addAction(cancelAction)
        }
        self.present(alertVC, animated: true, completion: {
            
        })
    }
}
