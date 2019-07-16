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
//  NKDateComponentRule.swift
//  NKTimeIntervalTextTransformation
//
//  Created by Nick Kopilovskii on 29.08.2018.
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




//MARK: - DateComponentRules
public enum NKDateComponent: Hashable, Equatable {
  
  case centuries(NKTimeComponentDeclensionRule)
  case years(NKTimeComponentDeclensionRule)
  case months(NKTimeComponentDeclensionRule)
  case weeks(NKTimeComponentDeclensionRule)
  case days(NKTimeComponentDeclensionRule)
  case hours(NKTimeComponentDeclensionRule)
  case minutes(NKTimeComponentDeclensionRule)
  case seconds(NKTimeComponentDeclensionRule)
  
  public var rule: NKTimeComponentDeclensionRule {
    switch self {
    case .centuries(let c): return c
    case .years(let c):     return c
    case .months(let c):    return c
    case .weeks(let c):     return c
    case .days(let c):      return c
    case .hours(let c):     return c
    case .minutes(let c):   return c
    case .seconds(let c):   return c
    }
  }
  
  public var hashValue: Int {
    switch self {
    case .centuries: return 0
    case .years:     return 1
    case .months:    return 2
    case .weeks:     return 3
    case .days:      return 4
    case .hours:     return 5
    case .minutes:   return 6
    case .seconds:   return 7
    }
  }
  
  public static func == (lhs: NKDateComponent, rhs: NKDateComponent) -> Bool {
    return lhs.hashValue == rhs.hashValue
  }
  
  public static func != (lhs: NKDateComponent, rhs: NKDateComponent) -> Bool {
    return lhs.hashValue != rhs.hashValue
  }
  
  public static func < (lhs: NKDateComponent, rhs: NKDateComponent) -> Bool {
    return lhs.hashValue < rhs.hashValue
  }
  
  public static func > (lhs: NKDateComponent, rhs: NKDateComponent) -> Bool {
    return lhs.hashValue > rhs.hashValue
  }
  
}
