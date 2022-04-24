//
//  Email.swift
//  Domain.Model
//
//  Created by Kensuke Tamura on 2021/05/10.
//

import Foundation

public struct Email {

    static let REGEX_PATTERN = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@" + "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$"

    public let value: String

    public init(_ value: String) {
//        let regex = try NSRegularExpression(pattern: Self.REGEX_PATTERN)
//        guard let _ = regex.firstMatch(in: value, range: NSRange(location: 0, length: value.count)) else {
//            fatalError()
//        }
        self.value = value
    }

    public func toURL() -> URL {
        URL(string: "mailto:\(value)")!
    }
}
