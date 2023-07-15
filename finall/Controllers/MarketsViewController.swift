//
//  MarketsViewController.swift
//  finall
//
//  Created by רם צמח on 15/07/2023.
//

import UIKit
//import DropDown

class MarketsViewController: UIViewController {
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnSort: UIButton!
    @IBOutlet weak var btnSortOrder: UIButton!
    @IBOutlet weak var notFound: UIView!
    var vData: [Market] = []
    var vFilteredData: [Market] = []
    var Managersx = Manager()
    var searchMin = 1

  //  var dropdown = DropDown()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar for this view controller
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleView()
        Managersx.delegate = self
        Managersx.fetchMarkets()
    }
    
    @objc func dismissKeyboard() {
        tfSearch.resignFirstResponder()
    }

    
    func handleView() {
        tfSearch.text == "Search"
        btnSort.layer.borderWidth = 1.0 // Set the desired border width
        btnSort.layer.borderColor = UIColor(named: "lightBlue")?.cgColor // Set the desired border color
        btnSort.layer.cornerRadius = 8.0
        btnSortOrder.layer.borderWidth = 1.0 // Set the desired border width
        btnSortOrder.layer.borderColor = UIColor(named: "lightBlue")?.cgColor // Set the desired border color
        btnSortOrder.layer.cornerRadius = 8.0
        searchView.layer.borderWidth = 1.0 // Set the desired border width
        searchView.layer.borderColor = UIColor(named: "lightBlue")?.cgColor // Set the desired border color
        searchView.layer.cornerRadius = 8.0
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    @IBAction func backClicked(_ sender: Any) {
        if let navigationController = self.navigationController {
                            // The view controller is embedded in a navigation controller
                            // You can safely use pushViewController(_:animated:) here
                            let storyboard = UIStoryboard(name: "View", bundle: nil)
                            let ctrl = storyboard.instantiateViewController(identifier: "LoginViewController")
                            navigationController.pushViewController(ctrl, animated: true)
                        } else {
                            // The view controller is not embedded in a navigation controller
                            // pushViewController(_:animated:) will not work here
                            print("The view controller is not embedded in a navigation controller.")
                        }
    }
    
    @IBAction func sortTouched() {
        let smallConfig = UIImage.SymbolConfiguration(pointSize: 12, weight: .regular, scale: .medium)
        let smallArrowUp = UIImage(systemName: "chevron.up", withConfiguration: smallConfig)
       // self.dropdown.show()
        self.btnSort.setImage(smallArrowUp, for: .normal)
    }

    @IBAction func sortOrderTouched() {
        self.btnSortOrder.isSelected = !self.btnSortOrder.isSelected
//        if self.sortSeleted == -1 {
//            self.sortAssetsByDefault()
//        } else {
            sortAssets(ascendent: self.btnSortOrder.isSelected)
//        }
    }
    
    func sortAssets(ascendent: Bool) {
//        switch self.sortSeleted {
//        case 0:
//            self.sortAssetsByPrice(ascendent: ascendent)
//            self.tableView.reloadData()
//        case 1:
//            self.sortAssetsByVolume(ascendent: ascendent)
//            self.tableView.reloadData()
//        case 2:
//            self.sortAssetsByChange(ascendent: ascendent)
//            self.tableView.reloadData()
       // default:
            if !self.btnSortOrder.isSelected {
                self.sortAssetsByDefault()
            } else {
                self.tableView.reloadData()
            }
        }
    

    func sortAssetsByDefault() {
        self.vFilteredData.reverse()
        self.tableView.reloadData()
    }
    
    func searchAsset(str: String) {
        if str.count < self.searchMin {
            self.vFilteredData = self.filterAssetsByCurrency()
        } else {
            self.vFilteredData = self.filterAssetsByCurrency().filter { (item) -> Bool in
                (item.marketName?.lowercased().starts(with: str.lowercased()) ?? false) ||
                (item.marketName?.lowercased().starts(with: str.lowercased()) ?? false)
            }
        }
        
        self.vFilteredData.sort { itemA, itemB in
            guard let assetA = itemA.marketName, let assetB = itemB.marketName else {
                return false // Handle the case when asset names are missing
            }
            return assetA < assetB
        }
        
        self.notFound.isHidden = self.vFilteredData.count > 0
        self.sortAssets(ascendent: self.btnSortOrder.isSelected)
    }
    
    func filterAssetsByCurrency() -> [Market] {
        let filtered = self.vData.filter({ item in
            let vCode = item.marketName?.split(separator: "-")
            return vCode?.last?.lowercased() == "usd"
        })
        return filtered
    }
}

extension MarketsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vFilteredData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MarketsCell.cellId, for: indexPath)
        (cell as? MarketsCell)?.setupCell(data: self.vFilteredData[indexPath.row])
        return cell
    }
}

extension MarketsViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //        self.errorLbl.isHidden = true
        if textField == tfSearch {
            if textField.text == "Search" {
                textField.text = ""
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Construct the updated search string by replacing the characters in the specified range
        if textField == tfSearch {
            if textField.text?.count != 0 {
                self.searchAsset(str: textField.text!)
            }else{
                self.searchAsset(str: "")
            }
        }
        
        // Return true to allow the text field to reflect the changes
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == tfSearch {
            if textField.text == "" {
                textField.text = "Search"
                self.searchAsset(str: "")
            }else{
                self.searchAsset(str: textField.text!)
            }
        }
    }
}

extension MarketsViewController: WeatherManagerDelegate {
    func didUpdate(Manager: Manager, weather: [Market]){
        print("aaa")
        vFilteredData = weather
        vData = weather
        DispatchQueue.main.async {
            print("aaa")
            self.tableView.reloadData()
//            self.temperatureLabel.text = weather.tempString
//            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
//            self.cityLabel.text = weather.cityName
        }
    }
    
    func didFailWithError(error: String){
        print(error)
    }
}
