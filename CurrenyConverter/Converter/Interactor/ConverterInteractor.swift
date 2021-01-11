//
//  ConverterInteractor.swift
//  CurrenyConverter
//
//  Created by Nuzhat Zari on 05/01/21.
//

import UIKit

class ConverterInteractor: ConverterPresentorToInteractorProtocol  {
    
    var presenter: ConverterInteractorToPresenterProtocol?
    var apiDataManager: ConverterAPIDataManagerProtocol?
    var currencyLocalDataManager: CurrencyListLocalDataManager?
    
    func getCurrencyWithData(_ baseConverterItem: ConverterItem) {
        
        apiDataManager?.fetchCurrencyFromServerWithData(baseConverterItem, completion: { (result: APIResult<ConverterResponse>) in
            
            switch result {
            case .success(let json):
                if json.rates != nil {
                    let result = self.parseDataFromServer(json)
                    self.presenter?.fetchedConvertedCurrencySuccess(result)
                }else {
                    var defaultError: NSError?
                    if let errorMsg = json.error?.type, let code = json.error?.code {
                        defaultError = NSError(domain: "Error", code: code, userInfo: [
                            NSLocalizedDescriptionKey: NSLocalizedString(errorMsg, comment: "")
                        ])
                    }else {
                        defaultError = NSError(domain: "Error", code: 0, userInfo: [
                            NSLocalizedDescriptionKey: NSLocalizedString("Something went wrong, please try again later.", comment: "")
                        ])

                    }
                    
                    self.presenter?.fetchedConvertedCurrencyFailed(defaultError!)
                }
                
            case .failure(let error):
                self.presenter?.fetchedConvertedCurrencyFailed(error)
            }
        })
        
    }

    func initWithBaseConverterItem() {
        var converterItem = ConverterItem(code: "EUR", amount: "1")
        converterItem.country = "Europe"
        presenter?.initWithBaseItemAndReload(converterItem)
    }
}

extension ConverterInteractor: ParseData {

    func parseDataFromServer(_ input: ConverterResponse) -> [ConverterItem] {
        
        guard let localCountryList = currencyLocalDataManager?.loadCurrencyListArrayFromBundle() as? [Dictionary<String, String>] else {
            return []
        }
        
        var converterItems = [ConverterItem]()
        if let rates = input.rates {
            for (key, value) in rates {
                
                let country = localCountryList.filter { (dict: Dictionary<String, String>) -> Bool in
                    return dict["code"]?.caseInsensitiveCompare(key) == ComparisonResult.orderedSame
                }
                if country.count > 0 {
                    var item = ConverterItem(code: key, amount: value.strCurrencyFormat())
                    item.country = country[0]["country"] ?? ""
                    item.flag = country[0]["flag"] ?? ""
                    item.symbol = country[0]["symbol"] ?? ""
                    converterItems.append(item)
                }
            }
        }
        converterItems.sort { (item1: ConverterItem, item2: ConverterItem) -> Bool in
            return item1.code.compare(item2.code) == ComparisonResult.orderedAscending
        }
        return converterItems
    }
}

struct ConverterResponse: Decodable {
    //let success: Bool
    let base: String?
    let rates: Dictionary<String, Double>?
    let error: APIError?
    
    /*subscript(key: String) -> Any? {
           return self.value(forKey: key)
    }*/
}

struct APIError: Decodable {
    let code: Int
    let type: String
}

extension Double {
    
    func strCurrencyFormat() -> String {
        return String(format:"%.2f", self)
    }
}
