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
