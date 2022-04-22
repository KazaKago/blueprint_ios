//
//  AppInfo.swift
//  Domain.Model
//
//  Created by Kensuke Tamura on 2021/05/10.
//

import Foundation

public struct AppInfo {
    public let versionName: VersionName
    public let versionCode: VersionCode

    public init(versionName: VersionName, versionCode: VersionCode) {
        self.versionName = versionName
        self.versionCode = versionCode
    }
}
