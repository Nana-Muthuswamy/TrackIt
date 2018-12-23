//
//  InterfaceController.swift
//  TrackIt WatchKit Extension
//
//  Created by Nana on 12/22/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var weightDisplayLabel: WKInterfaceLabel!


    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func trackWeight() {

        // Display weight input interface
        presentTextInputController(withSuggestions: ["81.0","81.5","82.5","83.0"], allowedInputMode: .plain) { [unowned self] (results) in

            guard let newWeight = results?.first as? String else {return}

            // TDO: Validate and format the input before display
            self.weightDisplayLabel.setText("\(newWeight) Kgs")

            // Save the newly tracked weight against current date

        }
    }

    
}
