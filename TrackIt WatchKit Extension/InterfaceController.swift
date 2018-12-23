//
//  InterfaceController.swift
//  TrackIt WatchKit Extension
//
//  Created by Nana on 12/22/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import WatchKit
import Foundation

func displayString(for weight: String) -> String {
    return "\(weight) Kgs"
}

let weightKey = "weight"

class InterfaceController: WKInterfaceController {

    @IBOutlet weak var weightDisplayLabel: WKInterfaceLabel!

    var currentWeight: String?


    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        currentWeight = DataManager.shared.fetchValue(for: weightKey)
        weightDisplayLabel.setText(displayString(for: currentWeight ?? "Track It!"))
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
            self.weightDisplayLabel.setText(displayString(for: newWeight))

            // Save the newly tracked weight against current date
            let _ = DataManager.shared.save(value: newWeight, key: weightKey)

            // TDO: Can throw alert for "failure" result
        }
    }

    
}
