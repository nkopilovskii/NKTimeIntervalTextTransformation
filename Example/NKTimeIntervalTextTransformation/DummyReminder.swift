//
//  DummyReminder.swift
//  NKTimeIntervalTextTransformation_Example
//
//  Created by Nick Kopilovskii on 27.08.2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import NKTimeIntervalTextTransformation

class DummyReminder: UITableViewController {
  
  var dates = [Date]()
  var dateFormatter = DateFormatter()
  var timeIntervalConfiguration = NKTextTimeIntervalConfiguration.defaultEnglish()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    dateFormatter.dateFormat = "dd MMMM yyyy HH:mm:ss"
    title = "Start time: \(dateFormatter.string(from: Date()))"
    
    //Creating array of dates when event must happen
    //First date based on current time
    dates.append(Date())
    (1...19).forEach {
      //Each date based on previous and it greater than previous
      dates.append(dates[$0-1].addingTimeInterval(TimeInterval(pow(5.0, Double($0)) + 1.0)))
    }

    //Customizing zeroTimeIntervalPlaceholder
    timeIntervalConfiguration.zeroTimeIntervalPlaceholder = "at the same time"
    //Customizing declension rule for minute time component
    timeIntervalConfiguration.minutes = {
      return $0 == 1 ? ("a minute", false) : ("a few minutes", false)
    }
    
    //Ignoring declension rule for month time component (NKTimeIntervalTextTransformation will use previous declension rule = timeIntervalConfiguration.weeks)
    timeIntervalConfiguration.months = nil
    
    
    tableView.register(UINib(nibName: "DummyCell", bundle: nil), forCellReuseIdentifier: DummyCell.identifier)
    tableView.reloadData()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 15
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 77
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: DummyCell = tableView.dequeueReusableCell(withIdentifier: DummyCell.identifier) as? DummyCell ?? DummyCell(style: .default, reuseIdentifier: DummyCell.identifier)
    
    //Calculated time interval is static value: every time it is calculated value will be the same, because it based on Start time
    if cell.lblTime != nil { cell.lblTime.text = dates[0].timeInterval(to: dates[indexPath.row], with: timeIntervalConfiguration) }
    if cell.lblMessage != nil { cell.lblMessage.text = "This event will happen on \(dateFormatter.string(from: dates[indexPath.row])). Label in the top right corner says how long it will take after the Start time - \(dateFormatter.string(from: Date()))." }
    
    return cell
  }
}
