platform :ios, '12.0'
use_frameworks!

source 'https://cdn.cocoapods.org'
source 'https://github.com/bitmovin/cocoapod-specs.git'

workspace 'BitmovinPlayerSamples'

def bitmovin_player
  pod 'BitmovinPlayer', '3.19.0'
end

def bitmovin_analytics
  pod 'BitmovinAnalyticsCollector', '2.9.1'
end

target 'BasicPlayback' do
    project 'BasicPlayback/BasicPlayback.xcodeproj'
    bitmovin_player
    bitmovin_analytics
end

target 'BasicPlaybackObjectiveC' do
    project 'BasicPlaybackObjectiveC/BasicPlaybackObjectiveC.xcodeproj'
    bitmovin_player
    bitmovin_analytics
end

