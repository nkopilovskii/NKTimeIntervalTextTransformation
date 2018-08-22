//
//  NKTimeIntervalTextTransformable.swift
//
//  Created by Nick Kopilovskii on 22.08.2018.
//  Copyright © 2018 Nick Kopilovskii. All rights reserved.
//

import Foundation

public protocol NKTimeIntervalTextTransformable {
  static func timeIntervalFromNow(to date: Date, with config: NKTextTimeIntervalConfiguration) -> String?
  func timeInterval(to date: Date, with config: NKTextTimeIntervalConfiguration) -> String?
}

extension Date: NKTimeIntervalTextTransformable {
  public static func timeIntervalFromNow(to date: Date, with config: NKTextTimeIntervalConfiguration) -> String? {
    return Date().timeInterval(to: date, with: config)
  }
  
  public func timeInterval(to date: Date, with config: NKTextTimeIntervalConfiguration) -> String? {
    let interval = timeIntervalSince(date)
    
    if interval.years != 0, let str = config.string(for: config.years, with: interval.years) { return str }
    
    if interval.months != 0, let str = config.string(for: config.months, with: interval.months) { return str }
    
    if interval.weeks != 0, let str = config.string(for: config.weeks, with: interval.weeks) { return str }
    
    if interval.days != 0, let str = config.string(for: config.days, with: interval.days) { return str }
    
    if interval.hours != 0, let str = config.string(for: config.hours, with: interval.hours) { return str }
    
    if interval.minutes != 0, let str = config.string(for: config.minutes, with: interval.minutes) { return str }
    
    if interval.seconds != 0, let str = config.string(for: config.seconds, with: interval.seconds) { return str }
    
    return nil
  }
  
}


