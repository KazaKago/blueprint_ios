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

class FollowGithubReposUseCaseImpl: FollowGithubReposUseCase {

    func invoke(githubOrgName: GithubOrgName) -> StatePublisher<[GithubRepo]> {
        Just(
            State.fixed(content: StateContent.exist(rawContent: [
                GithubRepo(id: GithubRepoId(1), name: "hoge", url: URL(string: "https://blog.kazakago.com")!),
                GithubRepo(id: GithubRepoId(2), name: "hoge", url: URL(string: "https://blog.kazakago.com")!),
                GithubRepo(id: GithubRepoId(3), name: "hoge", url: URL(string: "https://blog.kazakago.com")!),
                GithubRepo(id: GithubRepoId(4), name: "hoge", url: URL(string: "https://blog.kazakago.com")!),
                GithubRepo(id: GithubRepoId(5), name: "hoge", url: URL(string: "https://blog.kazakago.com")!),
                GithubRepo(id: GithubRepoId(5), name: "hoge", url: URL(string: "https://blog.kazakago.com")!),
                GithubRepo(id: GithubRepoId(5), name: "hoge", url: URL(string: "https://blog.kazakago.com")!),
                GithubRepo(id: GithubRepoId(5), name: "hoge", url: URL(string: "https://blog.kazakago.com")!),
                GithubRepo(id: GithubRepoId(5), name: "hoge", url: URL(string: "https://blog.kazakago.com")!),
                GithubRepo(id: GithubRepoId(5), name: "hoge", url: URL(string: "https://blog.kazakago.com")!),
                GithubRepo(id: GithubRepoId(5), name: "hoge", url: URL(string: "https://blog.kazakago.com")!),
                GithubRepo(id: GithubRepoId(5), name: "hoge", url: URL(string: "https://blog.kazakago.com")!),
                GithubRepo(id: GithubRepoId(5), name: "hoge", url: URL(string: "https://blog.kazakago.com")!),
                GithubRepo(id: GithubRepoId(5), name: "hoge", url: URL(string: "https://blog.kazakago.com")!),
                GithubRepo(id: GithubRepoId(5), name: "hoge", url: URL(string: "https://blog.kazakago.com")!),
                GithubRepo(id: GithubRepoId(5), name: "hoge", url: URL(string: "https://blog.kazakago.com")!),
            ]))
        ).eraseToAnyPublisher()
    }
}
