//
//  Email.swift
//  Domain.Model
//
//  Created by Kensuke Tamura on 2021/05/10.
//

import Foundation

public struct Email {
    public let value: String

    public init(_ value: String) {
        self.value = value
    }

    public func toURL() -> URL {
        URL(string: "mailto:\(value)")!
    }
}
