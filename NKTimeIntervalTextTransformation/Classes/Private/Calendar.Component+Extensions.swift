//
//  Calendar.Component+Extensions.swift
//
//  Created by Nick Kopilovskii on 30.08.2018.
//

import Foundation


extension Calendar.Component {
  
  static func component(by nkComponent: NKDateComponent) -> Calendar.Component? {
    switch nkComponent {
    case .years:     return .year
    case .months:    return .month
    case .days:      return .day
    case .hours:     return .hour
    case .minutes:   return .minute
    case .seconds:   return .second
    case .weeks, .centuries: return nil
    }
  }
  
}

extension Set where Set.Element == Calendar.Component  {
  
  static func availableComponents(by nkComponents: Set<NKDateComponent>) -> Set<Calendar.Component> {
    return Set(nkComponents.map({Calendar.Component.component(by: $0)}).compactMap({$0}))
  }
  
}




