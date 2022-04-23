//
//  GithubOrgsController.swift
//  Presentation_View
//
//  Created by Kensuke Tamura on 2022/04/23.
//

import SwiftUI
import Presentation_ViewModel

struct GithubOrgsController: View {

    @ObservedObject private var viewModel: GithubOrgsViewModel = resolver().resolve(GithubOrgsViewModel.self)!

    var body: some View {
        GithubOrgsScreen(
            uiState: viewModel.uiState,
            onBottomReached: viewModel.requestAddition,
            onRefresh: viewModel.refresh,
            onRetry: viewModel.retry,
            onRetryAdditional: viewModel.retryAddition
        ).onAppear(perform: viewModel.initialize)
    }
}
