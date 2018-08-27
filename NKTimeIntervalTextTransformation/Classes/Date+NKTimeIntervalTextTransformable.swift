//
//  Date+NKTimeIntervalTextTransformable.swift
//
//  Created by Nick Kopilovskii on 22.08.2018.
//  Copyright © 2018 Nick Kopilovskii. All rights reserved.
//

import Foundation

/**
 Protocol declares methods for obtaining a time interval in a string representation using NKTextTimeIntervalConfiguration
 */
public protocol NKTimeIntervalTextTransformable {
  
  static func timeIntervalFromNow(to date: Date, with config: NKTextTimeIntervalConfiguration) -> String?
  
  func timeInterval(to date: Date, with config: NKTextTimeIntervalConfiguration) -> String?
  
}

/**
 Implementation of NKTimeIntervalTextTransformable protocol in extension of the class Date
 */
extension Date: NKTimeIntervalTextTransformable {
  
  public static func timeIntervalFromNow(to date: Date, with config: NKTextTimeIntervalConfiguration) -> String? {
    return Date().timeInterval(to: date, with: config)
  }
  
  public func timeInterval(to date: Date, with config: NKTextTimeIntervalConfiguration) -> String? {
    return config.stringRepresentation(for: timeIntervalSince(date))
  }
  
}


