//
//  AboutViewModel.swift
//  Presentation.ViewModel
//
//  Created by Kensuke Tamura on 2021/05/10.
//

import Foundation
import Combine
import Domain_UseCase
import Domain_Model

public final class AboutViewModel : ObservableObject {

    @Published public var appInfo: AppInfo?
    @Published public var developerInfo: DeveloperInfo?
    private let getAboutInfoUseCase: GetAboutInfoUseCase

    public init(getAboutInfoUseCase: GetAboutInfoUseCase) {
        self.getAboutInfoUseCase = getAboutInfoUseCase
    }

    public func initialize() {
        loadAboutInfo()
    }

    private func loadAboutInfo() {
        let aboutInfo = getAboutInfoUseCase.invoke()
        appInfo = aboutInfo.appInfo
        developerInfo = aboutInfo.developerInfo
    }
}
