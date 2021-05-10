//
//  AppInfoDao.swift
//  Data.Resource
//
//  Created by Kensuke Tamura on 2021/05/10.
//

import Foundation

public struct AppInfoDao {

    public func getVersionName() -> String {
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }

    public func getVersionCode() -> Int {
        return Int(Bundle.main.infoDictionary!["CFBundleVersion"] as! String)!
    }
}
