//
//  RefreshGithubOrgsUseCaseImpl.swift
//  Domain.UseCase
//
//  Created by Kensuke Tamura on 2021/05/06.
//

import Foundation
import Domain_Repository

struct RefreshGithubOrgsUseCaseImpl: RefreshGithubOrgsUseCase {

    private let githubRepository: GithubRepository

    init(githubRepository: GithubRepository) {
        self.githubRepository = githubRepository
    }

    func invoke() async {
        await githubRepository.refreshOrgs()
    }
}
