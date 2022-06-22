//
//  GithubOrgsViewModel.swift
//  Presentation.ViewModel
//
//  Created by Kensuke Tamura on 2021/04/30.
//

import Foundation
import Domain_UseCase
import Domain_Model

public final class GithubOrgsViewModel: ObservableObject {

    @Published public var uiState: GithubOrgsUiState = .loading
    private let getGithubOrgsPublisherUseCase: GetGithubOrgsPublisherUseCase
    private let refreshGithubOrgsUseCase: RefreshGithubOrgsUseCase
    private let requestAdditionalGithubOrgsUseCase: RequestAdditionalGithubOrgsUseCase

    public init(getGithubOrgsPublisherUseCase: GetGithubOrgsPublisherUseCase, refreshGithubOrgsUseCase: RefreshGithubOrgsUseCase, requestAdditionalGithubOrgsUseCase: RequestAdditionalGithubOrgsUseCase) {
        self.getGithubOrgsPublisherUseCase = getGithubOrgsPublisherUseCase
        self.refreshGithubOrgsUseCase = refreshGithubOrgsUseCase
        self.requestAdditionalGithubOrgsUseCase = requestAdditionalGithubOrgsUseCase
    }

    public func refresh() {
        Task {
            await refreshGithubOrgsUseCase.invoke()
        }
    }

    public func retry() {
        Task {
            await refreshGithubOrgsUseCase.invoke()
        }
    }

    public func requestAddition() {
        Task {
            await requestAdditionalGithubOrgsUseCase.invoke(continueWhenError: false)
        }
    }

    public func retryAddition() {
        Task {
            await requestAdditionalGithubOrgsUseCase.invoke(continueWhenError: true)
        }
    }

    @MainActor
    public func subscribe() async {
        for await loadingState in getGithubOrgsPublisherUseCase.invoke() {
            loadingState.doAction(
                onLoading: { githubOrgs in
                    if let githubOrgs = githubOrgs {
                        self.uiState = .completed(githubOrgs: githubOrgs)
                    } else {
                        self.uiState = .loading
                    }
                },
                onCompleted: { githubOrgs, next, _ in
                    next.doAction(
                        onFixed: { _ in
                            self.uiState = .completed(githubOrgs: githubOrgs)
                        },
                        onLoading: {
                            self.uiState = .additionalLoading(githubOrgs: githubOrgs)
                        },
                        onError: { error in
                            self.uiState = .additionalError(githubOrgs: githubOrgs, error: error)
                        }
                    )
                },
                onError: { error in
                    self.uiState = .error(error: error)
                }
            )
        }
    }
}
