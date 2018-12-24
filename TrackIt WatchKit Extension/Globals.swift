//
//  Globals.swift
//  TrackIt WatchKit Extension
//
//  Created by Nana on 12/23/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

let weightKey = "weight"

enum WeightInputSuggestion: CustomStringConvertible {
    case best
    case good
    case bad
    case worst

    var description: String {
        switch self {
        case .best:
            return "Great work! - "
        case .good:
            return "Going good - "
        case .bad:
            return "Not good - "
        case .worst:
            return "Wake up!! - "
        }
    }
}
