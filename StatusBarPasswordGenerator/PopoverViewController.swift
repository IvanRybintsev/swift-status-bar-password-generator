//
//  PopoverViewController.swift
//  StatusBarPasswordGenerator
//
//  Created by Вангог on 1/28/19.
//  Copyright © 2019 Ivan Rybintsev. All rights reserved.
//

import Cocoa

class PopoverViewController: NSViewController, NSTextFieldDelegate {

    class func loadFromNIB() -> NSViewController{
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateController(withIdentifier: "PopoverViewController") as! NSViewController
        return vc
    }
    
    @IBOutlet weak var upperCase: NSButton!
    @IBOutlet weak var lowerCase: NSButton!
    @IBOutlet weak var digits: NSButton!
    @IBOutlet weak var autoSave: NSButton!
    @IBOutlet weak var lengthField: NSTextField!
    @IBOutlet weak var resultField: NSTextField!
    @IBOutlet weak var statusLabel: NSTextField!
    @IBOutlet weak var specials: NSButton!
    @IBOutlet weak var exitButton: NSButton!
    @IBOutlet weak var stepper: NSStepper!
    
    @IBAction func generate(_ sender: Any) {
        var str = ""
        if upperCase.state == .on{
            str.append("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        }
        if lowerCase.state == .on{
            str.append("abcdefghijklmnopqrstuvwxyz")
        }
        if digits.state == .on{
            str.append("0123456789")
        }
        if specials.state == .on{
            str.append("$%)-_@!")
        }
        if str.count>0{
            let length = lengthField.integerValue
            if length>=4{
                var result = ""
                for _ in 0..<length{
                    result.append(str.randomElement()!)
                }
                resultField.stringValue = result
                resultField.selectText(resultField)
                statusLabel.textColor = NSColor.green
                if autoSave.state == .on{
                    let buffer = NSPasteboard.general
                    buffer.clearContents()
                    buffer.setString(result, forType: .string)
                    statusLabel.stringValue = "Copied to buffer."
                }else{
                    statusLabel.stringValue = ""
                }
            }else{
                statusLabel.textColor = NSColor.red
                statusLabel.stringValue = "Password length invalid."
            }
        }else{
            statusLabel.textColor = NSColor.red
            statusLabel.stringValue = "Symbols empty."
        }
        
    }
    
    func controlTextDidChange(_ obj: Notification) {
        if let field = obj.object as! NSTextField?{
            stepper.takeIntegerValueFrom(field)
        }
    }
    
    @objc func closeApp(sender:AnyObject){
        NSApplication.shared.terminate(sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exitButton.action = #selector(self.closeApp(sender:))
        // Do view setup here.
    }
    
}
