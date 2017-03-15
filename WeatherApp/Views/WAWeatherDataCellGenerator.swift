//
//  WAWeatherDataCellGenerator.swift
//  WeatherApp
//
//  Created by Mahesh Thakre on 3/14/17.
//  Copyright © 2017 Mahesh Thakre. All rights reserved.
//

import UIKit

class WAWeatherDataCellGenerator {

    static let shared = WAWeatherDataCellGenerator()
    
    func getCell(tableView: UITableView, indexPath:IndexPath, weatherData: WAWeatherDataObject)->UITableViewCell{
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1") as? WAIconTableViewCell {
                cell.parameterLabel.text = CITY
                cell.conditionsLabel.text = weatherData.cityName
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2") as? WADefaultTableViewCell {
                return cell
            }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2") as? WADefaultTableViewCell {
                return cell
            }
        case 3:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2") as? WADefaultTableViewCell {
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
