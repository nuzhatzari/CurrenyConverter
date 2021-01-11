//
//  ConverterAPIDataManager.swift
//  CurrenyConverter
//
//  Created by Nuzhat Zari on 10/01/21.
//

import UIKit

class ConverterAPIDataManager: ConverterAPIDataManagerProtocol, NetworkManager
{
    var route = "base=BASE"

    init() {}
    
    func fetchCurrencyFromServerWithData(_ baseConverterItem: ConverterItem, completion: @escaping ((APIResult<ConverterResponse>) -> Void)) {
        
        //Fetch data from Server.
        route = "base=\(baseConverterItem.code)"
        
        fetchData(completion: {(result: APIResult<ConverterResponse>) in
            DispatchQueue.main.async {
                completion(result)
            }
        })
    }
}
