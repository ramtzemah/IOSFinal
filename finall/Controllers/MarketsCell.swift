//
//  MarketsCell.swift
//  INX
//
//  Created by רם צמח on 23/12/2021.
//

import UIKit
import Charts

class MarketsCell: UITableViewCell {
    static let cellId = "marketsCell_id"
    weak var delegate: ChartViewDelegate?
    //  @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var lblAsset: UILabel!
    @IBOutlet weak var assetIcon: UIImageView!
    @IBOutlet weak var lblAssetValue: UILabel!
    @IBOutlet weak var lblAssetDesc: UILabel!
    @IBOutlet weak var btnAssetTrend: UIButton!
    @IBOutlet weak var bottomIndicator: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(data: Market) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal


        let codes = data.marketName?.split(separator: "-")
        self.assetIcon.load(urlString: MarketsCell.getAssetIcon(assett: String(codes?.first ?? "")), placeholder: nil)
        self.btnAssetTrend.setImage(UIImage(named: "arrow_up"), for: .normal)
        self.btnAssetTrend.setImage(UIImage(named: "arrow_down"), for: .selected)
        
        self.lblAsset.text = data.marketName
        if let formattedNumber = numberFormatter.string(from: NSNumber(value: Double(data.lastPrice!))) {
            print(formattedNumber) // Output: "12,354,689.123456789"
            let formattedString = formattedNumber + "$"
            self.lblAssetValue.text = formattedString
        }
   //     self.lblAssetValue.text =  String(format: "%.0f", data.lastPrice!)+"$"
        
        if let asset = data.marketName, let index = asset.firstIndex(of: "-") {
            let newAsset = asset.prefix(upTo: index)
            self.lblAssetDesc.text = "\(String(newAsset)) Vol: \(MarketsCell.formatVolNumber(data.vol ?? 0))"
            self.lblAssetDesc.text = "\(String(newAsset)) Vol: \(MarketsCell.formatVolNumber(data.vol ?? 0))"
        }
        self.btnAssetTrend.isHighlighted = false
        var color: UIColor!
        if (data.lastPrice ?? 0) != 0 {
            color = UIColor(named: "lightBlue")
        }
        //        else if (data.lastPricePercentageChange ?? 0) < 0 {
        //            color = UIColor(named: "redError")
        //        } else {
        //            color = UIColor(named: "greenTrend")
        //        }
        self.bottomIndicator.backgroundColor = color
        self.btnAssetTrend.isSelected = (data.per ?? 0) < 0
        if (data.per ?? 0) == 0 {
            self.btnAssetTrend.setImage(UIImage(), for: .normal)
            self.btnAssetTrend.setImage(UIImage(), for: .selected)
            self.btnAssetTrend.setTitleColor(UIColor(named: "lightBlue"), for: .selected)
            self.btnAssetTrend.setTitleColor(UIColor(named: "lightBlue"), for: .normal)
        } else {
            self.btnAssetTrend.setImage(UIImage(named: "arrow_up"), for: .normal)
            self.btnAssetTrend.setImage(UIImage(named: "arrow_down"), for: .selected)
            self.btnAssetTrend.setTitleColor(UIColor(named: "redError"), for: .selected)
            self.btnAssetTrend.setTitleColor(UIColor(named: "greenTrend"), for: .normal)
        }
        
        
        let formattedTrend = "\(data.per ?? 0.0)%".replacingOccurrences(of: "-", with: "")
        self.btnAssetTrend.setTitle(formattedTrend, for: .normal)
        //let graphData = (data.graphData != nil) ? data.graphData : Array([data.currentHour!])
        //        let chartData = ChartManager.getChartDataEntryFrom(data: graphData ?? [])
        //        ChartManager.prepareChart(chart: self.lineChartView,
        //                                  data: chartData,
        //                                  label: data.marketName ?? "",
        //                                  color: self.btnAssetTrend.titleLabel?.textColor ?? .lightGray,
        //                                  delegate: delegate)
    }
    static func formatVolNumber(_ number: Int) -> String {
        
        let formatter = NumberFormatter()
        formatter.roundingMode = .halfUp
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "en_US")
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        
        if abs(number / 1000000) >= 1 {
            return "\(formatter.string(from: NSNumber(value: number / 1000000)) ?? "")M"
            
        } else if abs(number / 1000) >= 1 {
            return "\(formatter.string(from: NSNumber(value: number / 1000)) ?? "")K"
            
        } else {
            return formatter.string(from: NSNumber(value: number)) ?? ""
            
        }
    }
    
    static func getAssetIcon(assett: String) -> String {
        let assets = UserDefaults.standard.array(forKey: "SavedObjects") as? [Data] ?? []
        
        for data in assets {
            if let asset = try? JSONDecoder().decode(Asset.self, from: data) {
                if assett.lowercased() == asset.symbol?.lowercased() {
                    return asset.iconLink!
                }
            }
        }
        
        return "a"
    }
}
