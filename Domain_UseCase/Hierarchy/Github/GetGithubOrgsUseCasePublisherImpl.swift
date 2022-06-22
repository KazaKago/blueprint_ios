//
//  GetGithubOrgsUseCasePublisherImpl.swift
//  Domain.UseCase
//
//  Created by Kensuke Tamura on 2021/05/06.
//

import Foundation
import StoreFlowable
import Domain_Model
import Domain_Repository

struct GetGithubOrgsPublisherUseCaseImpl: GetGithubOrgsPublisherUseCase {

    private let githubRepository: GithubRepository

    init(githubRepository: GithubRepository) {
        self.githubRepository = githubRepository
    }

    func invoke() -> LoadingStateSequence<[GithubOrg]> {
        githubRepository.getOrgsPublisher()
    }
}
