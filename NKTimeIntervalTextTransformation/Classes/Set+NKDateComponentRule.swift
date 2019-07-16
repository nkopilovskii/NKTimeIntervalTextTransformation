//
//  Set+NKDateComponentRule.swift
//
//  Created by Nick Kopilovskii on 30.08.2018.
//

import Foundation

public extension Set where Set.Element == NKDateComponent  {
  
  public mutating func removeEqual(to rule: NKDateComponent) {
    guard let equalRule = equal(to: rule) else { return }
    self.remove(equalRule)
  }
  
  public func equal(to rule: NKDateComponent) -> NKDateComponent? {
    return first(where: { $0 == rule })
  }
  
  public func greatest() -> NKDateComponent? {
    return self.min { lhs, rhs in return lhs < rhs }
  }
  
  public func smallest() -> NKDateComponent? {
    return self.min { lhs, rhs in return lhs > rhs }
  }
  
  public func greatest(lessThan rule: NKDateComponent) -> NKDateComponent? {
    return filter { $0 > rule }.greatest()
  }
  
  public func smallest(greaterThan rule: NKDateComponent) -> NKDateComponent? {
    return filter { $0 < rule }.smallest()
  }
  
  public func nkComponent(with calendarComponent: Calendar.Component)  -> NKDateComponent? {
    return first(where: {$0.hashValue == calendarComponent.hashValue})
  }
  
}
