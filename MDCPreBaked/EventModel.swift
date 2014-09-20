//
//  Event.swift
//  MDCPreBaked
//
//  Created by Jeffrey Krebsbach on 9/20/14.
//  Copyright (c) 2014 Sand Jay, Inc. All rights reserved.
//

import Foundation
import CoreData

@objc(EventModel)
public class EventModel : NSManagedObject {
    @NSManaged var timeStamp : NSDate
    @NSManaged var eventDescription: String
    @NSManaged public var instanceCount: Int
    
    public func increment() -> Int {
        return instanceCount++;
    }
    
    public func tripleIncrement() {
        for index in 1...3 {
            instanceCount = instanceCount + index;
        }
    }
}