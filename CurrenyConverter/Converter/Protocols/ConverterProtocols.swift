//
//  ConverterProtocols.swift
//  CurrenyConverter
//
//  Created by Nuzhat Zari on 05/01/21.
//

import UIKit

protocol ConverterViewToPresenterProtocol: class {
    
    var view: ConverterPresenterToViewProtocol? { get set }
    var interactor: ConverterPresentorToInteractorProtocol? { get set }
    var router: ConverterPresenterToRouterProtocol? {get set}
    
    /**
    * Add here your methods for communication VIEW -> PRESENTER
    */
    func getCurrencyListWithData(_ baseConverterItem: ConverterItem)
    func loadView()
    func showCurrencyListView(_ navigationController: UINavigationController)
}

protocol ConverterPresenterToViewProtocol: class {
    
    //PRESENTER
    var presenter: ConverterViewToPresenterProtocol? { get set }
    
    /**
    * Add here your methods for communication PRESENTER -> VIEW
    */
    func initWithBaseItemAndReloadView(_ converterItems: ConverterItem)
    func reloadTableViewWithData(_ converterItems: [ConverterItem])
    func noContentFromServer(_ error: Error)
}

protocol ConverterPresentorToInteractorProtocol: class {
    var presenter: ConverterInteractorToPresenterProtocol? { get set }
    
    /**
    * Add here your methods for communication PRESENTER -> INTERACTOR
    */
    func getCurrencyWithData(_ baseConverterItem: ConverterItem)
    func initWithBaseConverterItem()
}

protocol ConverterInteractorToPresenterProtocol: class {
    /**
    * Add here your methods for communication INTERACTOR  -> PRESENTER
    */
    func initWithBaseItemAndReload(_ converterItem: ConverterItem)
    func fetchedConvertedCurrencySuccess(_ convertedCurrency:[ConverterItem])
    func fetchedConvertedCurrencyFailed(_ error: Error)
}

protocol ConverterPresenterToRouterProtocol: class {
    static func createModule()-> ConverterViewController
    func navigateToCurrencyList(_ navigationController: UINavigationController)
}

protocol ConverterAPIDataManagerProtocol {
    func fetchCurrencyFromServerWithData(_ baseConverterItem: ConverterItem, completion: @escaping ((APIResult<ConverterResponse>) -> Void))
}
