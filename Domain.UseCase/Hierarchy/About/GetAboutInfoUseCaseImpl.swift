//
//  GetAboutInfoUseCaseImpl.swift
//  Domain.UseCase
//
//  Created by Kensuke Tamura on 2021/05/10.
//

import Foundation
import Combine
import Domain_Model
import Domain_Repository

struct GetAboutInfoUseCaseImpl: GetAboutInfoUseCase {

    private let aboutRepository: AboutRepository

    init(aboutRepository: AboutRepository) {
        self.aboutRepository = aboutRepository
    }

    func invoke() -> AboutInfo {
        AboutInfo(
            appInfo: aboutRepository.getAppInfo(),
            developerInfo: aboutRepository.getDeveloperInfo()
        )
    }
}
