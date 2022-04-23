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
                            self.githubOrgs = githubOrgs
                            self.isMainLoading = false
                        } else {
                            self.githubOrgs = []
                            self.isMainLoading = true
                        }
                        self.isAdditionalLoading = false
                        self.mainError = nil
                        self.additionalError = nil
                    },
                    onCompleted: { githubOrgs, next, _ in
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
                        self.githubOrgs = githubOrgs
                        self.isMainLoading = false
                        self.mainError = nil
                    },
                    onError: { error in
                        self.githubOrgs = []
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
