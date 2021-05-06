//
//  GithubOrgsViewModel.swift
//  Presentation.ViewModel
//
//  Created by Kensuke Tamura on 2021/04/30.
//

import Foundation
import Combine
import Domain_Model

public final class GithubOrgsViewModel: ObservableObject {

    @Published public var githubOrgs: [GithubOrg] = [
        GithubOrg(id: GithubOrgId(1), name: GithubOrgName("hoge")),
        GithubOrg(id: GithubOrgId(2), name: GithubOrgName("hoge")),
        GithubOrg(id: GithubOrgId(3), name: GithubOrgName("hoge")),
        GithubOrg(id: GithubOrgId(4), name: GithubOrgName("hoge")),
        GithubOrg(id: GithubOrgId(5), name: GithubOrgName("hoge")),
        GithubOrg(id: GithubOrgId(5), name: GithubOrgName("hoge")),
        GithubOrg(id: GithubOrgId(5), name: GithubOrgName("hoge")),
        GithubOrg(id: GithubOrgId(5), name: GithubOrgName("hoge")),
        GithubOrg(id: GithubOrgId(5), name: GithubOrgName("hoge")),
        GithubOrg(id: GithubOrgId(5), name: GithubOrgName("hoge")),
        GithubOrg(id: GithubOrgId(5), name: GithubOrgName("hoge")),
        GithubOrg(id: GithubOrgId(5), name: GithubOrgName("hoge")),
        GithubOrg(id: GithubOrgId(5), name: GithubOrgName("hoge")),
        GithubOrg(id: GithubOrgId(5), name: GithubOrgName("hoge")),
        GithubOrg(id: GithubOrgId(5), name: GithubOrgName("hoge")),
        GithubOrg(id: GithubOrgId(5), name: GithubOrgName("hoge")),
    ]
    @Published public var isMainLoading: Bool = false
    @Published public var isAdditionalLoading: Bool = false
    @Published public var mainError: Error?
    @Published public var additionalError: Error?
    private var cancellableSet = Set<AnyCancellable>()

    public init() {
        cancellableSet.removeAll()
        subscribe()
    }

    public func initialize() {
        // TODO
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
