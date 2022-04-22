//
//  AboutRepositoryImpl.swift
//  Data.Repository
//
//  Created by Kensuke Tamura on 2021/05/10.
//

import Foundation
import Combine
import Domain_Model
import Domain_Repository
import Data_Mapper
import Data_Resource

struct AboutRepositoryImpl: AboutRepository {

    private let appInfoDao: AppInfoDao
    private let developerInfoDao: DeveloperInfoDao
    private let appInfoEntityMapper: AppInfoEntityMapper
    private let developerInfoEntityMapper: DeveloperInfoEntityMapper

    init(appInfoDao: AppInfoDao, developerInfoDao: DeveloperInfoDao, appInfoEntityMapper: AppInfoEntityMapper, developerInfoEntityMapper: DeveloperInfoEntityMapper) {
        self.appInfoDao = appInfoDao
        self.developerInfoDao = developerInfoDao
        self.appInfoEntityMapper = appInfoEntityMapper
        self.developerInfoEntityMapper = developerInfoEntityMapper
    }

    func getAppInfo() -> AppInfo {
        appInfoEntityMapper.map(
            versionName: appInfoDao.getVersionName(),
            versionCode: appInfoDao.getVersionCode()
        )
    }

    func getDeveloperInfo() -> DeveloperInfo {
        developerInfoEntityMapper.map(
            name: developerInfoDao.getName(),
            emailAddress: developerInfoDao.getEmailAddress(),
            webSite: developerInfoDao.getWebSiteUrl()
        )
    }
}
