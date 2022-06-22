//
//  AboutUiState.swift
//  Presentation_ViewModel
//
//  Created by Kensuke Tamura on 2022/04/23.
//

import Foundation
import Domain_Model

public enum AboutUiState {
    case loading
    case completed(
        appInfo: AppInfo,
        developerInfo: DeveloperInfo
    )

    public func onDeveloperMailAddress(_ invoke: (Email) -> Void) {
        switch (self) {
        case .loading:
            break
        case .completed(_, let developerInfo):
            invoke(developerInfo.mailAddress)
        }
    }

    public func onDeveloperSiteUrl(_ invoke: (URL) -> Void) {
        switch (self) {
        case .loading:
            break
        case .completed(_, let developerInfo):
            invoke(developerInfo.siteUrl)
        }
    }

    public func classify<T>(
        onLoading: () -> T,
        onCompleted: (_ appInfo: AppInfo, _ developerInfo: DeveloperInfo) -> T
    ) -> T {
        switch (self) {
        case .loading:
            return onLoading()
        case .completed(let appInfo, let developerInfo):
            return onCompleted(appInfo, developerInfo)
        }
    }
}
