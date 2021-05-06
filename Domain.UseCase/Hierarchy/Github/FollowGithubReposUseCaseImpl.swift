//
//  FollowGithubReposUseCaseImpl.swift
//  Domain.UseCase
//
//  Created by Kensuke Tamura on 2021/05/06.
//

import Foundation
import Combine
import StoreFlowable
import Domain_Model
import Domain_Repository

struct FollowGithubReposUseCaseImpl: FollowGithubReposUseCase {

    private let githubRepository: GithubRepository

    init(githubRepository: GithubRepository) {
        self.githubRepository = githubRepository
    }

    func invoke(githubOrgName: GithubOrgName) -> StatePublisher<[GithubRepo]> {
        githubRepository.followRepos(githubOrgName: githubOrgName)
    }
}
