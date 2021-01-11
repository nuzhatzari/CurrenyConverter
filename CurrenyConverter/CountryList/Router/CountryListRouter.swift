//
//  CountryListRouter.swift
//  CurrenyConverter
//
//  Created by Nuzhat Zari on 07/01/21.
//

import UIKit

class CountryListRouter: CountryListPresenterToRouterProtocol {
   
    var converterRouter: ConverterRouter?
    
    static func createModuleAndMakeVisibleFrom(router: ConverterRouter) -> CountryListViewController {
        
        let view = Utility.mainstoryboard().instantiateViewController(withIdentifier: "CountryListViewController") as! CountryListViewController
        
        let presenter = CountryListPresenter()
        let interactor = CountryListInteractor()
        let countryListRouter = CountryListRouter()
        let dataManager = CurrencyListLocalDataManager()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = countryListRouter
        interactor.presenter = presenter
        interactor.dataManager = dataManager
        
        countryListRouter.converterRouter = router
        return view
    }
    
    func moveBackToCurrencyScreen(with selectedCurrency: ConverterItem, and navigationController: UINavigationController) {
        
        converterRouter?.loadViewWithSelectedCurrency(currency: selectedCurrency)
        navigationController.popViewController(animated: true)
    }
    
}
