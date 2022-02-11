//
//  CardDetailsPresenter.swift
//  PokemonCard
//
//  Created by Santo Michael Sihombing on 09/02/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

class CardDetailsPresenter: CardDetailsViewToPresenterProtocol {
    weak var view: CardDetailsPresenterToViewProtocol?
    var router: CardDetailsPresenterToRouterProtocol?
    var interactor: CardDetailsPresenterToInteractorProtocol?
    
    func fetchCardDetails(id: String) {
        interactor?.fetchCardDetails(id: id)
    }
}

extension CardDetailsPresenter: CardDetailsInteractorToPresenterProtocol {
    func didFetchCardDetails(result: Result<CardDetails, CustomError>) {
        switch result {
        case .success(let card):
            self.view?.didFetchCardDetails(card: card.data)
        case .failure(let error):
            self.view?.didErrorFetchCardDetails(error: error)
        }
    }
}
