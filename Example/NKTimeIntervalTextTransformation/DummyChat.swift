//
//  DummyChat.swift
//  NKTimeIntervalTextTransformation_Example
//
//  Created by Nick Kopilovskii on 27.08.2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import NKTimeIntervalTextTransformation

class DummyChat: UITableViewController {
  
  var dates = [Date]()
  var dateFormatter = DateFormatter()
  var timeIntervalConfiguration = NKTextTimeIntervalConfiguration.defaultEnglish()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    dateFormatter.dateFormat = "dd MMMM yyyy HH:mm:ss"
    title = "Dummy Chat"
    
    
    //Creating array of dates when messages created
    //First date based on current time
    dates.append(Date())
    (1...15).forEach {
      //Each date based on previous and it less than previous
      dates.append(dates[$0-1].addingTimeInterval(TimeInterval(-(pow(5.0, Double($0)) + 1.0))))
    }
    
    tableView.register(UINib(nibName: DummyCell.identifier, bundle: nil), forCellReuseIdentifier: DummyCell.identifier)
    tableView.reloadData()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 15 }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 77 }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: DummyCell.identifier) as! DummyCell
    
    //Calculated time interval is dynamic value: every time it is calculated value will be changed, because it based on current system Date&Time
    cell.lblTime.text = Date.timeIntervalFromNow(to: dates[indexPath.row], with: timeIntervalConfiguration)
    cell.lblMessage.text = "This message was written on \(dateFormatter.string(from: dates[indexPath.row])). Label in the top right corner says how much time has passed since now."
    
    return cell
  }
  
}
