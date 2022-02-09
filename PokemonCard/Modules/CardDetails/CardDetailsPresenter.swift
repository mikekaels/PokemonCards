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
}

extension CardDetailsPresenter: CardDetailsInteractorToPresenterProtocol {

}
