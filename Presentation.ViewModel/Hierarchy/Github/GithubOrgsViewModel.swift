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

    @Published public var githubOrgs: [GithubOrg] = []
    @Published public var isMainLoading: Bool = false
    @Published public var isAdditionalLoading: Bool = false
    @Published public var mainError: Error?
    @Published public var additionalError: Error?
    private let followGithubOrgsUseCase: FollowGithubOrgsUseCase
    private let refreshGithubOrgsUseCase: RefreshGithubOrgsUseCase
    private let requestAdditionalGithubOrgsUseCase: RequestAdditionalGithubOrgsUseCase
    private var cancellableSet = Set<AnyCancellable>()

    public init(followGithubOrgsUseCase: FollowGithubOrgsUseCase, refreshGithubOrgsUseCase: RefreshGithubOrgsUseCase, requestAdditionalGithubOrgsUseCase: RequestAdditionalGithubOrgsUseCase) {
        self.followGithubOrgsUseCase = followGithubOrgsUseCase
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
        followGithubOrgsUseCase.invoke()
            .receive(on: DispatchQueue.main)
            .sink { state in
                state.doAction(
                    onFixed: {
                        state.content.doAction(
                            onExist: { value in
                                self.githubOrgs = value
                                self.isMainLoading = false
                                self.isAdditionalLoading = false
                                self.mainError = nil
                                self.additionalError = nil
                            },
                            onNotExist: {
                                self.githubOrgs = []
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
                                self.githubOrgs = value
                                self.isMainLoading = false
                                self.isAdditionalLoading = true
                                self.mainError = nil
                                self.additionalError = nil
                            },
                            onNotExist: {
                                self.githubOrgs = []
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
                                self.githubOrgs = value
                                self.isMainLoading = false
                                self.isAdditionalLoading = false
                                self.mainError = nil
                                self.additionalError = error
                            },
                            onNotExist: {
                                self.githubOrgs = []
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
