//
//  CacheHolder.swift
//  Data_Cache
//
//  Created by Kensuke Tamura on 2022/04/23.
//

import Foundation

public struct CacheHolder<T> {
    public let value: T
    public let createdAt: Date

    public init(value: T, createdAt: Date = Date()) {
        self.value = value
        self.createdAt = createdAt
    }
}
