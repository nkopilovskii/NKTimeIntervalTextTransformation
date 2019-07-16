//
//  NKTimeInterval+NKTimeIntervalDateComponents.swift
//
//  Created by Nick Kopilovskii on 22.08.2018.
//  Copyright © 2018 Nick Kopilovskii. All rights reserved.
//

import Foundation

public protocol NKTimeIntervalDateComponents {
  
  var nkSeconds:    Int { get }
  var nkMinutes:    Int { get }
  var nkHours:      Int { get }
  var nkDays:       Int { get }
  var nkWeeks:      Int { get }
  var nkMonths:     Int { get }
  var nkYears:      Int { get }
  var nkCenturies:  Int { get }
  
  
  /**
   Method calculating count of maximum available time component in input time interval and returns it's string representation based on Declension Rules
   
   Count of maximum available time components calculates in in extension of the class TimeInterval wich implements NKTimeIntervalDateComponents protocol
   
   If `interval` equal zero method returns `zeroTimeIntervalPlaceholder`
   
   If some declension rule isn't setted method use previous rule
   
   If there is no declension rules from maximum available time component to minimum (seconds) method returns nil
   
   - parameters:
   
   - interval:
   Seconds beetween two dates
   
   - returns: Optional String
   */
  func stringRepresentation(by config: NKTextTimeIntervalConfiguration) -> String?
  
}

extension TimeInterval: NKTimeIntervalDateComponents {
  
  public var nkSeconds:    Int { return Int(self) }
  public var nkMinutes:    Int { return Int(self / 60) }
  public var nkHours:      Int { return Int(self / 3600) }
  public var nkDays:       Int { return Int(self / (3600 * 24)) }
  public var nkWeeks:      Int { return Int(self / (3600 * 24 * 7)) }
  public var nkMonths:     Int { return Int(self / (3600 * 24 * 7 * 4)) }
  public var nkYears:      Int { return Int(self / (3600 * 24 * 365)) }
  public var nkCenturies:  Int { return Int(self / (3600 * 24 * 365 * 100)) }
  
  
  public func stringRepresentation(by config: NKTextTimeIntervalConfiguration) -> String? {
    
    
    let greatestRule = config.components.sorted(by: {$0 < $1}).first(where: {self.value(for: $0) != 0})
    
    
    guard let rule = greatestRule else {
      return config.components.count > 0 ? config.zeroTimeIntervalPlaceholder : nil
    }
    
    return config.formatedString(for: rule.rule, with: value(for: rule)) ?? config.zeroTimeIntervalPlaceholder
  }
  
  func value(for component: NKDateComponent) -> Int {
    switch component {
    case .centuries: return nkCenturies
    case .years:     return nkYears
    case .months:    return nkMonths
    case .weeks:     return nkWeeks
    case .days:      return nkDays
    case .hours:     return nkHours
    case .minutes:   return nkMinutes
    case .seconds:   return nkSeconds
    }
  }
  
}
