//
//  AppInfoEntityMapper.swift
//  Data.Mapper
//
//  Created by Kensuke Tamura on 2021/05/10.
//

import Foundation
import Domain_Model
import Data_Resource

public struct AppInfoEntityMapper {

    public func map(versionName: String, versionCode: Int) -> AppInfo {
        AppInfo(
            versionName: VersionName(versionName),
            versionCode: VersionCode(versionCode)
        )
    }
}
