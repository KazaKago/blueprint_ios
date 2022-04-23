//
//  GithubOrgsViewModel.swift
//  Presentation.ViewModel
//
//  Created by Kensuke Tamura on 2021/04/30.
//

import Foundation
import Combine
import Domain_UseCase
import Domain_Model

public final class GithubOrgsViewModel: ObservableObject {

    @Published public var uiState: GithubOrgsUiState = .loading
    private let getGithubOrgsPublisherUseCase: GetGithubOrgsPublisherUseCase
    private let refreshGithubOrgsUseCase: RefreshGithubOrgsUseCase
    private let requestAdditionalGithubOrgsUseCase: RequestAdditionalGithubOrgsUseCase
    private var cancellableSet = Set<AnyCancellable>()

    public init(getGithubOrgsPublisherUseCase: GetGithubOrgsPublisherUseCase, refreshGithubOrgsUseCase: RefreshGithubOrgsUseCase, requestAdditionalGithubOrgsUseCase: RequestAdditionalGithubOrgsUseCase) {
        self.getGithubOrgsPublisherUseCase = getGithubOrgsPublisherUseCase
        self.refreshGithubOrgsUseCase = refreshGithubOrgsUseCase
        self.requestAdditionalGithubOrgsUseCase = requestAdditionalGithubOrgsUseCase
    }

    public func initialize() {
        cancellableSet.removeAll()
        subscribe()
    }

    public func refresh() {
        refreshGithubOrgsUseCase.invoke()
            .receive(on: DispatchQueue.main)
            .sink {}
            .store(in: &cancellableSet)
    }

    public func retry() {
        refreshGithubOrgsUseCase.invoke()
            .receive(on: DispatchQueue.main)
            .sink {}
            .store(in: &cancellableSet)
    }

    public func requestAdditional() {
        requestAdditionalGithubOrgsUseCase.invoke(continueWhenError: false)
            .receive(on: DispatchQueue.main)
            .sink {}
            .store(in: &cancellableSet)
    }

    public func retryAdditional() {
        requestAdditionalGithubOrgsUseCase.invoke(continueWhenError: true)
            .receive(on: DispatchQueue.main)
            .sink {}
            .store(in: &cancellableSet)
    }

    private func subscribe() {
        getGithubOrgsPublisherUseCase.invoke()
            .receive(on: DispatchQueue.main)
            .sink { state in
                state.doAction(
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
            .store(in: &cancellableSet)
    }
}
