//
//  AboutInfo.swift
//  Domain.Model
//
//  Created by Kensuke Tamura on 2021/05/10.
//

import Foundation

public struct AboutInfo {
    public let appInfo: AppInfo
    public let developerInfo: DeveloperInfo

    public init(appInfo: AppInfo, developerInfo: DeveloperInfo) {
        self.appInfo = appInfo
        self.developerInfo = developerInfo
    }
}
