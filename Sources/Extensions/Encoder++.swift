//
//  Encoder++.swift
//

import Foundation

public extension JSONEncoder {
    
    func encode<T>(_ value: T, encoderKey: CoderUserInfoKey? = nil) throws -> Data where T : Encodable {
        if let encoderKey = encoderKey {
            userInfo[.jsonEncoderName] = encoderKey
        }
        let root = try encode(value)
        return root
    }
}

public extension Encoder {
    var coderUserInfoKey: CoderUserInfoKey? {
        return userInfo[.jsonEncoderName] as? CoderUserInfoKey
    }
}

fileprivate extension CodingUserInfoKey {
    static let jsonEncoderName = CodingUserInfoKey(rawValue: "jsonEncoderName")!
}
