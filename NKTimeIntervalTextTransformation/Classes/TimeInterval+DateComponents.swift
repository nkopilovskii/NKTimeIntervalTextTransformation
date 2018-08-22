//
//  NKTimeInterval+DateComponents.swift
//
//  Created by Nick Kopilovskii on 22.08.2018.
//  Copyright © 2018 Nick Kopilovskii. All rights reserved.
//

import Foundation

protocol NKTimeIntervalDateComponents {
  var seconds:  Int { get }
  var minutes:  Int { get }
  var hours:    Int { get }
  var days:     Int { get }
  var weeks:    Int { get }
  var months:   Int { get }
  var years:    Int { get }
}

extension TimeInterval: NKTimeIntervalDateComponents {
  var seconds:  Int { return Int(self) }
  var minutes:  Int { return Int(self / 60) }
  var hours:    Int { return Int(self / 3600) }
  var days:     Int { return Int(self / (3600 * 24)) }
  var weeks:    Int { return Int(self / (3600 * 24 * 7)) }
  var months:   Int { return Int(self / (3600 * 24 * 7 * 4)) }
  var years:    Int { return Int(self / (3600 * 24 * 365)) }
}
