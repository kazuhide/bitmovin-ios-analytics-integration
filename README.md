# Bitmovin Analytics integration sample

This repository contains a sample implementation of Bitmovin Player with Bitmovin Analytics on iOS in both Swift and Objective-C.

## Supported Platforms

This sample supports the following platforms.
- iOS 12.0+
- tvOS 12.0+

## Installation

You can use CocoaPodd to add the `BitmovinAnalyticsCollector` as a dependency to your project.

The Podfile needs to define the `BitmovinAnalyticsCollector` and `BitmovinPlayer` as follows.
```ruby
source 'https://github.com/bitmovin/cocoapod-specs.git'
pod 'BitmovinAnalyticsCollector', '2.9.1'
pod 'BitmovinPlayer', '3.19.0'

use_frameworks!
```

Then, running the following command install the required libraries.

```ruby
pod install
```
