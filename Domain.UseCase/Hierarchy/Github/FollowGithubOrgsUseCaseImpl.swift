//
//  FollowGithubOrgsUseCaseImpl.swift
//  Domain.UseCase
//
//  Created by Kensuke Tamura on 2021/05/06.
//

import Foundation
import Combine
import StoreFlowable
import Domain_Model

class FollowGithubOrgsUseCaseImpl: FollowGithubOrgsUseCase {

    func invoke() -> StatePublisher<[GithubOrg]> {
        Just(
            State.fixed(content: StateContent.exist(rawContent: [
                GithubOrg(id: GithubOrgId(2), name: GithubOrgName("hoge")),
                GithubOrg(id: GithubOrgId(3), name: GithubOrgName("hoge")),
                GithubOrg(id: GithubOrgId(4), name: GithubOrgName("hoge")),
                GithubOrg(id: GithubOrgId(5), name: GithubOrgName("hoge")),
                GithubOrg(id: GithubOrgId(5), name: GithubOrgName("hoge")),
                GithubOrg(id: GithubOrgId(5), name: GithubOrgName("hoge")),
                GithubOrg(id: GithubOrgId(5), name: GithubOrgName("hoge")),
                GithubOrg(id: GithubOrgId(5), name: GithubOrgName("hoge")),
                GithubOrg(id: GithubOrgId(5), name: GithubOrgName("hoge")),
                GithubOrg(id: GithubOrgId(5), name: GithubOrgName("hoge")),
                GithubOrg(id: GithubOrgId(5), name: GithubOrgName("hoge")),
                GithubOrg(id: GithubOrgId(5), name: GithubOrgName("hoge")),
                GithubOrg(id: GithubOrgId(5), name: GithubOrgName("hoge")),
                GithubOrg(id: GithubOrgId(5), name: GithubOrgName("hoge")),
                GithubOrg(id: GithubOrgId(5), name: GithubOrgName("hoge")),
            ]))
        ).eraseToAnyPublisher()
    }
}
