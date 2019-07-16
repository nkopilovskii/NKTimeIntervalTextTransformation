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
//  Set+NKDateComponentRule.swift
//
//  Created by Nick Kopilovskii on 30.08.2018.
//

import Foundation

public extension Set where Set.Element == NKDateComponent  {
  
  mutating func removeEqual(to rule: NKDateComponent) {
    guard let equalRule = equal(to: rule) else { return }
    self.remove(equalRule)
  }
  
  func equal(to rule: NKDateComponent) -> NKDateComponent? {
    return first(where: { $0 == rule })
  }
  
  func greatest() -> NKDateComponent? {
    return self.min { lhs, rhs in return lhs < rhs }
  }
  
  func smallest() -> NKDateComponent? {
    return self.min { lhs, rhs in return lhs > rhs }
  }
  
  func greatest(lessThan rule: NKDateComponent) -> NKDateComponent? {
    return filter { $0 > rule }.greatest()
  }
  
  func smallest(greaterThan rule: NKDateComponent) -> NKDateComponent? {
    return filter { $0 < rule }.smallest()
  }
  
  func nkComponent(with calendarComponent: Calendar.Component)  -> NKDateComponent? {
    return first(where: {$0.hashValue == calendarComponent.hashValue})
  }
  
}
