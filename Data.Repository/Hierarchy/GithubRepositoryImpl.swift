//
//  GithubRepositoryImpl.swift
//  Data.Repository
//
//  Created by Kensuke Tamura on 2021/05/06.
//

import Foundation
import Combine
import StoreFlowable
import Domain_Model
import Domain_Repository

struct GithubRepositoryImpl: GithubRepository {

    func followOrgs() -> StatePublisher<[GithubOrg]> {
        Just(
            State.fixed(content: StateContent.exist(rawContent: [
                GithubOrg(id: GithubOrgId(1), name: GithubOrgName("hoge")),
                GithubOrg(id: GithubOrgId(2), name: GithubOrgName("hoge")),
                GithubOrg(id: GithubOrgId(3), name: GithubOrgName("hoge")),
                GithubOrg(id: GithubOrgId(4), name: GithubOrgName("hoge")),
                GithubOrg(id: GithubOrgId(5), name: GithubOrgName("hoge")),
                GithubOrg(id: GithubOrgId(6), name: GithubOrgName("hoge")),
                GithubOrg(id: GithubOrgId(7), name: GithubOrgName("hoge")),
                GithubOrg(id: GithubOrgId(8), name: GithubOrgName("hoge")),
                GithubOrg(id: GithubOrgId(9), name: GithubOrgName("hoge")),
                GithubOrg(id: GithubOrgId(10), name: GithubOrgName("hoge")),
                GithubOrg(id: GithubOrgId(11), name: GithubOrgName("hoge")),
                GithubOrg(id: GithubOrgId(12), name: GithubOrgName("hoge")),
                GithubOrg(id: GithubOrgId(13), name: GithubOrgName("hoge")),
                GithubOrg(id: GithubOrgId(14), name: GithubOrgName("hoge")),
                GithubOrg(id: GithubOrgId(15), name: GithubOrgName("hoge")),
                GithubOrg(id: GithubOrgId(16), name: GithubOrgName("hoge")),
            ]))
        ).eraseToAnyPublisher()
    }

    func refreshOrgs() -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }

    func requestAdditionalOrgs(continueWhenError: Bool) -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }

    func followRepos(githubOrgName: GithubOrgName) -> StatePublisher<[GithubRepo]> {
        Just(
            State.fixed(content: StateContent.exist(rawContent: [
                GithubRepo(id: GithubRepoId(1), name: "hoge", url: URL(string: "https://blog.kazakago.com")!),
                GithubRepo(id: GithubRepoId(2), name: "hoge", url: URL(string: "https://blog.kazakago.com")!),
                GithubRepo(id: GithubRepoId(3), name: "hoge", url: URL(string: "https://blog.kazakago.com")!),
                GithubRepo(id: GithubRepoId(4), name: "hoge", url: URL(string: "https://blog.kazakago.com")!),
                GithubRepo(id: GithubRepoId(5), name: "hoge", url: URL(string: "https://blog.kazakago.com")!),
                GithubRepo(id: GithubRepoId(6), name: "hoge", url: URL(string: "https://blog.kazakago.com")!),
                GithubRepo(id: GithubRepoId(7), name: "hoge", url: URL(string: "https://blog.kazakago.com")!),
                GithubRepo(id: GithubRepoId(8), name: "hoge", url: URL(string: "https://blog.kazakago.com")!),
                GithubRepo(id: GithubRepoId(9), name: "hoge", url: URL(string: "https://blog.kazakago.com")!),
                GithubRepo(id: GithubRepoId(10), name: "hoge", url: URL(string: "https://blog.kazakago.com")!),
                GithubRepo(id: GithubRepoId(11), name: "hoge", url: URL(string: "https://blog.kazakago.com")!),
                GithubRepo(id: GithubRepoId(12), name: "hoge", url: URL(string: "https://blog.kazakago.com")!),
                GithubRepo(id: GithubRepoId(13), name: "hoge", url: URL(string: "https://blog.kazakago.com")!),
                GithubRepo(id: GithubRepoId(14), name: "hoge", url: URL(string: "https://blog.kazakago.com")!),
                GithubRepo(id: GithubRepoId(15), name: "hoge", url: URL(string: "https://blog.kazakago.com")!),
                GithubRepo(id: GithubRepoId(16), name: "hoge", url: URL(string: "https://blog.kazakago.com")!),
            ]))
        ).eraseToAnyPublisher()
    }

    func refreshRepos(githubOrgName: GithubOrgName) -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }

    func requestAdditionalRepos(githubOrgName: GithubOrgName, continueWhenError: Bool) -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }
}
