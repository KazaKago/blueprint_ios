//
//  RequestAdditionalGithubReposUseCaseImpl.swift
//  Domain.UseCase
//
//  Created by Kensuke Tamura on 2021/05/06.
//

import Foundation
import Combine
import Domain_Model
import Domain_Repository

struct RequestAdditionalGithubReposUseCaseImpl: RequestAdditionalGithubReposUseCase {

    private let githubRepository: GithubRepository

    init(githubRepository: GithubRepository) {
        self.githubRepository = githubRepository
    }

    func invoke(githubOrgName: GithubOrgName, continueWhenError: Bool) -> AnyPublisher<Void, Never> {
        githubRepository.requestAdditionalRepos(githubOrgName: githubOrgName, continueWhenError: continueWhenError)
    }
}
