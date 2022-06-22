//
//  RequestAdditionalGithubOrgsUseCaseImpl.swift
//  Domain.UseCase
//
//  Created by Kensuke Tamura on 2021/05/06.
//

import Foundation
import Domain_Repository

struct RequestAdditionalGithubOrgsUseCaseImpl: RequestAdditionalGithubOrgsUseCase {

    private let githubRepository: GithubRepository

    init(githubRepository: GithubRepository) {
        self.githubRepository = githubRepository
    }

    func invoke(continueWhenError: Bool) async {
        await githubRepository.requestAdditionalOrgs(continueWhenError: continueWhenError)
    }
}
