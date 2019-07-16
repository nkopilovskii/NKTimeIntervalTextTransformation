//
//Copyright (c) 2019 nkopilovskii <nkopilovskii@gmail.com>
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
