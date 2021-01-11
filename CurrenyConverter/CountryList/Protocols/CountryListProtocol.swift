//
//  CountryListProtocol.swift
//  CurrenyConverter
//
//  Created by Nuzhat Zari on 07/01/21.
//

import UIKit

protocol CountryListViewToPresenterProtocol: class {
    var view: CountryListPresenterToViewProtocol? { get set }
    var interactor: CountryListPresenterToInteractorProtocol? { get set }
    var router: CountryListPresenterToRouterProtocol? { get set }
    
    func fetchCountryList()
    func didSelectItem(_ currency: ConverterItem, andPopFrom navigationController: UINavigationController)
}

protocol CountryListPresenterToInteractorProtocol: class {
    var presenter: CountryListInteractorToPresenterProtocol? { get set }
    
    func fetchCountryListFromPlist()
}

protocol CountryListInteractorToPresenterProtocol: class {
    func countryListFetchedSuccess(_ countryList: [ConverterItem])
}

protocol CountryListPresenterToViewProtocol: class {
    var presenter: CountryListViewToPresenterProtocol? { get set }
    
    func showCountryList(_ countryList: [ConverterItem])
}

protocol CountryListPresenterToRouterProtocol: class {
    static func createModuleAndMakeVisibleFrom(router: ConverterRouter) -> CountryListViewController
    func moveBackToCurrencyScreen(with selectedCurrency: ConverterItem, and navigationController: UINavigationController)
}

protocol CurrencyListLocalDataManagerProtocol {
    func loadCurrencyListArrayFromBundle() -> NSArray?
}
