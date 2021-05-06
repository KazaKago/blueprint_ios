//
//  GithubReposViewModel.swift
//  Presentation.ViewModel
//
//  Created by Kensuke Tamura on 2021/05/05.
//

import Foundation
import Combine
import Domain_Model

public final class GithubReposViewModel : ObservableObject {

    @Published public var githubOrgName: GithubOrgName
    @Published public var githubRepos: [GithubRepo] = [
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
    ]
    @Published public var isMainLoading: Bool = false
    @Published public var isAdditionalLoading: Bool = false
    @Published public var mainError: Error?
    @Published public var additionalError: Error?
    private var cancellableSet = Set<AnyCancellable>()

    public init(githubOrgName: GithubOrgName) {
        self.githubOrgName = githubOrgName
    }

    public func initialize() {
        cancellableSet.removeAll()
        subscribe()
    }

    public func refresh() {
        // TODO
    }

    public func retry() {
        // TODO
    }

    public func requestAdditional() {
        // TODO
    }

    public func retryAdditional() {
        // TODO
    }

    private func subscribe() {
        // TODO
    }
}
