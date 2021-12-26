//
//  Decoder++.swift
//

import Foundation

public extension JSONDecoder {
    func decode<T: Decodable>(_ type: T.Type, from data: Data, decoderKey: CoderUserInfoKey) throws -> T {
        userInfo[.jsonDecoderName] = decoderKey
        let root = try decode(T.self, from: data)
        return root
    }
}


public extension Decoder {
    var coderUserInfoKey: CoderUserInfoKey? {
        return userInfo[.jsonDecoderName] as? CoderUserInfoKey
    }
}


fileprivate extension CodingUserInfoKey {
    static let jsonDecoderName = CodingUserInfoKey(rawValue: "jsonDecoderName")!
}
