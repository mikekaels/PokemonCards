//
//  CardDetailsInteractor.swift
//  PokemonCard
//
//  Created by Santo Michael Sihombing on 09/02/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

class CardDetailsInteractor: CardDetailsPresenterToInteractorProtocol {
    weak var presenter: CardDetailsInteractorToPresenterProtocol?
}

extension CardDetailsInteractor {
    func fetchCardDetails(id: String) {
        ServiceManager.shared.getCardDetails(id: id) { result in
            self.presenter?.didFetchCardDetails(result: result)
        }
    }
}
