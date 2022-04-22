//
//  DeveloperInfo.swift
//  Domain.Model
//
//  Created by Kensuke Tamura on 2021/05/10.
//

import Foundation

public struct DeveloperInfo {
    public let name: String
    public let mailAddress: Email
    public let siteUrl: URL

    public init(name: String, mailAddress: Email, siteUrl: URL) {
        self.name = name
        self.mailAddress = mailAddress
        self.siteUrl = siteUrl
    }
}
