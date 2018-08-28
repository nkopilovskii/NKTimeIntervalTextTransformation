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
  This extension contains static methods that generate configurations based on rules for declining the numerals of English and Russian
 */
public extension NKTextTimeIntervalConfiguration {
  
  /**
   Public static method generate default configuration based on rules for declining the numerals of English
   */
  public static func defaultEnglish() -> NKTextTimeIntervalConfiguration  {
    var config = NKTextTimeIntervalConfiguration()
    
    config.pastFormat = "\(NKTextTimeIntervalConfiguration.numberValueKey) \(NKTextTimeIntervalConfiguration.timeComponentValueKey) ago"
    config.zeroTimeIntervalPlaceholder = "now"
    config.futureFormat = "in \(NKTextTimeIntervalConfiguration.numberValueKey) \(NKTextTimeIntervalConfiguration.timeComponentValueKey)"
    
    config.seconds = {
      if Int($0) == 0 { return nil }
      return abs($0) == 1 ? ("a second", false) : ("seconds", true)
    }
    config.minutes = {
      if Int($0) == 0 { return nil }
      return abs($0) == 1 ? ("a minute", false) : ("minutes", true)
    }
    config.hours = {
      if Int($0) == 0 { return nil }
      return abs($0) == 1 ? ("an hour", false)   : ("hours", true)
    }
    config.days = {
      if Int($0) == 0 { return nil }
      return abs($0) == 1 ? ("a day", false)    : ("days", true)
    }
    config.weeks = {
      if Int($0) == 0 { return nil }
      return abs($0) == 1 ? ("a week", false)   : ("weeks", true)
    }
    config.months = {
      if Int($0) == 0 { return nil }
      return abs($0) == 1 ? ("a month", false)  : ("months", true)
    }
    config.years = {
      if Int($0) == 0 { return nil }
      return abs($0) == 1 ? ("a year", false)   : ("years", true)
    }
    config.centuries  = {
      if Int($0) == 0 { return nil }
      return abs($0) == 1 ? ("a century", false)   : ("centuries", true)
    }
    
    return config
  }
  
  /**
   Public static method generate default configuration based on rules for declining the numerals of Russian
   */
  public static func defaultRussian() -> NKTextTimeIntervalConfiguration  {
    var config = NKTextTimeIntervalConfiguration()
    
    config.pastFormat = "\(NKTextTimeIntervalConfiguration.numberValueKey) \(NKTextTimeIntervalConfiguration.timeComponentValueKey) назад"
    config.zeroTimeIntervalPlaceholder = "сейчас"
    config.futureFormat = "через \(NKTextTimeIntervalConfiguration.numberValueKey) \(NKTextTimeIntervalConfiguration.timeComponentValueKey)"

    let ruleLastOne: (Double) -> Bool = { return Int($0) % 10 == 1 && Int($0) % 100 != 11 }
    let ruleLastTwoThreeFour: (Double) -> Bool = {
      if ( (Int($0) % 10 == 2 && Int($0) % 100 != 12) || (Int($0) % 10 == 3 && Int($0) % 100 != 13) || (Int($0) % 10 == 4 && Int($0) % 100 != 14) ) == true { return true }
      return false
    }
      
    config.seconds = {
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) == true { return ("секунду", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) == true { return ("секунды", true) }
      return ("секунд", true)
    }
    
    config.minutes = {
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) == true { return ("минуту", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) == true { return ("минуты", true) }
      return ("минут", true)
    }
    
    config.hours = {
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) == true { return ("час", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) == true { return ("часа", true) }
      return ("часов", true)
    }
    
    config.days = {
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) == true  { return ("день", true) }
      if ruleLastTwoThreeFour($0) == true { return ("дня", true) }
      return ("дней", true)
    }
    
    config.weeks = {
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) == true { return ("неделю", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) == true { return ("недели", true) }
      return ("недель", true)
    }
    
    config.months = {
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) == true { return ("месяц", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) == true { return ("месяца", true) }
      return ("месяцев", true)
    }
    
    config.years = {
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) == true { return ("год", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) == true { return ("года", true) }
      return ("лет", true)
    }
    
    config.centuries  = {
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) == true { return ("век", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) == true { return ("века", true) }
      return ("веков", true)
    }
    
    return config
  }
  
  /**
   Public static method generate default configuration based on rules for declining the numerals of Ukrainian
   */
  public static func defaultUkrainian() -> NKTextTimeIntervalConfiguration  {
    var config = NKTextTimeIntervalConfiguration()
    
    config.pastFormat = "\(NKTextTimeIntervalConfiguration.numberValueKey) \(NKTextTimeIntervalConfiguration.timeComponentValueKey) тому"
    config.zeroTimeIntervalPlaceholder = "зараз"
    config.futureFormat = "через \(NKTextTimeIntervalConfiguration.numberValueKey) \(NKTextTimeIntervalConfiguration.timeComponentValueKey)"
    
    let ruleLastOne: (Double) -> Bool = { return Int($0) % 10 == 1 && Int($0) % 100 != 11 }
    let ruleLastTwoThreeFour: (Double) -> Bool = {
      if ( (Int($0) % 10 == 2 && Int($0) % 100 != 12) || (Int($0) % 10 == 3 && Int($0) % 100 != 13) || (Int($0) % 10 == 4 && Int($0) % 100 != 14) ) == true { return true }
      return false
    }
    
    config.seconds = {
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) == true { return ("секунду", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) == true { return ("секунди", true) }
      return ("секунд", true)
    }
    
    config.minutes = {
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) == true { return ("хвилину", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) == true { return ("хвилини", true) }
      return ("хвилин", true)
    }
    
    config.hours = {
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) == true { return ("годину", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) == true { return ("години", true) }
      return ("годин", true)
    }
    
    config.days = {
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) == true  { return ("день", true) }
      if ruleLastTwoThreeFour($0) == true { return ("дні", true) }
      return ("днів", true)
    }
    
    config.weeks = {
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) == true { return ("тиждень", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) == true { return ("тижні", true) }
      return ("тижнів", true)
    }
    
    config.months = {
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) == true { return ("місяць", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) == true { return ("місяці", true) }
      return ("місяців", true)
    }
    
    config.years = {
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) == true { return ("рік", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) == true { return ("роки", true) }
      return ("років", true)
    }
    
    config.centuries  = {
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) == true { return ("століття", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) == true { return ("століття", true) }
      return ("століть", true)
    }
    
    return config
  }
  
}
