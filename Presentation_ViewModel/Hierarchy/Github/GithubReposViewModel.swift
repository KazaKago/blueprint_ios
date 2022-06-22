//
//  GithubReposViewModel.swift
//  Presentation.ViewModel
//
//  Created by Kensuke Tamura on 2021/05/05.
//

import Foundation
import Domain_UseCase
import Domain_Model

public final class GithubReposViewModel : ObservableObject {

    @Published public var uiState: GithubReposUiState
    private let getGithubReposPublisherUseCase: GetGithubReposPublisherUseCase
    private let refreshGithubReposUseCase: RefreshGithubReposUseCase
    private let requestAdditionalGithubReposUseCase: RequestAdditionalGithubReposUseCase

    public init(getGithubReposPublisherUseCase: GetGithubReposPublisherUseCase, refreshGithubReposUseCase: RefreshGithubReposUseCase, requestAdditionalGithubReposUseCase: RequestAdditionalGithubReposUseCase, githubOrgName: GithubOrgName) {
        self.getGithubReposPublisherUseCase = getGithubReposPublisherUseCase
        self.refreshGithubReposUseCase = refreshGithubReposUseCase
        self.requestAdditionalGithubReposUseCase = requestAdditionalGithubReposUseCase
        self.uiState = .loading(githubOrgName: githubOrgName)
    }

    public func refresh() {
        Task {
            await refreshGithubReposUseCase.invoke(githubOrgName: uiState.getGithubName())
        }
    }

    public func retry() {
        Task {
            await refreshGithubReposUseCase.invoke(githubOrgName: uiState.getGithubName())
        }
    }

    public func requestAddition() {
        Task {
            await requestAdditionalGithubReposUseCase.invoke(githubOrgName: uiState.getGithubName(), continueWhenError: false)
        }
    }

    public func retryAddition() {
        Task {
            await requestAdditionalGithubReposUseCase.invoke(githubOrgName: uiState.getGithubName(), continueWhenError: true)
        }
    }

    @MainActor
    public func subscribe() async {
        for await loadingState in getGithubReposPublisherUseCase.invoke(githubOrgName: uiState.getGithubName()) {
            loadingState.doAction(
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
    }
}
