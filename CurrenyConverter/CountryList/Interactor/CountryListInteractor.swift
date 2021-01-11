//
//  CountryListInteractor.swift
//  CurrenyConverter
//
//  Created by Nuzhat Zari on 07/01/21.
//

import UIKit

class CountryListInteractor: CountryListPresenterToInteractorProtocol {
    var presenter: CountryListInteractorToPresenterProtocol?
    var dataManager: CurrencyListLocalDataManagerProtocol?
    
    func fetchCountryListFromPlist() {
        guard let currencyListArray = dataManager?.loadCurrencyListArrayFromBundle() else {
            presenter?.countryListFetchedSuccess([])
            return
        }
        
        var currencyListItems = [ConverterItem]()
        for currency in currencyListArray {
            if let object = currency as? [String: Any] {
                //let object = currency as? [String:Any]
                
                var countryListItem = ConverterItem(code: object["code"] as! String, amount: "")
                countryListItem.currencyName = object["name"] as! String
                countryListItem.country = object["country"] as! String
                countryListItem.symbol = object["symbol"] as! String
                currencyListItems.append(countryListItem)
            }
            
             /*if ((currency as? NSDictionary) != nil) {
                let object = currency as? [String:Any]
                
                var countryListItem = ConverterItem(code: object!["code"] as! String, amount: "")
                countryListItem.currencyName = object!["name"] as! String
                countryListItem.country = object!["country"] as! String
                countryListItem.symbol = object!["symbol"] as! String
                currencyListItems.append(countryListItem)
            }*/
        }
        
        presenter?.countryListFetchedSuccess(currencyListItems)
    }
    
    

}
