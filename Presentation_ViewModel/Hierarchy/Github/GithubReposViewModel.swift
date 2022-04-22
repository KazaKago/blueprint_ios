//
//  GithubReposViewModel.swift
//  Presentation.ViewModel
//
//  Created by Kensuke Tamura on 2021/05/05.
//

import Foundation
import Combine
import Domain_UseCase
import Domain_Model

public final class GithubReposViewModel : ObservableObject {

    @Published public var githubOrgName: GithubOrgName
    @Published public var githubRepos: [GithubRepo] = []
    @Published public var isMainLoading: Bool = false
    @Published public var isAdditionalLoading: Bool = false
    @Published public var mainError: Error?
    @Published public var additionalError: Error?
    private let followGithubReposUseCase: FollowGithubReposUseCase
    private let refreshGithubReposUseCase: RefreshGithubReposUseCase
    private let requestAdditionalGithubReposUseCase: RequestAdditionalGithubReposUseCase
    private var cancellableSet = Set<AnyCancellable>()

    public init(followGithubReposUseCase: FollowGithubReposUseCase, refreshGithubReposUseCase: RefreshGithubReposUseCase, requestAdditionalGithubReposUseCase: RequestAdditionalGithubReposUseCase, githubOrgName: GithubOrgName) {
        self.followGithubReposUseCase = followGithubReposUseCase
        self.refreshGithubReposUseCase = refreshGithubReposUseCase
        self.requestAdditionalGithubReposUseCase = requestAdditionalGithubReposUseCase
        self.githubOrgName = githubOrgName
    }

    public func initialize() {
        cancellableSet.removeAll()
        subscribe()
    }

    public func refresh() {
        refreshGithubReposUseCase.invoke(githubOrgName: githubOrgName)
            .receive(on: DispatchQueue.main)
            .sink {}
            .store(in: &cancellableSet)
    }

    public func retry() {
        refreshGithubReposUseCase.invoke(githubOrgName: githubOrgName)
            .receive(on: DispatchQueue.main)
            .sink {}
            .store(in: &cancellableSet)
    }

    public func requestAdditional() {
        requestAdditionalGithubReposUseCase.invoke(githubOrgName: githubOrgName, continueWhenError: false)
            .receive(on: DispatchQueue.main)
            .sink {}
            .store(in: &cancellableSet)
    }

    public func retryAdditional() {
        requestAdditionalGithubReposUseCase.invoke(githubOrgName: githubOrgName, continueWhenError: true)
            .receive(on: DispatchQueue.main)
            .sink {}
            .store(in: &cancellableSet)
    }

    private func subscribe() {
        followGithubReposUseCase.invoke(githubOrgName: githubOrgName)
            .receive(on: DispatchQueue.main)
            .sink { state in
                state.doAction(
                    onLoading: { githubRepos in
                        if let githubRepos = githubRepos {
                            self.githubRepos = githubRepos
                            self.isMainLoading = false
                        } else {
                            self.githubRepos = []
                            self.isMainLoading = true
                        }
                        self.isAdditionalLoading = false
                        self.mainError = nil
                        self.additionalError = nil
                    },
                    onCompleted: { githubRepos, next, _ in
                        next.doAction(
                            onFixed: { _ in
                                self.isAdditionalLoading = false
                                self.additionalError = nil
                            },
                            onLoading: {
                                self.isAdditionalLoading = true
                                self.additionalError = nil
                            },
                            onError: { error in
                                self.isAdditionalLoading = false
                                self.additionalError = error
                            }
                        )
                        self.githubRepos = githubRepos
                        self.isMainLoading = false
                        self.mainError = nil
                    },
                    onError: { error in
                        self.githubRepos = []
                        self.isMainLoading = false
                        self.isAdditionalLoading = false
                        self.mainError = error
                        self.additionalError = nil
                    }
                )
            }
            .store(in: &cancellableSet)
    }
}
