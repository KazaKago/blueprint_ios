//
//  DeveloperInfoDao.swift
//  Data.Resource
//
//  Created by Kensuke Tamura on 2021/05/07.
//

import Foundation

public class DeveloperInfoDao {

    public func getName() -> String {
        NSLocalizedString("developer_name", bundle: Bundle(for: type(of: self)), comment: "")
    }

    public func getEmailAddress() -> String {
        NSLocalizedString("developer_mail_address", bundle: Bundle(for: type(of: self)), comment: "")
    }

    public func getWebSiteUrl() -> URL {
        URL(string: NSLocalizedString("developer_website_url", bundle: Bundle(for: type(of: self)), comment: ""))!
    }
}
