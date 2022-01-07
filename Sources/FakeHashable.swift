//
//  FakeHashable.swift
//

import Foundation

@dynamicMemberLookup
public struct FakeHashable<T>: Hashable {
    public private(set) var value: T
    
    public init(_ value: T) {
        self.value = value
    }
    
    public func hash(into hasher: inout Hasher) {
        
    }
    
    public subscript<Value>(dynamicMember keyPath: WritableKeyPath<T, Value>) -> Value {
        get { return value[keyPath: keyPath] }
        set { value[keyPath: keyPath] = newValue }
    }
    
    public static func == (lhs: FakeHashable<T>, rhs: FakeHashable<T>) -> Bool {
        return true
    }
}
