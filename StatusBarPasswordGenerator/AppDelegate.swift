//
//  AppDelegate.swift
//  StatusBarPasswordGenerator
//
//  Created by Вангог on 1/28/19.
//  Copyright © 2019 Ivan Rybintsev. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system.statusItem(withLength: 35.0)
    let popover:NSPopover = NSPopover()
    var eventMonitor:EventMonitor?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        if let button = statusItem.button{
            button.title = "🔐"
            button.action = #selector(self.togglePopover(sender:))
        }
        popover.contentViewController = PopoverViewController.loadFromNIB()
        eventMonitor = EventMonitor(mask: [.leftMouseUp,.rightMouseUp], handler: { (event) in
            if self.popover.isShown{
                self.closePopover(sender: event!)
            }
        })
    }

    @objc func togglePopover(sender:AnyObject){
        if popover.isShown{
            closePopover(sender: sender)
        }else{
            showPopover(sender: sender)
        }
    }
    
    func closePopover(sender:AnyObject){
        popover.performClose(sender)
        eventMonitor?.stopMonitor()
    }
    
    func showPopover(sender:AnyObject){
        
        if let button = statusItem.button{
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
        }
        
        eventMonitor?.startMonitor()
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

