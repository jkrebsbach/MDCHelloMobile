//
//  MDCPreBakedTests.swift
//  MDCPreBakedTests
//
//  Created by Jeffrey Krebsbach on 9/20/14.
//  Copyright (c) 2014 Sand Jay, Inc. All rights reserved.
//

import MDCPreBaked

import UIKit
import XCTest
import CoreData

class MDCPreBakedTests: XCTestCase {
    
    var moc:NSManagedObjectContext?=nil
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let modelURL = NSBundle.mainBundle().URLForResource("MDCPreBaked", withExtension: "momd")!
        let mom = NSManagedObjectModel(contentsOfURL: modelURL)
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        
        var error: NSError? = nil
        
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let url = (urls[urls.count-1] as NSURL).URLByAppendingPathComponent("MDCPreBaked.sqlite")
        
        XCTAssertTrue(psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration:nil, URL:url, options:nil, error:&error) != nil,
            "Should be able to add in-memory store");
        
        self.moc = NSManagedObjectContext()
        self.moc?.persistentStoreCoordinator = psc
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testIncrement() {
        let event = NSEntityDescription.insertNewObjectForEntityForName("Event", inManagedObjectContext: self.moc!) as EventModel
        
        event.instanceCount = 0
        event.increment()
        
        let expected = 1
        
        XCTAssertEqual(event.instanceCount, expected, "Incremented value incorrect");
    }
    
    func testTripleIncrement() {
        let event = NSEntityDescription.insertNewObjectForEntityForName("Event", inManagedObjectContext: self.moc!) as EventModel
        
        event.instanceCount = 0
        event.tripleIncrement()
        
        let expected = 3
        
        XCTAssertEqual(event.instanceCount, expected, "Incremented value incorrect");
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
}
