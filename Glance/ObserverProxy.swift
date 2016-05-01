//
//  ObserverProxy.swift
//  Glance
//
//  Created by Jonah Starling on 5/1/16.
//  Copyright © 2016 In The Belly. All rights reserved.
//

///
/// Provides proxy functionality for NSNotificationCenter
/// events for Swift classes that do not support integration
/// with Objective-C code.
///

import Foundation

class ObserverProxy {
    
    var closure: (NSNotification) -> ();
    var name: String;
    var object: AnyObject?;
    
    init(name: String, closure: (NSNotification) -> ()) {
        self.closure = closure;
        self.name = name;
        
        self.start();
    }
    
    convenience init(name: String, object: AnyObject, closure: (NSNotification) -> ()) {
        self.init(name: name, closure: closure);
        self.object = object;
    }
    
    deinit {
        stop()
    }
    
    func start() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"handler:", name:name, object: object);
    }
    
    func stop() {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    func handler(notification: NSNotification) {
        closure(notification);
    }
}
