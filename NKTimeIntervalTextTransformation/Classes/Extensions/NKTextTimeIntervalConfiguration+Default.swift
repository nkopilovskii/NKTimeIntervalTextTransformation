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
//  NKTimeIntervalTextTransformation
//
//  Created by Nick Kopilovskii on 7/15/19.
//

import Foundation

extension NKTextTimeIntervalConfiguration {
  
  mutating func setupDefaultEnglish() {
    pastFormat = "\(NKTextTimeIntervalConfiguration.numberValueKey) \(NKTextTimeIntervalConfiguration.timeComponentValueKey) ago"
    zeroTimeIntervalPlaceholder = "now"
    futureFormat = "in \(NKTextTimeIntervalConfiguration.numberValueKey) \(NKTextTimeIntervalConfiguration.timeComponentValueKey)"
    
    seconds = {
      if Int($0) == 0 { return nil }
      return abs($0) == 1 ? ("a second", false) : ("seconds", true)
    }
    minutes = {
      if Int($0) == 0 { return nil }
      return abs($0) == 1 ? ("a minute", false) : ("minutes", true)
    }
    hours = {
      if Int($0) == 0 { return nil }
      return abs($0) == 1 ? ("an hour", false)   : ("hours", true)
    }
    days = {
      if Int($0) == 0 { return nil }
      return abs($0) == 1 ? ("a day", false)    : ("days", true)
    }
    weeks = {
      if Int($0) == 0 { return nil }
      return abs($0) == 1 ? ("a week", false)   : ("weeks", true)
    }
    months = {
      if Int($0) == 0 { return nil }
      return abs($0) == 1 ? ("a month", false)  : ("months", true)
    }
    years = {
      if Int($0) == 0 { return nil }
      return abs($0) == 1 ? ("a year", false)   : ("years", true)
    }
    centuries  = {
      if Int($0) == 0 { return nil }
      return abs($0) == 1 ? ("a century", false)   : ("centuries", true)
    }
  }
  
  mutating func setupDefaultRussian() {
    pastFormat = "\(NKTextTimeIntervalConfiguration.numberValueKey) \(NKTextTimeIntervalConfiguration.timeComponentValueKey) назад"
    zeroTimeIntervalPlaceholder = "сейчас"
    futureFormat = "через \(NKTextTimeIntervalConfiguration.numberValueKey) \(NKTextTimeIntervalConfiguration.timeComponentValueKey)"
    
    let ruleLastOne: (Double) -> Bool = { return Int($0) % 10 == 1 && Int($0) % 100 != 11 }
    let ruleLastTwoThreeFour: (Double) -> Bool = {
      if ( (Int($0) % 10 == 2 && Int($0) % 100 != 12) || (Int($0) % 10 == 3 && Int($0) % 100 != 13) || (Int($0) % 10 == 4 && Int($0) % 100 != 14) ) == true { return true }
      return false
    }
    
    seconds = {
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) == true { return ("секунду", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) == true { return ("секунды", true) }
      return ("секунд", true)
    }
    
    minutes = {
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) == true { return ("минуту", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) == true { return ("минуты", true) }
      return ("минут", true)
    }
    
    hours = {
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) == true { return ("час", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) == true { return ("часа", true) }
      return ("часов", true)
    }
    
    days = {
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) == true  { return ("день", true) }
      if ruleLastTwoThreeFour($0) == true { return ("дня", true) }
      return ("дней", true)
    }
    
    weeks = {
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) == true { return ("неделю", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) == true { return ("недели", true) }
      return ("недель", true)
    }
    
    months = {
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) == true { return ("месяц", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) == true { return ("месяца", true) }
      return ("месяцев", true)
    }
    
    years = {
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) == true { return ("год", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) == true { return ("года", true) }
      return ("лет", true)
    }
    
    centuries  = {
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) == true { return ("век", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) == true { return ("века", true) }
      return ("веков", true)
    }
  }
  
  mutating func setupDefaultUkrainian() {
    pastFormat = "\(NKTextTimeIntervalConfiguration.numberValueKey) \(NKTextTimeIntervalConfiguration.timeComponentValueKey) тому"
    zeroTimeIntervalPlaceholder = "зараз"
    futureFormat = "через \(NKTextTimeIntervalConfiguration.numberValueKey) \(NKTextTimeIntervalConfiguration.timeComponentValueKey)"
    
    let ruleLastOne: (Double) -> Bool = { return Int($0) % 10 == 1 && Int($0) % 100 != 11 }
    let ruleLastTwoThreeFour: (Double) -> Bool = {
      if ( (Int($0) % 10 == 2 && Int($0) % 100 != 12) || (Int($0) % 10 == 3 && Int($0) % 100 != 13) || (Int($0) % 10 == 4 && Int($0) % 100 != 14) ) == true { return true }
      return false
    }
    
    seconds = {
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) == true { return ("секунду", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) == true { return ("секунди", true) }
      return ("секунд", true)
    }
    
    minutes = {
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) == true { return ("хвилину", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) == true { return ("хвилини", true) }
      return ("хвилин", true)
    }
    
    hours = {
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) == true { return ("годину", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) == true { return ("години", true) }
      return ("годин", true)
    }
    
    days = {
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) == true  { return ("день", true) }
      if ruleLastTwoThreeFour($0) == true { return ("дні", true) }
      return ("днів", true)
    }
    
    weeks = {
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) == true { return ("тиждень", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) == true { return ("тижні", true) }
      return ("тижнів", true)
    }
    
    months = {
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) == true { return ("місяць", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) == true { return ("місяці", true) }
      return ("місяців", true)
    }
    
    years = {
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) == true { return ("рік", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) == true { return ("роки", true) }
      return ("років", true)
    }
    
    centuries  = {
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) == true { return ("століття", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) == true { return ("століття", true) }
      return ("століть", true)
    }
  }
}
