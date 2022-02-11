//
//  Alertable.swift
//  PokemonCard
//
//  Created by Santo Michael Sihombing on 12/02/22.
//

import UIKit

public protocol Alertable {}
public extension Alertable where Self: UIViewController {
    
    func showAlert(title: String,
                   message: String,
                   actionTitle: String,
                   completion: @escaping(() -> Void)) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: actionTitle,
                                      style: UIAlertAction.Style.default,
                                      handler: { _ in completion() }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithAction(title: String,
                             message: String,
                             actionLeftTitle: String,
                             actionRightTitle: String,
                             onActionLeftClick: @escaping(() -> Void),
                             onActionRightClick: @escaping(() -> Void)) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: actionLeftTitle,
                                      style: .destructive,
                                      handler: { _ in onActionLeftClick() }))
        
        alert.addAction(UIAlertAction(title: actionRightTitle,
                                      style: .default,
                                      handler: { _ in onActionRightClick() }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
