//
//  MarketsViewController.swift
//  finall
//
//  Created by רם צמח on 15/07/2023.
//

import UIKit
//import DropDownx

class MarketsViewController: UIViewController {
    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnSort: UIButton!
    @IBOutlet weak var btnSortOrder: UIButton!
    @IBOutlet weak var notFound: UIView!
    var vData: [Payload] = []
    var vFilteredData: [Payload] = []
  //  var dropdown = DropDown()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
////            self.sortAssetsByDefault()
//        } else {
////            sortAssets(ascendent: self.btnSortOrder.isSelected)
//        }
    }

}

//extension MarketsViewController: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.vFilteredData.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        let cell = tableView.dequeueReusableCell(withIdentifier: MarketsCell.cellId, for: indexPath)
////        (cell as? MarketsCell)?.setupCell(data: self.vFilteredData[indexPath.row])
////        return cell
//    }
//}
