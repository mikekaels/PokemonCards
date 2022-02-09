//
//  CardDetailsVC.swift
//  PokemonCard
//
//  Created by Santo Michael Sihombing on 09/02/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

class CardDetailsVC: UIViewController {
    var presentor: CardDetailsViewToPresenterProtocol?
    public var delegate: CardDetailsDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.background
    }
}

extension CardDetailsVC: CardDetailsPresenterToViewProtocol {
    
}
