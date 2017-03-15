//
//  WAWeatherDataCellGenerator.swift
//  WeatherApp
//
//  Created by Mahesh Thakre on 3/14/17.
//  Copyright © 2017 Mahesh Thakre. All rights reserved.
//
//  Factory method to generate cells for search results controller tableview

import UIKit

class WAWeatherDataCellGenerator {
    
    static let shared = WAWeatherDataCellGenerator()
    
    func getCell(sourceVC: UIViewController, tableView: UITableView, indexPath:IndexPath, weatherData: WAWeatherDataObject)->UITableViewCell{
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1") as? WAIconTableViewCell {
                cell.parameterLabel.text = CITY
                cell.conditionsLabel.text = weatherData.cityName
                if let name = weatherData.icons.last {
                    WAWebServiceManager.shared.fetchImageIcon(sourceVC: sourceVC, imageName: name, completionHandler: { (image) in
                        DispatchQueue.main.async {
                            cell.iconImageView?.image = image
                        }
                    })
                }
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2") as? WADefaultTableViewCell {
                cell.parameterLabel.text = TEMPERATURE
                cell.conditionsLabel.text = weatherData.temp.toString() + " deg F"
                return cell
            }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2") as? WADefaultTableViewCell {
                cell.parameterLabel.text = WIND
                cell.conditionsLabel.text = weatherData.descr + " " + weatherData.windSpeed.toString() + " m/s ( \(weatherData.windDirection.toString()) deg)"
                return cell
            }
        case 3:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2") as? WADefaultTableViewCell {
                cell.parameterLabel.text = HUMIDITY
                cell.conditionsLabel.text = weatherData.humidity.toString() + " %"
                return cell
            }
        case 4:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2") as? WADefaultTableViewCell {
                cell.parameterLabel.text = PRESSURE
                cell.conditionsLabel.text = weatherData.pressure.toString() + " hpa"
                return cell
            }
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2") as? WADefaultTableViewCell {
                return cell
            }
        }
        return UITableViewCell()
    }
}
