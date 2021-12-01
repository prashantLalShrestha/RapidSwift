//
//  Dictionary++.swift
//

import Foundation


@dynamicMemberLookup
public protocol DictionaryDynamicLookup {
    associatedtype Key
    associatedtype Value
    subscript(key: Key) -> Value? { get }
}

public extension DictionaryDynamicLookup where Key == String {
    subscript(dynamicMember member: String) -> Value? {
        return self[member]
    }
}

extension Dictionary: DictionaryDynamicLookup {}
