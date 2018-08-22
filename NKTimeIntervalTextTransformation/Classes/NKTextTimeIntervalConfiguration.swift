//
//  NKTextTimeIntervalConfiguration.swift
//
//  Created by Nick Kopilovskii on 22.08.2018.
//  Copyright © 2018 Nick Kopilovskii. All rights reserved.
//

import Foundation

public typealias NKTimeComponentDeclensionRule = (Int) -> (String, Bool)?

public struct NKTextTimeIntervalConfiguration {
  public var seconds: NKTimeComponentDeclensionRule = { return $0 == 1 ? ("a second", false) : ("seconds", true) }
  public var minutes: NKTimeComponentDeclensionRule = { return $0 == 1 ? ("a minute", false) : ("minutes", true) }
  public var hours:   NKTimeComponentDeclensionRule = { return $0 == 1 ? ("a hour", false)   : ("hours", true) }
  public var days:    NKTimeComponentDeclensionRule = { return $0 == 1 ? ("a day", false)    : ("days", true) }
  public var weeks:   NKTimeComponentDeclensionRule = { return $0 == 1 ? ("a week", false)   : ("weeks", true) }
  public var months:  NKTimeComponentDeclensionRule = { return $0 == 1 ? ("a month", false)  : ("months", true) }
  public var years:   NKTimeComponentDeclensionRule = { return $0 == 1 ? ("a year", false)   : ("years", true) }
  
  public static let numberValueKey = "<VALUE>"
  public static let timeComponentValueKey = "<TIME_COMPONENT>"
  
  public var pastFormat = "\(numberValueKey) \(timeComponentValueKey) ago"
  public var futureFormat = "in \(numberValueKey) \(timeComponentValueKey)"
  
  public func  string(for rule: NKTimeComponentDeclensionRule, with value: Int) -> String? {
    guard let (timeComponentStringValue, shouldWriteNumbers) = rule(abs(value)) else { return nil }
    
    var formatter = value > 0 ? pastFormat : futureFormat
    formatter = formatter.replacingOccurrences(of: NKTextTimeIntervalConfiguration.timeComponentValueKey, with: timeComponentStringValue)
    formatter = formatter.replacingOccurrences(of: NKTextTimeIntervalConfiguration.numberValueKey, with: shouldWriteNumbers ? String(abs(value)) : "")
    formatter = formatter.replacingOccurrences(of: "  ", with: " ")

    if formatter.first == " " { formatter.removeFirst() }
    return formatter
  }
}


