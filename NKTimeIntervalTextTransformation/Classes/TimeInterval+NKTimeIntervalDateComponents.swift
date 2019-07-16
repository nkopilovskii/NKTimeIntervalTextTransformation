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
