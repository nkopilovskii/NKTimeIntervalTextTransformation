//
//  NKTimeInterval+DateComponents.swift
//
//  Created by Nick Kopilovskii on 22.08.2018.
//  Copyright © 2018 Nick Kopilovskii. All rights reserved.
//

import Foundation

protocol NKTimeIntervalDateComponents {
  var seconds:    Double { get }
  var minutes:    Double { get }
  var hours:      Double { get }
  var days:       Double { get }
  var weeks:      Double { get }
  var months:     Double { get }
  var years:      Double { get }
  var centuries:  Double { get }
}

extension TimeInterval: NKTimeIntervalDateComponents {
  public var seconds:    Double { return Double(self) }
  public var minutes:    Double { return Double(self / 60) }
  public var hours:      Double { return Double(self / 3600) }
  public var days:       Double { return Double(self / (3600 * 24)) }
  public var weeks:      Double { return Double(self / (3600 * 24 * 7)) }
  public var months:     Double { return Double(self / (3600 * 24 * 7 * 4)) }
  public var years:      Double { return Double(self / (3600 * 24 * 365)) }
  public var centuries:  Double { return Double(self / (3600 * 24 * 365 * 100)) }
}
