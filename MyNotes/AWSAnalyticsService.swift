//
//  AWSAnalyticsService.swift
//  MyNotes
//
//  Created by Larry Nickerson on 9/18/18.
//  Copyright © 2018 Hall, Adrian. All rights reserved.
//

import Foundation
import AWSCore
import AWSPinpoint

class AWSAnalyticsService : AnalyticsService {
    var pinpoint: AWSPinpoint?
    
    init() {
        let config = AWSPinpointConfiguration.defaultPinpointConfiguration(launchOptions: nil)
        pinpoint = AWSPinpoint(configuration: config)
    }
    
    func recordEvent(_ eventName: String, parameters: [String : String]?, metrics: [String : Double]?) {
        
        // create an event
        let event = pinpoint?.analyticsClient.createEvent(withEventType: eventName)
        
        // add a custom attribute
        if (parameters != nil) {
            for (key, value) in parameters! {
                event?.addAttribute(value, forKey: key)
            }
        }
        
        // add a metric
        if (metrics != nil) {
            for (key, value) in metrics! {
                event?.addMetric(NSNumber(value: value), forKey: key)
            }
        }
        // record and submit the custom event
        pinpoint?.analyticsClient.record(event!)
        pinpoint?.analyticsClient.submitEvents()
    }
}
