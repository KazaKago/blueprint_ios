//
//  GithubReposUiState.swift
//  Presentation_ViewModel
//
//  Created by Kensuke Tamura on 2022/04/24.
//

import Foundation
import Domain_Model

public enum GithubReposUiState {
    case loading(
        githubOrgName: GithubOrgName
    )
    case completed(
        githubOrg: GithubOrg,
        githubRepos: [GithubRepo]
    )
    case error(
        githubOrgName: GithubOrgName,
        error: Error
    )
    case additionalLoading(
        githubOrg: GithubOrg,
        githubRepos: [GithubRepo]
    )
    case additionalError(
        githubOrg: GithubOrg,
        githubRepos: [GithubRepo],
        error: Error
    )

    public func getGithubName() -> GithubOrgName {
        switch (self) {
        case .loading(let githubOrgName):
            return githubOrgName
        case .completed(let githubOrg, _):
            return githubOrg.name
        case .error(let githubOrgName, _):
            return githubOrgName
        case .additionalLoading(let githubOrg, _):
            return githubOrg.name
        case .additionalError(let githubOrg, _, _):
            return githubOrg.name
        }
    }

    public func getGithubReposOrEmpty() -> [GithubRepo] {
        switch (self) {
        case .additionalError(_, let githubRepos, _):
            return githubRepos
        case .additionalLoading(_, let githubRepos):
            return githubRepos
        case .completed(_, let githubRepos):
            return githubRepos
        case .error:
            return []
        case .loading:
            return []
        }
    }
}
