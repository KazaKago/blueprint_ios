//
//  GetGithubReposPublisherUseCaseImpl.swift
//  Domain.UseCase
//
//  Created by Kensuke Tamura on 2021/05/06.
//

import Foundation
import StoreFlowable
import Domain_Model
import Domain_Repository

struct GetGithubReposPublisherUseCaseImpl: GetGithubReposPublisherUseCase {

    private let githubRepository: GithubRepository

    init(githubRepository: GithubRepository) {
        self.githubRepository = githubRepository
    }

    func invoke(githubOrgName: GithubOrgName) -> LoadingStateSequence<GithubOrgAndRepos> {
        let orgPublisher = githubRepository.getOrgPublisher(githubOrgName: githubOrgName)
        let reposPublisher = githubRepository.getReposPublisher(githubOrgName: githubOrgName)
        return orgPublisher.combineState(reposPublisher) { githubOrg, githubRepos in
            GithubOrgAndRepos(githubOrg: githubOrg, githubRepos: githubRepos)
        }
    }
}
