//
//  GithubOrgsController.swift
//  Presentation_View
//
//  Created by Kensuke Tamura on 2022/04/23.
//

import SwiftUI
import Presentation_Ui
import Presentation_UiState
import Presentation_ViewModel

struct GithubOrgsController: View {

    @ObservedObject
    private var viewModel: GithubOrgsViewModel = resolver().resolve(GithubOrgsViewModel.self)!

    var body: some View {
        GithubOrgsScreen(
            uiState: viewModel.uiState,
            onBottomReached: viewModel.requestAddition,
            onRefresh: viewModel.refresh,
            onRetry: viewModel.retry,
            onRetryAdditional: viewModel.retryAddition,
            githubReposDestination: { githubOrg in GithubReposController(userName: githubOrg.name) },
            aboutDestination: { AboutController() }
        ).task { await viewModel.subscribe() }
    }
}
