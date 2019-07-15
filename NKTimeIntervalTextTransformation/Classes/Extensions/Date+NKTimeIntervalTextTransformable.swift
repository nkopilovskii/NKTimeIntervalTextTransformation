//
//Copyright (c) 2018 nkopilovskii <nikolay.k@powercode.us>
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
  
}

/**
 Implementation of NKTimeIntervalTextTransformable protocol in extension of the class Date
 */
extension Date: NKTimeIntervalTextTransformable {
  
  public static func timeIntervalFromNow(to date: Date, with config: NKTextTimeIntervalConfiguration) -> String? {
    return Date().timeInterval(to: date, with: config)
  }
  
  public func timeInterval(to date: Date, with config: NKTextTimeIntervalConfiguration) -> String? {
    return config.stringRepresentation(for: timeIntervalSince(date))
  }
  
}


