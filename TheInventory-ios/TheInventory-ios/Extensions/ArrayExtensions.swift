//
//  ArrayExtensions.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/30.
//

import Foundation

extension Array {

    public mutating func mutateElement(where predicate: (Element) -> Bool, transform: (inout Element) -> Void) {
        for (index, element) in enumerated() where predicate(element) {
            var copy = element
            transform(&copy)
            self[index] = copy
        }
    }

    public mutating func mutateElement(_ element: Element, transform: (inout Element) -> Void) where Element: Equatable {
        mutateElement(where: { $0 == element }, transform: transform)
    }

    public mutating func replaceElement(where predicate: (Element) -> Bool, with newElement: Element) {
        for (index, element) in enumerated() where predicate(element) {
            self[index] = newElement
        }
    }

    public mutating func replaceElement(_ element: Element, with newElement: Element) where Element: Equatable {
        replaceElement(where: { $0 == element }, with: newElement)
    }
}
