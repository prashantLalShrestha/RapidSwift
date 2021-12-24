//
//  String++.swift
//

import Foundation

public extension String {
    func isValid(regex: String) -> Bool {
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        let result = predicate.evaluate(with: self)
        return result
    }
}
