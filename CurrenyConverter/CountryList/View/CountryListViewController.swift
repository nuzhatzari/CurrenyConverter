//
//  CountryListViewController.swift
//  CurrenyConverter
//
//  Created by Nuzhat Zari on 07/01/21.
//

import UIKit

class CountryListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let reuseIdentifier = "countrylist_cell"
    var presenter: CountryListViewToPresenterProtocol?
    var countryList: [ConverterItem] = [ConverterItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 41
        
        presenter?.fetchCountryList()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CountryListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CountryListTableViewCell
        
        let item = countryList[indexPath.row]
        cell.lblCurrencyName.text = "\(item.code)(\(item.symbol))"
        cell.imgFlag.image = UIImage.init(named: "\(item.country).png")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = countryList[indexPath.row]
        presenter?.didSelectItem(item, andPopFrom: self.navigationController!)
    }
    
}

extension CountryListViewController: CountryListPresenterToViewProtocol {
    func showCountryList(_ countryList: [ConverterItem]) {
        self.countryList = countryList
        tableView.reloadData()
    }
}
