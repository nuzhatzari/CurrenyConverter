//
//  ConverterPresenter.swift
//  CurrenyConverter
//
//  Created by Nuzhat Zari on 05/01/21.
//

import UIKit

class ConverterPresenter: ConverterViewToPresenterProtocol {
    var view: ConverterPresenterToViewProtocol?
    var interactor: ConverterPresentorToInteractorProtocol?
    var router: ConverterPresenterToRouterProtocol?
    
    func getCurrencyListWithData(_ baseConverterItem: ConverterItem) {
        interactor?.getCurrencyWithData(baseConverterItem)
    }
    
    func loadView() {
        interactor?.initWithBaseConverterItem()
    }
    
    func showCurrencyListView(_ navigationController: UINavigationController) {
        router?.navigateToCurrencyList(navigationController)
    }
    
    func initWithBaseItemAndReload(_ converterItem: ConverterItem) {
        view?.initWithBaseItemAndReloadView(converterItem)
    }
}

extension ConverterPresenter: ConverterInteractorToPresenterProtocol {
    func fetchedConvertedCurrencySuccess(_ convertedCurrency: [ConverterItem]) {
        view?.reloadTableViewWithData(convertedCurrency)
    }
    
    func fetchedConvertedCurrencyFailed(_ error: Error) {
        view?.noContentFromServer(error)
    }
}
