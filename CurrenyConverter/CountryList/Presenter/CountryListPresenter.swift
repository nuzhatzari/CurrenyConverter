//
//  CountryListPresenter.swift
//  CurrenyConverter
//
//  Created by Nuzhat Zari on 07/01/21.
//

import UIKit

class CountryListPresenter: CountryListViewToPresenterProtocol {
    var view: CountryListPresenterToViewProtocol?
    var interactor: CountryListPresenterToInteractorProtocol?
    var router: CountryListPresenterToRouterProtocol?
    
    func fetchCountryList() {
        interactor?.fetchCountryListFromPlist()
    }
    
    func didSelectItem(_ currency: ConverterItem, andPopFrom navigationController: UINavigationController) {
        router?.moveBackToCurrencyScreen(with: currency, and: navigationController)
    }
}
 
extension CountryListPresenter: CountryListInteractorToPresenterProtocol {
    func countryListFetchedSuccess(_ countryList: [ConverterItem]) {
        view?.showCountryList(countryList)
    }
}

