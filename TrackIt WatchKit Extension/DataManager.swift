//
//  DataManager.swift
//  TrackIt WatchKit Extension
//
//  Created by Nana on 12/22/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

class DataManager {

    static let shared = DataManager()

    static func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }

    enum result {
        case saved
        case failed
        case exists
    }

    private var data: Dictionary<String,String>!

    private init() {
        do {
            // Fetch saved data, if any
            let documentDirectoryURL = DataManager.getDocumentsDirectory()
            let savedData = try Data(contentsOf:documentDirectoryURL)
            data = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? Dictionary
        } catch {
            // If saved data doesn't exist or can't be fetched, initialize empty data
            data = Dictionary<String,String>()
        }

    }

    func fetchValue(for key: String) -> String? {
        return data[key]
    }

    func save(value: String, key: String) -> result {

        var shouldArchive = false
        var result: DataManager.result = .saved

        if let currentValue = data[key] {
            if (value.elementsEqual(currentValue) == false) {shouldArchive = true}
        } else {
            data.updateValue(value, forKey: key)
        }

        if (shouldArchive) {
            do {

                let dataToSave = try NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding:false)
                try dataToSave.write(to: DataManager.getDocumentsDirectory())

            } catch {

                result = .failed
            }
        } else {

            result = .exists
        }

        return result
    }

}
