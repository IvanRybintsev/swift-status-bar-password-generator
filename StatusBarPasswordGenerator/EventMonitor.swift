//
//  EventMonitor.swift
//  StatusBarPasswordGenerator
//
//  Created by Вангог on 1/28/19.
//  Copyright © 2019 Ivan Rybintsev. All rights reserved.
//

import Cocoa

class EventMonitor{
    
    private var mask:NSEvent.EventTypeMask?
    private var handler: (NSEvent?) -> ()
    private var monitor:Any?
    
    init(mask:NSEvent.EventTypeMask, handler: @escaping (NSEvent?) -> ()) {
        self.mask = mask
        self.handler = handler
    }
    
    deinit {
        
    }
    
    func startMonitor(){
        self.monitor = NSEvent.addGlobalMonitorForEvents(matching: mask!, handler: handler)
    }
    
    func stopMonitor(){
        if monitor != nil{
            NSEvent.removeMonitor(monitor!)
            monitor = nil
        }
    }
}
