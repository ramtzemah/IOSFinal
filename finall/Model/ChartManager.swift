//
//  ChartManager.swift
//  INX
//
//  Created by רם צמח on 23/11/2021.
//

import Foundation
import Charts

class ChartManager: NSObject {

    static func prepareChart(chart: LineChartView,
                             data: [ChartDataEntry],
                             label: String,
                             color: UIColor = .lightGray,
                             fillColor: UIColor = .clear,
                             minValue: Double = 0,
                             maxValue: Double = 0,
                             linesValueFont: UIFont = UIFont(name: "HelveticaNeue-Thin", size: 10)!,
                             delegate: ChartViewDelegate?) {

        chart.delegate = delegate
        let set = LineChartDataSet(entries: data, label: label)
        set.drawCirclesEnabled = false
        set.mode = .linear//.cubicBezier
        set.lineWidth = 1
        set.setColor(color)
        set.drawFilledEnabled = fillColor != .clear
        set.fill = ColorFill(color: fillColor)
        set.fillAlpha = 0.8
        set.drawHorizontalHighlightIndicatorEnabled = false
        set.drawVerticalHighlightIndicatorEnabled = false
        set.highlightColor = .systemRed
        let data = LineChartData(dataSet: set)
        data.setDrawValues(false)
        chart.data = data
//        chart.animate(xAxisDuration: 2.0)
        chart.backgroundColor = .clear
        chart.gridBackgroundColor = .clear
        chart.drawGridBackgroundEnabled = false
        chart.leftAxis.enabled = true
        chart.leftAxis.drawLabelsEnabled = false
        chart.leftAxis.drawGridLinesEnabled = false
        chart.leftAxis.drawAxisLineEnabled = false
        chart.leftAxis.drawZeroLineEnabled = false
        chart.leftAxis.axisLineColor = .clear
        chart.leftAxis.drawLimitLinesBehindDataEnabled = false
        chart.rightAxis.enabled = false
        chart.xAxis.enabled = false
        chart.legend.enabled = false
        chart.isUserInteractionEnabled = false
        chart.setViewPortOffsets(left: 0, top: 0, right: 0, bottom: 0)
        chart.leftAxis.removeAllLimitLines()
        // Max and Min values
        if minValue != 0 || maxValue != 0 {
            let lineColor = UIColor(white: 1, alpha: 0.7)
            let maxLine = ChartLimitLine(limit: maxValue, label: "H:\(NSNumber(value: maxValue).toCurrency())")
            maxLine.lineDashLengths = [3.0]
            maxLine.lineWidth = 0.5
            maxLine.enabled = true
            maxLine.lineColor = lineColor
            maxLine.valueTextColor = lineColor
            maxLine.valueFont = linesValueFont
            maxLine.yOffset = -15
            let minLine = ChartLimitLine(limit: minValue, label: "L:\(NSNumber(value: minValue).toCurrency())")
            minLine.lineDashLengths = [3.0]
            minLine.lineWidth = 0.5
            minLine.enabled = true
            minLine.lineColor = lineColor
            minLine.valueTextColor = lineColor
            minLine.valueFont = linesValueFont
            chart.leftAxis.addLimitLine(minLine)
            chart.leftAxis.addLimitLine(maxLine)
            chart.leftAxis.drawAxisLineEnabled = true
            chart.leftAxis.axisMinimum = minValue
            chart.leftAxis.axisMaximum = maxValue
        }
    }
    
    static func getChartDataEntryFrom(data: [GraphData]) -> [ChartDataEntry] {
        var chartData: [ChartDataEntry] = []
        for item in data {
            if let time = item.timestamp, let value = item.close {
                chartData.append(ChartDataEntry(x: time, y: value))
            }
        }
        return chartData
    }
}
