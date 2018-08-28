# NKTimeIntervalTextTransformation

[![CI Status](https://img.shields.io/travis/nkopilovskii/NKTimeIntervalTextTransformation.svg?style=flat)](https://travis-ci.org/nkopilovskii/NKTimeIntervalTextTransformation)
[![Version](https://img.shields.io/cocoapods/v/NKTimeIntervalTextTransformation.svg?style=flat)](https://cocoapods.org/pods/NKTimeIntervalTextTransformation)
[![License](https://img.shields.io/cocoapods/l/NKTimeIntervalTextTransformation.svg?style=flat)](https://cocoapods.org/pods/NKTimeIntervalTextTransformation)
[![Platform](https://img.shields.io/cocoapods/p/NKTimeIntervalTextTransformation.svg?style=flat)](https://cocoapods.org/pods/NKTimeIntervalTextTransformation)

## Descripion

This framework provides the means for converting the numerical value of the time interval between two dates into a meaningful verbal form. Conversion occurs based on rules that are set by the user of the framework.

The framework contains:
-  structure `NKTextTimeIntervalConfiguration`, which contains rules for converting a numerical value to a string format, performs transformations based on the specified rules;
-  `TimeInterval` extension that computes the number of time components in the specified interval in the form of `Double` (`Double` is used instead of `Int` with the purpose that the user of the framework can independently set the rules for rounding or forming a line for fractional values);
- `Date` class extension, which, based on date comparisons, generates a string representation of a time interval according to specified rules.

## Interface
###  NKTimeComponentDeclensionRule
```swift
/**
  Closure describes declension rule for numerals depending on needs of application or language

  **Example:**

    { timeComponents -> (String, Bool) in
        if <condition> { return (<time_component_name>, <needs_display_numerical_value>) }
        else { return (<time_component_name>, <needs_display_numerical_value>) }
    }


  - parameters:

    - Double: integer part represents the number of complete time components in the considered time interval

  - returns:
    `(String, Bool)`, where `String` value is name of time component the required declination, `Bool` value sets need to display numerical value of time component in specified string format of time interval
*/
public typealias NKTimeComponentDeclensionRule = (Double) -> (String, Bool)?

```


###  NKTextTimeIntervalConfiguration
```swift
public struct NKTextTimeIntervalConfiguration {
  /**
    Return string value if the compared dates are equal
    default: "" (empty string)
  */
  public var zeroTimeIntervalPlaceholder: String


  /*
    Output formats is similar to dateFormat of DateFormatter class: the corresponding key value is set to the corresponding value
    As example if set `pastFormat = "\(NKTextTimeIntervalConfiguration.numberValueKey) \(NKTextTimeIntervalConfiguration.timeComponentValueKey) ago"` in result will be something like "12 seconds ago"

  */

  /**
    Key for specifying location of numerical value of time component in string representation of time interval
  */
  public static let numberValueKey = "<VALUE>"

  /**
    Key for specifying location of numerical value of time component in string representation of time interval
  */
  public static let timeComponentValueKey = "<TIME_COMPONENT>"

  /**
    Time intreval output format as string for positive value
    If `date1.compare(date2) == .OrderedDescending` => `date1.timeIntervalSince(date2) > 0`
    default: "\(NKTextTimeIntervalConfiguration.numberValueKey)"
  */
  public var pastFormat: String

  /**
    Time intreval output format as string for negative value
    If `date1.compare(date2) == .OrderedAscending` => `date1.timeIntervalSince(date2) < 0`
    default: "\(NKTextTimeIntervalConfiguration.numberValueKey)"
  */
  public var futureFormat: String


  /*
    Declension Rules for each time component
  */
  ///Declension Rule for seconds
  public var seconds:   NKTimeComponentDeclensionRule?
  ///Declension Rule for minutes
  public var minutes:   NKTimeComponentDeclensionRule?
  ///Declension Rule for hours
  public var hours:     NKTimeComponentDeclensionRule?
  ///Declension Rule for days
  public var days:      NKTimeComponentDeclensionRule?
  ///Declension Rule for weeks
  public var weeks:     NKTimeComponentDeclensionRule?
  ///Declension Rule for months
  public var months:    NKTimeComponentDeclensionRule?
  ///Declension Rule for years
  public var years:     NKTimeComponentDeclensionRule?
  ///Declension Rule for centuries
  public var centuries: NKTimeComponentDeclensionRule?

  /**
    Base Init method
  */
  public init() 

  /**
    Method calculating count of maximum available time component in input time interval and returns it's string representation based on Declension Rules
    Count of maximum available time components calculates in in extension of the class TimeInterval wich implements NKTimeIntervalDateComponents protocol
    If `interval` equal zero method returns `zeroTimeIntervalPlaceholder`
    If some declension rule isn't setted method use previous rule
    If there is no declension rules from maximum available time component to minimum (seconds) method returns nil
    - parameters:
      - interval: Seconds beetween two dates
      - returns: Optional String
  */
  public func stringRepresentation(for interval: TimeInterval) -> String? 

  /**
    Method creats time interval string representation based on input rule and time component count
    If `value` is equal zero returns `zeroTimeIntervalPlaceholder`
    If `value > 0` will be used `pastFormat`, else - `futureFormat`
    If `rule` is equal zero returns `nil`
    - parameters:
      - rule: Declension rule
      - value: Time component count (Double used if it needs to make representation for floating point value)
    - returns: Optional String
  */
  public func formatedString(for rule: NKTimeComponentDeclensionRule?, with value: Double) -> String? 
}
  
  /**
  This extension contains static methods that generate configurations based on rules for declining the numerals of English and Russian
  */
//MARK: - NKTextTimeIntervalConfiguration default configurations
public extension NKTextTimeIntervalConfiguration {
  
  /**
    Public static method generate default configuration based on rules for declining the numerals of English
  */
  public static func defaultEnglish() -> NKTextTimeIntervalConfiguration
  
  /**
    Public static method generate default configuration based on rules for declining the numerals of Russian
  */
  public static func defaultRussian() -> NKTextTimeIntervalConfiguration 
  
  /**
    Public static method generate default configuration based on rules for declining the numerals of Ukrainian
  */
  public static func defaultUkrainian() -> NKTextTimeIntervalConfiguration 
}
````


### Protocol `NKTimeComponentDeclensionRule`  and `TimeInterval` extension
```swift
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

extension TimeInterval: NKTimeIntervalDateComponents { }

```


### Protocol `NKTimeIntervalTextTransformable` and `Date` extension
```swift 
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
extension Date: NKTimeIntervalTextTransformable {}
```


## Example
To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

NKTimeIntervalTextTransformation is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'NKTimeIntervalTextTransformation'
```

## Author

nkopilovskii, nkopilovskii@gmail.com

## License

NKTimeIntervalTextTransformation is available under the MIT license. See the LICENSE file for more info.
