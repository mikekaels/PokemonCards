//
//  Extension + UIViewController.swift
//  PokemonCard
//
//  Created by Santo Michael Sihombing on 08/02/22.
//

import UIKit

extension UIViewController {
    func navigationBarAppearance() {
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = Color.navigation
            navigationController?.navigationBar.standardAppearance = appearance;
            navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            UISearchBar.appearance().tintColor = UIColor.white
        }
    }
}
