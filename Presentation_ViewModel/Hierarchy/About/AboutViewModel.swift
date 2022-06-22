//
//  AboutViewModel.swift
//  Presentation.ViewModel
//
//  Created by Kensuke Tamura on 2021/05/10.
//

import Foundation
import Presentation_UiState
import Domain_UseCase
import Domain_Model

public final class AboutViewModel : ObservableObject {

    @Published public var uiState: AboutUiState = .loading
    private let getAboutInfoUseCase: GetAboutInfoUseCase

    public init(getAboutInfoUseCase: GetAboutInfoUseCase) {
        self.getAboutInfoUseCase = getAboutInfoUseCase
    }

    public func loadAboutInfo() {
        let aboutInfo = getAboutInfoUseCase.invoke()
        uiState = AboutUiState.completed(
            appInfo: aboutInfo.appInfo,
            developerInfo: aboutInfo.developerInfo
        )
    }
}
