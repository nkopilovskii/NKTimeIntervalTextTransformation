//
//  DummyTimeIntervalChain.swift
//  NKTimeIntervalTextTransformation_Example
//
//  Created by Nick Kopilovskii on 30.08.2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import NKTimeIntervalTextTransformation

class DummyTimeIntervalChain: UITableViewController {
  
  var dates = [Date]()
  var dateFormatter = DateFormatter()
  var timeIntervalConfiguration = NKTextTimeIntervalConfiguration.defaultEnglish()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    dateFormatter.dateFormat = "dd MMMM yyyy HH:mm:ss"
    title = "Dummy Time Interval Chain"
    
    
    timeIntervalConfiguration.zeroTimeIntervalPlaceholder = "START"
    timeIntervalConfiguration.pastFormat = "was \(NKTextTimeIntervalConfiguration.numberValueKey) \(NKTextTimeIntervalConfiguration.timeComponentValueKey) before previous"
    timeIntervalConfiguration.futureFormat = "will be \(NKTextTimeIntervalConfiguration.numberValueKey) \(NKTextTimeIntervalConfiguration.timeComponentValueKey) after previous"
    
    //Creating array of dates when messages created
    //First date based on current time
    dates.append(Date())
    (1...19).forEach {
      //Each date based on previous and it less than previous
      dates.append(dates[$0-1].addingTimeInterval(TimeInterval(pow(-1, Double($0))*(pow(5.0, Double($0)) + 1.0))))
    }
    
    tableView.register(UINib(nibName: "DummyCell", bundle: nil), forCellReuseIdentifier: DummyCell.identifier)
    tableView.reloadData()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 15 }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 77 }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: DummyCell = tableView.dequeueReusableCell(withIdentifier: DummyCell.identifier) as? DummyCell ?? DummyCell(style: .default, reuseIdentifier: DummyCell.identifier)
    
    ///Calculated time interval is static value: every time it is calculated value will be the same, because it based on Start time

    let previousDate = indexPath.row == 0 ?  Date() : dates[indexPath.row - 1]
    let timeInterval = dates[indexPath.row].timeIntervalSince(previousDate)
    if cell.lblTime != nil { cell.lblTime.text = timeInterval.stringRepresentation(by: timeIntervalConfiguration)
//      Date.timeIntervalFromNow(to: dates[indexPath.row], with: timeIntervalConfiguration)
    }
    
    if cell.lblMessage != nil {
      cell.lblMessage.text = "This message was written on \(dateFormatter.string(from: dates[indexPath.row])). Label in the top right corner says how much time has passed (or will pass) since previous message."
    }
    
    
    return cell
  }
  
 
  
}
