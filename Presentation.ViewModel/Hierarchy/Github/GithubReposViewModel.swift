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
        refreshGithubReposUseCase.invoke()
            .receive(on: DispatchQueue.main)
            .sink {}
            .store(in: &cancellableSet)
    }

    public func retry() {
        refreshGithubReposUseCase.invoke()
            .receive(on: DispatchQueue.main)
            .sink {}
            .store(in: &cancellableSet)
    }

    public func requestAdditional() {
        requestAdditionalGithubReposUseCase.invoke(continueWhenError: false)
            .receive(on: DispatchQueue.main)
            .sink {}
            .store(in: &cancellableSet)
    }

    public func retryAdditional() {
        requestAdditionalGithubReposUseCase.invoke(continueWhenError: true)
            .receive(on: DispatchQueue.main)
            .sink {}
            .store(in: &cancellableSet)
    }

    private func subscribe() {
        followGithubReposUseCase.invoke(githubOrgName: githubOrgName)
            .receive(on: DispatchQueue.main)
            .sink { state in
                state.doAction(
                    onFixed: {
                        state.content.doAction(
                            onExist: { value in
                                self.githubRepos = value
                                self.isMainLoading = false
                                self.isAdditionalLoading = false
                                self.mainError = nil
                                self.additionalError = nil
                            },
                            onNotExist: {
                                self.githubRepos = []
                                self.isMainLoading = true
                                self.isAdditionalLoading = false
                                self.mainError = nil
                                self.additionalError = nil
                            }
                        )
                    },
                    onLoading: {
                        state.content.doAction(
                            onExist: { value in
                                self.githubRepos = value
                                self.isMainLoading = false
                                self.isAdditionalLoading = true
                                self.mainError = nil
                                self.additionalError = nil
                            },
                            onNotExist: {
                                self.githubRepos = []
                                self.isMainLoading = true
                                self.isAdditionalLoading = false
                                self.mainError = nil
                                self.additionalError = nil
                            }
                        )
                    },
                    onError: { error in
                        state.content.doAction(
                            onExist: { value in
                                self.githubRepos = value
                                self.isMainLoading = false
                                self.isAdditionalLoading = false
                                self.mainError = nil
                                self.additionalError = error
                            },
                            onNotExist: {
                                self.githubRepos = []
                                self.isMainLoading = false
                                self.isAdditionalLoading = false
                                self.mainError = error
                                self.additionalError = nil
                            }
                        )
                    }
                )
            }
            .store(in: &cancellableSet)
    }
}
