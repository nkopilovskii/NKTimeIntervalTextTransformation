//
//  NKTextTimeIntervalConfiguration.swift
//
//  Created by Nick Kopilovskii on 22.08.2018.
//  Copyright © 2018 Nick Kopilovskii. All rights reserved.
//


import Foundation


//MARK: - NKTextTimeIntervalConfiguration interface
/**
 Struct **NKTextTimeIntervalConfiguration** describes rules for declining names of components, depending on their numerical value, format of output of time interval; converts a period of time into a string format
 */
public struct NKTextTimeIntervalConfiguration {
  /**
   Return string value if the compared dates are equal
   
   default: "" (empty string)
   */
  public var zeroTimeIntervalPlaceholder = ""
  
  
  /*
   Output formats is similar to dateFormat of DateFormatter.dateFormat: the corresponding key value is set to the corresponding value
   
   As example if set `pastFormat = "\(NKTextTimeIntervalConfiguration.numberValueKey) \(NKTextTimeIntervalConfiguration.timeComponentValueKey) ago"` in result will be something like "12 seconds ago"

   */
  
  /**
   Key for specifying location of numerical value of time component in string representation of time interval
   */
  public static let numberValueKey = "<VALUE>"
  
  /**
   Key for specifying location of numerical value of time component in string representation of time interval
   */
  public static let timeComponentValueKey = "<TIME_COMPONENT>"
  
  /**
   Time intreval output format as string for positive value
   
   If `date1.compare(date2) == .OrderedDescending` => `date1.timeIntervalSince(date2) > 0`
   
   default: "\(NKTextTimeIntervalConfiguration.numberValueKey)"
   */
  public var pastFormat = ""
  
  /**
   Time intreval output format as string for negative value
   
   If `date1.compare(date2) == .OrderedAscending` => `date1.timeIntervalSince(date2) < 0`
   
   default: "\(NKTextTimeIntervalConfiguration.numberValueKey)"
   */
  public var futureFormat = ""
  
  /*
   Declension Rules for time components
   */
  public var components = Set<NKDateComponent>()
  
  /**
   Base Init method
   */
  public init() {}

  
  /**
   Method creats time interval string representation based on input rule and time component count
   
   If `value` is equal zero returns `zeroTimeIntervalPlaceholder`
   
   If `value > 0` will be used `futureFormat`, else - `pastFormat`
   
   If `rule` is equal zero returns `nil`

   - parameters:
   
      - rule:
Declension rule
   
      - value:
Time component count (Double used if it needs to make representation for floating point value)
   
   - returns: Optional String
   */
  public func formatedString(for rule: NKTimeComponentDeclensionRule?, with value: Int) -> String? {
    guard let declensionRule = rule else { return nil }
    guard let (timeComponentStringValue, shouldWriteNumbers) = declensionRule(TimeInterval(abs(value))) else { return nil }
    
    var formatter = value < 0 ? pastFormat : futureFormat
    
    formatter = formatter.replacingOccurrences(of: NKTextTimeIntervalConfiguration.timeComponentValueKey, with: timeComponentStringValue)
    formatter = formatter.replacingOccurrences(of: NKTextTimeIntervalConfiguration.numberValueKey, with: shouldWriteNumbers ? String(abs(value)) : "")
    formatter = formatter.replacingOccurrences(of: "  ", with: " ")
    if formatter.first == " " { formatter.removeFirst() }
    
    return formatter
  }
}
