//
//  ConverterViewController.swift
//  CurrenyConverter
//
//  Created by Nuzhat Zari on 04/01/21.
//

import UIKit

class ConverterViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewLoader: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var lblBaseCurrencyName: UILabel!
    @IBOutlet weak var imgBaseCurrencyImage: UIImageView!
    
    var presenter: ConverterViewToPresenterProtocol?
    let reuseIdentifier = "converterItem_cell"
    
    var converterItems: [ConverterItem] = [ConverterItem]()
    var baseConverterItem: ConverterItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 69
        
        configureView()
    }
    
    func configureView() {
        presenter?.loadView()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    //MRK: - Button Action
    @IBAction func onSearchBtnClicked(_ sender: UIButton) {
        presenter?.showCurrencyListView(self.navigationController!)
    }
    
    //MARK: - Loader
    func showLoading() {
        viewLoader.isHidden = false
        self.view.bringSubviewToFront(viewLoader)
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        viewLoader.isHidden = true
        self.view.sendSubviewToBack(viewLoader)
        activityIndicator.stopAnimating()
    }
    
    func showAlert(with message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
              }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - MISC
    func fetchCurrencyData() {
        showLoading()
        presenter?.getCurrencyListWithData(baseConverterItem)
    }
}

extension ConverterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return converterItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as!ConverterItemTableViewCell
        
        let item = converterItems[indexPath.row]
        cell.currencyCode.text = item.code
        cell.currencyValue.text = "\(item.symbol) \(item.amount)"
        cell.flagImageView.image = UIImage.init(named: "\(item.country).png")
        return cell
    }
    
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = converterItems[indexPath.row]
        initWithBaseItemAndReloadView(item)
    }*/
}

extension ConverterViewController: ConverterPresenterToViewProtocol {

    func initWithBaseItemAndReloadView(_ converterItem: ConverterItem) {
        baseConverterItem = converterItem
        lblBaseCurrencyName.text = converterItem.code
        imgBaseCurrencyImage.image = UIImage.init(named: "\(converterItem.country).png")
        fetchCurrencyData()
    }
    
    func reloadTableViewWithData(_ converterItems: [ConverterItem]) {
        self.converterItems = converterItems
        self.tableView.reloadData()
        hideLoading()
    }
    
    func noContentFromServer(_ error: Error) {
        hideLoading()
        self.converterItems.removeAll()
        self.tableView.reloadData()
        showAlert(with: error.localizedDescription)
    }
}
