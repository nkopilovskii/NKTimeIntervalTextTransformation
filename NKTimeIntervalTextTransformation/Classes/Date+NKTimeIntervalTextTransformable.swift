//
//  Date+NKTimeIntervalTextTransformable.swift
//
//  Created by Nick Kopilovskii on 22.08.2018.
//  Copyright © 2018 Nick Kopilovskii. All rights reserved.
//

import Foundation

/**
 Protocol declares methods for obtaining a time interval in a string representation using NKTextTimeIntervalConfiguration
 */
public protocol NKTimeIntervalTextTransformable {
  
  static func timeIntervalFromNow(to date: Date, with config: NKTextTimeIntervalConfiguration) -> String?

  func timeInterval(to date: Date, with config: NKTextTimeIntervalConfiguration) -> String?
  
  func value(for component: Calendar.Component, to date: Date) -> Int?
}

/**
 Implementation of NKTimeIntervalTextTransformable protocol in extension of the class Date
 */
extension Date: NKTimeIntervalTextTransformable {
  
  public static func timeIntervalFromNow(to date: Date, with config: NKTextTimeIntervalConfiguration) -> String? {
    return Date().timeInterval(to: date, with: config)
  }

  public func timeInterval(to date: Date, with config: NKTextTimeIntervalConfiguration) -> String? {
    let components = Set<Calendar.Component>.availableComponents(by: config.components)
    let dateComponents = Calendar.current.dateComponents(components, from: self, to: date)

    let (nkComponent, value) = dateComponents.valueForGreatestDateComponent(in: config.components)
    
    return value != 0 ? config.formatedString(for: nkComponent?.rule, with: value) : config.zeroTimeIntervalPlaceholder
  }

  public func value(for component: Calendar.Component, to date: Date) -> Int? {
    return Calendar.current.dateComponents([component], from: self, to: date).value(for: component)
  }

}




