//
//  RefreshGithubReposUseCaseImpl.swift
//  Domain.UseCase
//
//  Created by Kensuke Tamura on 2021/05/06.
//

import Foundation
import Domain_Model
import Domain_Repository

struct RefreshGithubReposUseCaseImpl: RefreshGithubReposUseCase {

    private let githubRepository: GithubRepository

    init(githubRepository: GithubRepository) {
        self.githubRepository = githubRepository
    }

    func invoke(githubOrgName: GithubOrgName) async {
        _ = await [
            githubRepository.refreshOrg(githubOrgName: githubOrgName),
            githubRepository.refreshRepos(githubOrgName: githubOrgName)
        ]
    }
}
