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

    // MARK: - *IBOutlets*

    @IBOutlet weak var weightDisplayLabel: WKInterfaceLabel!

    // MARK: - *Instance Properties*

    var currentWeight: String?

    // MARK: - *Computed Properties*

    var weightDisplayStr: String {

        if let weightStr = currentWeight {
            return "\(weightStr) Kgs"
        } else {
            return "Track It!"
        }
    }

    var inputSuggestions: [String] {

        var suggestions = [String]()

        if let weightStr = currentWeight, let weight: Double = Double(weightStr) {
            for option in [(1.0, WeightInputSuggestion.best), (0.5, .good), (-0.5, .bad), (-1.0, .worst)] {
                suggestions.append("\(option.1.description)\(weight-(option.0))")
            }
        }

        return suggestions
    }

    // MARK: - *Method Overrides*

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        currentWeight = DataManager.shared.fetchValue(for: weightKey)
        weightDisplayLabel.setText(weightDisplayStr)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    // MARK: - *Action Methods*

    @IBAction func trackWeight() {

        // Display weight input interface
        presentTextInputController(withSuggestions: inputSuggestions, allowedInputMode: .plain) { [unowned self] (results) in

            guard let inputStr = results?.first as? String else {return}

            // TDO: Validate and format the input before display
            self.currentWeight = self.extractWeight(from: inputStr)
            self.weightDisplayLabel.setText(self.weightDisplayStr)

            // Save the newly tracked weight against current date
            if let newWeight = self.currentWeight {
                let _ = DataManager.shared.save(value: newWeight, key: weightKey)
            }

            // TDO: Can throw alert for "failure" result
        }
    }

    // MARK: - *Helper Methods*

    func extractWeight(from input: String) -> String {

        if (input.contains("-")) {
            return input.suffix(4).description
        } else {
            return input
        }
    }
}
