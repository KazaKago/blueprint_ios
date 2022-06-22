//
//  AboutRepository.swift
//  Domain.Repository
//
//  Created by Kensuke Tamura on 2021/05/10.
//

import Foundation
import Domain_Model

public protocol AboutRepository {

    func getAppInfo() -> AppInfo

    func getDeveloperInfo() -> DeveloperInfo
}
