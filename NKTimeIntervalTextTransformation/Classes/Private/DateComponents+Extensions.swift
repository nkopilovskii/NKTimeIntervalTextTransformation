//
//  DateComponents+Extensions.swift
//
//  Created by Nick Kopilovskii on 30.08.2018.
//

import Foundation

extension DateComponents {
  
  func valueForGreatestDateComponent(in nkComponents: Set<NKDateComponent>) -> (NKDateComponent?, Int) {
    
    guard let greatestComponent = nkComponents.filter({self.value(for: $0) != 0}).greatest() else {return (nil, 0)}

    let componentValue = value(for: greatestComponent) ?? 0

    return (greatestComponent, componentValue)
  }
  
  
  func value(for nkComponent: NKDateComponent) -> Int? {
    if nkComponent == NKDateComponent.centuries({ _ in return nil }) {
      return (value(for: .year) ?? 0) / 100
    }
    if nkComponent == NKDateComponent.weeks({ _ in return nil })  {
      return (value(for: .day) ?? 0) / 7
    }
    guard let component = Calendar.Component.component(by: nkComponent) else { return nil }
    return value(for: component)
  }
  
}
