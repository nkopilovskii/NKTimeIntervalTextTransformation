//
//  NKTextTimeIntervalConfiguration+DefaultValues.swift
//
//  Created by Nick Kopilovskii on 30.08.2018.
//

import Foundation

//MARK: - NKTextTimeIntervalConfiguration default configurations
/**
 This extension contains static methods that generate configurations based on rules for declining the numerals of some languages
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
    
    config.components.insert(NKDateComponent.centuries({
      if Int($0) == 0 { return nil }
      return abs($0) == 1 ? ("a century", false)   : ("centuries", true)
    }))
    config.components.insert(NKDateComponent.years({
      if Int($0) == 0 { return nil }
      return abs($0) == 1 ? ("a year", false)   : ("years", true)
    }))
    config.components.insert(NKDateComponent.months({
      if Int($0) == 0 { return nil }
      return abs($0) == 1 ? ("a month", false)  : ("months", true)
    }))
    config.components.insert(NKDateComponent.weeks({
      if Int($0) == 0 { return nil }
      return abs($0) == 1 ? ("a week", false)   : ("weeks", true)
    }))
    config.components.insert(NKDateComponent.days({
      if Int($0) == 0 { return nil }
      return abs($0) == 1 ? ("a day", false)    : ("days", true)
    }))
    config.components.insert(NKDateComponent.hours({
      if Int($0) == 0 { return nil }
      return abs($0) == 1 ? ("an hour", false)   : ("hours", true)
    }))
    config.components.insert(NKDateComponent.minutes({
      if Int($0) == 0 { return nil }
      return abs($0) == 1 ? ("a minute", false) : ("minutes", true)
    }))
    config.components.insert(NKDateComponent.seconds({
      if Int($0) == 0 { return nil }
      return abs($0) == 1 ? ("a second", false) : ("seconds", true)
    }))
    
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
      if ( (Int($0) % 10 == 2 && Int($0) % 100 != 12) || (Int($0) % 10 == 3 && Int($0) % 100 != 13) || (Int($0) % 10 == 4 && Int($0) % 100 != 14) ) { return true }
      return false
    }
    
    config.components.insert(NKDateComponent.centuries({
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) { return ("век", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) { return ("века", true) }
      return ("веков", true)
    }))
    config.components.insert(NKDateComponent.years({
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) { return ("год", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) { return ("года", true) }
      return ("лет", true)
    }))
    config.components.insert(NKDateComponent.months({
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) { return ("месяц", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) { return ("месяца", true) }
      return ("месяцев", true)
    }))
    config.components.insert(NKDateComponent.weeks({
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) { return ("неделю", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) { return ("недели", true) }
      return ("недель", true)
    }))
    config.components.insert(NKDateComponent.days({
      if Int($0) == 0 { return nil }
      if ruleLastOne($0)  { return ("день", true) }
      if ruleLastTwoThreeFour($0) { return ("дня", true) }
      return ("дней", true)
    }))
    config.components.insert(NKDateComponent.hours({
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) { return ("час", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) { return ("часа", true) }
      return ("часов", true)
    }))
    config.components.insert(NKDateComponent.minutes({
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) { return ("минуту", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) { return ("минуты", true) }
      return ("минут", true)
    }))
    config.components.insert(NKDateComponent.seconds({
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) { return ("секунду", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) { return ("секунды", true) }
      return ("секунд", true)
    }))
    
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
      if ( (Int($0) % 10 == 2 && Int($0) % 100 != 12) || (Int($0) % 10 == 3 && Int($0) % 100 != 13) || (Int($0) % 10 == 4 && Int($0) % 100 != 14) ) { return true }
      return false
    }
    
    config.components.insert(NKDateComponent.seconds({
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) { return ("секунду", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) { return ("секунди", true) }
      return ("секунд", true)
    }))
    
    config.components.insert(NKDateComponent.minutes({
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) { return ("хвилину", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) { return ("хвилини", true) }
      return ("хвилин", true)
    }))
    
    config.components.insert(NKDateComponent.hours({
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) { return ("годину", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) { return ("години", true) }
      return ("годин", true)
    }))
    
    config.components.insert(NKDateComponent.days({
      if Int($0) == 0 { return nil }
      if ruleLastOne($0)  { return ("день", true) }
      if ruleLastTwoThreeFour($0) { return ("дні", true) }
      return ("днів", true)
    }))
    
    config.components.insert(NKDateComponent.weeks({
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) { return ("тиждень", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) { return ("тижні", true) }
      return ("тижнів", true)
    }))
    
    config.components.insert(NKDateComponent.months({
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) { return ("місяць", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) { return ("місяці", true) }
      return ("місяців", true)
    }))
    
    config.components.insert(NKDateComponent.years({
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) { return ("рік", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) { return ("роки", true) }
      return ("років", true)
    }))
    
    config.components.insert(NKDateComponent.centuries({
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) { return ("століття", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) { return ("століття", true) }
      return ("століть", true)
    }))
    
    return config
  }
  
}
