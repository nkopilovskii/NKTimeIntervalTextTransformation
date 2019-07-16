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




