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

  mutating func setupDefaultEnglish()  {

    
    pastFormat = "\(NKTextTimeIntervalConfiguration.numberValueKey) \(NKTextTimeIntervalConfiguration.timeComponentValueKey) ago"
    zeroTimeIntervalPlaceholder = "now"
    futureFormat = "in \(NKTextTimeIntervalConfiguration.numberValueKey) \(NKTextTimeIntervalConfiguration.timeComponentValueKey)"

    components.insert(NKDateComponent.centuries({
      if Int($0) == 0 { return nil }
      return abs($0) == 1 ? ("a century", false)   : ("centuries", true)
    }))
    components.insert(NKDateComponent.years({
      if Int($0) == 0 { return nil }
      return abs($0) == 1 ? ("a year", false)   : ("years", true)
    }))
    components.insert(NKDateComponent.months({
      if Int($0) == 0 { return nil }
      return abs($0) == 1 ? ("a month", false)  : ("months", true)
    }))
    components.insert(NKDateComponent.weeks({
      if Int($0) == 0 { return nil }
      return abs($0) == 1 ? ("a week", false)   : ("weeks", true)
    }))
    components.insert(NKDateComponent.days({
      if Int($0) == 0 { return nil }
      return abs($0) == 1 ? ("a day", false)    : ("days", true)
    }))
    components.insert(NKDateComponent.hours({
      if Int($0) == 0 { return nil }
      return abs($0) == 1 ? ("an hour", false)   : ("hours", true)
    }))
    components.insert(NKDateComponent.minutes({
      if Int($0) == 0 { return nil }
      return abs($0) == 1 ? ("a minute", false) : ("minutes", true)
    }))
    components.insert(NKDateComponent.seconds({
      if Int($0) == 0 { return nil }
      return abs($0) == 1 ? ("a second", false) : ("seconds", true)
    }))

  }

  mutating func setupDefaultRussian()  {

    pastFormat = "\(NKTextTimeIntervalConfiguration.numberValueKey) \(NKTextTimeIntervalConfiguration.timeComponentValueKey) назад"
    zeroTimeIntervalPlaceholder = "сейчас"
    futureFormat = "через \(NKTextTimeIntervalConfiguration.numberValueKey) \(NKTextTimeIntervalConfiguration.timeComponentValueKey)"

    let ruleLastOne: (Double) -> Bool = { return Int($0) % 10 == 1 && Int($0) % 100 != 11 }
    let ruleLastTwoThreeFour: (Double) -> Bool = {
      if ( (Int($0) % 10 == 2 && Int($0) % 100 != 12) || (Int($0) % 10 == 3 && Int($0) % 100 != 13) || (Int($0) % 10 == 4 && Int($0) % 100 != 14) ) { return true }
      return false
    }

    components.insert(NKDateComponent.centuries({
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) { return ("век", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) { return ("века", true) }
      return ("веков", true)
    }))
    components.insert(NKDateComponent.years({
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) { return ("год", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) { return ("года", true) }
      return ("лет", true)
    }))
    components.insert(NKDateComponent.months({
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) { return ("месяц", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) { return ("месяца", true) }
      return ("месяцев", true)
    }))
    components.insert(NKDateComponent.weeks({
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) { return ("неделю", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) { return ("недели", true) }
      return ("недель", true)
    }))
    components.insert(NKDateComponent.days({
      if Int($0) == 0 { return nil }
      if ruleLastOne($0)  { return ("день", true) }
      if ruleLastTwoThreeFour($0) { return ("дня", true) }
      return ("дней", true)
    }))
    components.insert(NKDateComponent.hours({
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) { return ("час", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) { return ("часа", true) }
      return ("часов", true)
    }))
    components.insert(NKDateComponent.minutes({
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) { return ("минуту", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) { return ("минуты", true) }
      return ("минут", true)
    }))
    components.insert(NKDateComponent.seconds({
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) { return ("секунду", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) { return ("секунды", true) }
      return ("секунд", true)
    }))

  }

  mutating func setupDefaultUkrainian() {

    pastFormat = "\(NKTextTimeIntervalConfiguration.numberValueKey) \(NKTextTimeIntervalConfiguration.timeComponentValueKey) тому"
    zeroTimeIntervalPlaceholder = "зараз"
    futureFormat = "через \(NKTextTimeIntervalConfiguration.numberValueKey) \(NKTextTimeIntervalConfiguration.timeComponentValueKey)"

    let ruleLastOne: (Double) -> Bool = { return Int($0) % 10 == 1 && Int($0) % 100 != 11 }
    let ruleLastTwoThreeFour: (Double) -> Bool = {
      if ( (Int($0) % 10 == 2 && Int($0) % 100 != 12) || (Int($0) % 10 == 3 && Int($0) % 100 != 13) || (Int($0) % 10 == 4 && Int($0) % 100 != 14) ) { return true }
      return false
    }

    components.insert(NKDateComponent.seconds({
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) { return ("секунду", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) { return ("секунди", true) }
      return ("секунд", true)
    }))

    components.insert(NKDateComponent.minutes({
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) { return ("хвилину", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) { return ("хвилини", true) }
      return ("хвилин", true)
    }))

    components.insert(NKDateComponent.hours({
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) { return ("годину", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) { return ("години", true) }
      return ("годин", true)
    }))

    components.insert(NKDateComponent.days({
      if Int($0) == 0 { return nil }
      if ruleLastOne($0)  { return ("день", true) }
      if ruleLastTwoThreeFour($0) { return ("дні", true) }
      return ("днів", true)
    }))

    components.insert(NKDateComponent.weeks({
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) { return ("тиждень", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) { return ("тижні", true) }
      return ("тижнів", true)
    }))

    components.insert(NKDateComponent.months({
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) { return ("місяць", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) { return ("місяці", true) }
      return ("місяців", true)
    }))

    components.insert(NKDateComponent.years({
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) { return ("рік", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) { return ("роки", true) }
      return ("років", true)
    }))

    components.insert(NKDateComponent.centuries({
      if Int($0) == 0 { return nil }
      if ruleLastOne($0) { return ("століття", Int($0) != 1) }
      if ruleLastTwoThreeFour($0) { return ("століття", true) }
      return ("століть", true)
    }))

  }

}
