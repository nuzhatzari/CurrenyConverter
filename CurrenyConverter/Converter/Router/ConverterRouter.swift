//
//  ConverterRouter.swift
//  CurrenyConverter
//
//  Created by Nuzhat Zari on 05/01/21.
//

import UIKit

class ConverterRouter: ConverterPresenterToRouterProtocol {
    
    var presenter: ConverterPresenter?
    static func createModule() -> ConverterViewController {
        let view = Utility.mainstoryboard().instantiateViewController(withIdentifier: "ConverterViewController") as! ConverterViewController
        
        let presenter = ConverterPresenter()
        //: ConverterViewToPresenterProtocol & ConverterInteractorToPresenterProtocol
        let interactor = ConverterInteractor()
        //: ConverterPresentorToInteractorProtocol
        let router = ConverterRouter()
        //: ConverterPresenterToRouterProtocol
        let apiDataManager = ConverterAPIDataManager()
        let currencyLocalDataManager = CurrencyListLocalDataManager()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        router.presenter = presenter
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.apiDataManager = apiDataManager
        interactor.currencyLocalDataManager = currencyLocalDataManager
        
        return view
    }

    func navigateToCurrencyList(_ navigationController: UINavigationController) {
        
        let countryListView = CountryListRouter.createModuleAndMakeVisibleFrom(router: self)
        navigationController.pushViewController(countryListView, animated: true)
    }
    
    func loadViewWithSelectedCurrency(currency: ConverterItem) {
        self.presenter?.initWithBaseItemAndReload(currency)
    }
}
