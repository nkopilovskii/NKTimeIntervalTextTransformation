//
//Copyright (c) 2018 nkopilovskii <nikolay.k@powercode.us>
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.
//
//  NKTextTimeIntervalConfiguration.swift
//
//  Created by Nick Kopilovskii on 22.08.2018.
//  Copyright © 2018 Nick Kopilovskii. All rights reserved.
//


import Foundation

//MARK: - NKTimeComponentDeclensionRule
/**
 Closure describes declension rule for numerals depending on needs of application or language
 
 **Example:**

      { timeComponents -> (String, Bool) in
        if <condition>
          { return (<time_component_name>,
                    <needs_display_numerical_value>) }
        else
          { return (<time_component_name>,
                    <needs_display_numerical_value>) }
      }
 
 
 - parameters:
 
  - Double:
integer part represents the number of complete time components in the considered time interval
 
 - returns:
`(String, Bool)`, where `String` value is name of time component the required declination, `Bool` value sets need to display numerical value of time component in specified string format of time interval
*/
public typealias NKTimeComponentDeclensionRule = (Double) -> (String, Bool)?







//MARK: - NKTextTimeIntervalConfiguration interface
/**
 Struct **NKTextTimeIntervalConfiguration** describes rules for declining names of components, depending on their numerical value, format of output of time interval; converts a period of time into a string format
 */
public struct NKTextTimeIntervalConfiguration {
  /**
   Return string value if the compared dates are equal
   
   default: "" (empty string)
   */
  public var zeroTimeIntervalPlaceholder: String
  
  
  /*
   Output formats is similar to dateFormat of DateFormatter class: the corresponding key value is set to the corresponding value
   
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
  public var pastFormat: String
  
  /**
   Time intreval output format as string for negative value
   
   If `date1.compare(date2) == .OrderedAscending` => `date1.timeIntervalSince(date2) < 0`
   
   default: "\(NKTextTimeIntervalConfiguration.numberValueKey)"
   */
  public var futureFormat: String
  
  
  /*
   Declension Rules for each time component
   */
  ///Declension Rule for seconds
  public var seconds:   NKTimeComponentDeclensionRule?
  ///Declension Rule for minutes
  public var minutes:   NKTimeComponentDeclensionRule?
  ///Declension Rule for hours
  public var hours:     NKTimeComponentDeclensionRule?
  ///Declension Rule for days
  public var days:      NKTimeComponentDeclensionRule?
  ///Declension Rule for weeks
  public var weeks:     NKTimeComponentDeclensionRule?
  ///Declension Rule for months
  public var months:    NKTimeComponentDeclensionRule?
  ///Declension Rule for years
  public var years:     NKTimeComponentDeclensionRule?
  ///Declension Rule for centuries
  public var centuries: NKTimeComponentDeclensionRule?
  
  /**
   Base Init method
   */
  public init() {
    pastFormat = "\(NKTextTimeIntervalConfiguration.numberValueKey)"
    futureFormat = "\(NKTextTimeIntervalConfiguration.numberValueKey)"
    zeroTimeIntervalPlaceholder = ""
  }
  
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
  public func stringRepresentation(for interval: TimeInterval) -> String? {
    guard Int(interval) != 0 else { return zeroTimeIntervalPlaceholder }
    
    if let rule = centuries, let str = formatedString(for: rule, with: interval.centuries)    { return str }
    if let rule = years,     let str = formatedString(for: rule, with: interval.years)        { return str }
    if let rule = months,    let str = formatedString(for: rule, with: interval.months)       { return str }
    if let rule = weeks,     let str = formatedString(for: rule, with: interval.weeks)        { return str }
    if let rule = days,      let str = formatedString(for: rule, with: interval.days)         { return str }
    if let rule = hours,     let str = formatedString(for: rule, with: interval.hours)        { return str }
    if let rule = minutes,   let str = formatedString(for: rule, with: interval.minutes)      { return str }
    if let rule = seconds,   let str = formatedString(for: rule, with: interval.seconds)      { return str }
    
    return nil
  }
  
  /**
   Method creats time interval string representation based on input rule and time component count
   
   If `value` is equal zero returns `zeroTimeIntervalPlaceholder`
   
   If `value > 0` will be used `pastFormat`, else - `futureFormat`
   
   If `rule` is equal zero returns `nil`

   - parameters:
   
      - rule:
Declension rule
   
      - value:
Time component count (Double used if it needs to make representation for floating point value)
   
   - returns: Optional String
   */
  public func formatedString(for rule: NKTimeComponentDeclensionRule?, with value: Double) -> String? {
    guard let declensionRule = rule else { return nil }
    guard let (timeComponentStringValue, shouldWriteNumbers) = declensionRule(TimeInterval(abs(value))) else { return nil }
    
    var formatter = (value > 0 ? pastFormat : futureFormat)
    
    formatter = formatter.replacingOccurrences(of: NKTextTimeIntervalConfiguration.timeComponentValueKey, with: timeComponentStringValue)
    formatter = formatter.replacingOccurrences(of: NKTextTimeIntervalConfiguration.numberValueKey, with: shouldWriteNumbers ? String(abs(Int(value))) : "")
    formatter = formatter.replacingOccurrences(of: "  ", with: " ")
    
    if formatter.first == " " { formatter.removeFirst() }
    return formatter
  }
}


//MARK: - NKTextTimeIntervalConfiguration default configurations
/**
  This extension contains static methods that generate configurations based on rules for declining the numerals of some languages
 */
public extension NKTextTimeIntervalConfiguration {
  
  /**
   Public static method generate default configuration based on rules for declining the numerals of English
   */
  static func defaultEnglish() -> NKTextTimeIntervalConfiguration  {
    var config = NKTextTimeIntervalConfiguration()
    
    config.setupDefaultEnglish()
    
    return config
  }
  
  /**
   Public static method generate default configuration based on rules for declining the numerals of Russian
   */
  static func defaultRussian() -> NKTextTimeIntervalConfiguration  {
    var config = NKTextTimeIntervalConfiguration()
    
   config.setupDefaultRussian()
    
    return config
  }
  
  /**
   Public static method generate default configuration based on rules for declining the numerals of Ukrainian
   */
  static func defaultUkrainian() -> NKTextTimeIntervalConfiguration  {
    var config = NKTextTimeIntervalConfiguration()
    
    config.setupDefaultUkrainian()
    
    return config
  }
  
}
