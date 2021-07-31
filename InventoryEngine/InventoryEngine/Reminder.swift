//
//  Reminder.swift
//  InventoryEngine
//
//  Created by Charles Hsieh on 2021/7/27.
//

import Foundation

public struct Reminder {

    let dueDate: Date

    let intervalToDue: TimeInterval

    var title: String

    var description: String

    public init(dueDate: Date, intervalToDue: TimeInterval, title: String, description: String) {
        self.dueDate = dueDate
        self.intervalToDue = intervalToDue
        self.title = title
        self.description = description
    }
}
