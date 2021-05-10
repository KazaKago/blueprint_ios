//
//  DeveloperInfoEntityMapper.swift
//  Data.Mapper
//
//  Created by Kensuke Tamura on 2021/05/10.
//

import Foundation
import Domain_Model
import Data_Resource

public struct DeveloperInfoEntityMapper {

    public func map(name: String, emailAddress: String, webSite: URL) -> DeveloperInfo {
        return DeveloperInfo(
            name: name,
            mailAddress: Email(emailAddress),
            siteUrl: webSite
        )
    }
}
