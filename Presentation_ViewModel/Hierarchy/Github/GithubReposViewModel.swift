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

    @Published public var uiState: GithubReposUiState
    private let getGithubReposPublisherUseCase: GetGithubReposPublisherUseCase
    private let refreshGithubReposUseCase: RefreshGithubReposUseCase
    private let requestAdditionalGithubReposUseCase: RequestAdditionalGithubReposUseCase
    private var cancellableSet = Set<AnyCancellable>()

    public init(getGithubReposPublisherUseCase: GetGithubReposPublisherUseCase, refreshGithubReposUseCase: RefreshGithubReposUseCase, requestAdditionalGithubReposUseCase: RequestAdditionalGithubReposUseCase, githubOrgName: GithubOrgName) {
        self.getGithubReposPublisherUseCase = getGithubReposPublisherUseCase
        self.refreshGithubReposUseCase = refreshGithubReposUseCase
        self.requestAdditionalGithubReposUseCase = requestAdditionalGithubReposUseCase
        self.uiState = .loading(githubOrgName: githubOrgName)
    }

    public func initialize() {
        cancellableSet.removeAll()
        subscribe()
    }

    public func refresh() {
        refreshGithubReposUseCase.invoke(githubOrgName: uiState.getGithubName())
            .receive(on: DispatchQueue.main)
            .sink {}
            .store(in: &cancellableSet)
    }

    public func retry() {
        refreshGithubReposUseCase.invoke(githubOrgName: uiState.getGithubName())
            .receive(on: DispatchQueue.main)
            .sink {}
            .store(in: &cancellableSet)
    }

    public func requestAdditional() {
        requestAdditionalGithubReposUseCase.invoke(githubOrgName: uiState.getGithubName(), continueWhenError: false)
            .receive(on: DispatchQueue.main)
            .sink {}
            .store(in: &cancellableSet)
    }

    public func retryAdditional() {
        requestAdditionalGithubReposUseCase.invoke(githubOrgName: uiState.getGithubName(), continueWhenError: true)
            .receive(on: DispatchQueue.main)
            .sink {}
            .store(in: &cancellableSet)
    }

    private func subscribe() {
        getGithubReposPublisherUseCase.invoke(githubOrgName: uiState.getGithubName())
            .receive(on: DispatchQueue.main)
            .sink { state in
                state.doAction(
                    onLoading: { githubOrgAndRepos in
                        if let githubOrgAndRepos = githubOrgAndRepos {
                            self.uiState = .completed(githubOrg: githubOrgAndRepos.githubOrg, githubRepos: githubOrgAndRepos.githubRepos)
                        } else {
                            self.uiState = .loading(githubOrgName: self.uiState.getGithubName())
                        }
                    },
                    onCompleted: { githubOrgAndRepos, next, _ in
                        next.doAction(
                            onFixed: { _ in
                                self.uiState = .completed(githubOrg: githubOrgAndRepos.githubOrg, githubRepos: githubOrgAndRepos.githubRepos)
                            },
                            onLoading: {
                                self.uiState = .additionalLoading(githubOrg: githubOrgAndRepos.githubOrg, githubRepos: githubOrgAndRepos.githubRepos)
                            },
                            onError: { error in
                                self.uiState = .additionalError(githubOrg: githubOrgAndRepos.githubOrg, githubRepos: githubOrgAndRepos.githubRepos, error: error)
                            }
                        )
                    },
                    onError: { error in
                        self.uiState = .error(githubOrgName: self.uiState.getGithubName(), error: error)
                    }
                )
            }
            .store(in: &cancellableSet)
    }
}
