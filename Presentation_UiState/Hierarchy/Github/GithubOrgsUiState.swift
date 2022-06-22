//
//  GithubOrgsUiState.swift
//  Presentation_ViewModel
//
//  Created by Kensuke Tamura on 2022/04/23.
//

import Foundation
import Domain_Model

public enum GithubOrgsUiState {
    case loading
    case completed(
        githubOrgs: [GithubOrg]
    )
    case error(
        error: Error
    )
    case additionalLoading(
        githubOrgs: [GithubOrg]
    )
    case additionalError(
        githubOrgs: [GithubOrg],
        error: Error
    )

    public func getGithubOrgsOrEmpty() -> [GithubOrg] {
        switch (self) {
        case .additionalError(let githubOrgs, _):
            return githubOrgs
        case .additionalLoading(let githubOrgs):
            return githubOrgs
        case .completed(let githubOrgs):
            return githubOrgs
        case .error:
            return []
        case .loading:
            return []
        }
    }
}
