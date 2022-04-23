//
//  GithubReposController.swift
//  Presentation_View
//
//  Created by Kensuke Tamura on 2022/04/24.
//

import SwiftUI
import Presentation_ViewModel
import Domain_Model

struct GithubReposController: View {

    @ObservedObject private var viewModel: GithubReposViewModel

    init(userName: GithubOrgName) {
        viewModel = resolver().resolve(GithubReposViewModel.self, argument: userName)!
    }

    var body: some View {
        GithubReposScreen(
            uiState: viewModel.uiState,
            onBottomReached: viewModel.requestAdditional,
            onRefresh: viewModel.refresh,
            onRetry: viewModel.retry,
            onRetryAdditional: viewModel.retryAdditional
        ).onAppear(perform: viewModel.initialize)
    }
}
