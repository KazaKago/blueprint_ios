//
//  GithubReposScreen.swift
//  Presentation.View
//
//  Created by Kensuke Tamura on 2021/05/05.
//

import SwiftUI
import Presentation_ViewModel
import Domain_Model

struct GithubReposScreen: View {

    let uiState: GithubReposUiState
    let onBottomReached: () -> Void
    let onRefresh: () -> Void
    let onRetry: () -> Void
    let onRetryAdditional: () -> Void

    init(
        uiState: GithubReposUiState,
        onBottomReached: @escaping () -> Void,
        onRefresh: @escaping () -> Void,
        onRetry: @escaping () -> Void,
        onRetryAdditional: @escaping () -> Void
    ) {
        self.uiState = uiState
        self.onBottomReached = onBottomReached
        self.onRefresh = onRefresh
        self.onRetry = onRetry
        self.onRetryAdditional = onRetryAdditional
    }

    var body: some View {
        ScrollViewReader { scrollProxy in
            ZStack {
                List {
                    ForEach(uiState.getGithubReposOrEmpty()) { githubRepo in
                        GithubRepoItem(githubRepo: githubRepo)
                            .onAppear {
                                if githubRepo == uiState.getGithubReposOrEmpty().last {
                                    onBottomReached()
                                }
                            }
                    }
                    switch uiState {
                    case .additionalLoading:
                        LoadingItem()
                    case .additionalError(_, _, let error):
                        ErrorItem(error: error, retry: onRetryAdditional)
                    case .loading, .completed, .error:
                        EmptyView()
                    }
                }
                switch uiState {
                case .loading:
                    LoadingContent()
                case .error(_, let error):
                    ErrorContent(error: error, retry: onRetry)
                case .completed, .additionalLoading, .additionalError:
                    EmptyView()
                }
            }
            .toolbar {
                ToolbarItem {
                    switch uiState {
                    case .loading, .additionalLoading:
                        ProgressView()
                    case .completed, .error, .additionalError:
                        Button("refresh".localized) {
                            onRefresh()
                            if let first = uiState.getGithubReposOrEmpty().first {
                                withAnimation { scrollProxy.scrollTo(first.id) }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(uiState.getGithubName().value)
        }
    }
}

struct GithubReposScreenOnLoading_Preview: PreviewProvider {
    static var previews: some View {
        GithubReposScreen(
            uiState: .loading(
                githubOrgName: GithubOrgName("KazaKago")
            ),
            onBottomReached: {},
            onRefresh: {},
            onRetry: {},
            onRetryAdditional: {}
        )
    }
}

struct GithubReposScreenOnCompleted_Preview: PreviewProvider {
    static var previews: some View {
        GithubReposScreen(
            uiState: .completed(
                githubOrg: GithubOrg(id: GithubOrgId(1), name: GithubOrgName("kazakago"), imageUrl: URL(string: "https://avatars.githubusercontent.com/u/7742104?v=4")!),
                githubRepos: [
                    GithubRepo(id: GithubRepoId(1), name: "cueue_server", url: URL(string: "https://github.com/KazaKago/cueue_server")!),
                    GithubRepo(id: GithubRepoId(2), name: "cueue_flutter", url: URL(string: "https://github.com/KazaKago/cueue_flutter")!),
                    GithubRepo(id: GithubRepoId(3), name: "cueue_page", url: URL(string: "https://github.com/KazaKago/cueue_page")!)
                ]
            ),
            onBottomReached: {},
            onRefresh: {},
            onRetry: {},
            onRetryAdditional: {}
        )
    }
}

struct GithubReposScreenOnError_Preview: PreviewProvider {
    static var previews: some View {
        GithubReposScreen(
            uiState: .error(
                githubOrgName: GithubOrgName("KazaKago"),
                error: DummyError.dummy
            ),
            onBottomReached: {},
            onRefresh: {},
            onRetry: {},
            onRetryAdditional: {}
        )
    }

    private enum DummyError: Error {
        case dummy
    }
}

struct GithubReposScreenOnAdditionalLoading_Preview: PreviewProvider {
    static var previews: some View {
        GithubReposScreen(
            uiState: .additionalLoading(
                githubOrg: GithubOrg(id: GithubOrgId(1), name: GithubOrgName("kazakago"), imageUrl: URL(string: "https://avatars.githubusercontent.com/u/7742104?v=4")!),
                githubRepos: [
                    GithubRepo(id: GithubRepoId(1), name: "cueue_server", url: URL(string: "https://github.com/KazaKago/cueue_server")!),
                    GithubRepo(id: GithubRepoId(2), name: "cueue_flutter", url: URL(string: "https://github.com/KazaKago/cueue_flutter")!),
                    GithubRepo(id: GithubRepoId(3), name: "cueue_page", url: URL(string: "https://github.com/KazaKago/cueue_page")!)
                ]
            ),
            onBottomReached: {},
            onRefresh: {},
            onRetry: {},
            onRetryAdditional: {}
        )
    }
}

struct GithubReposScreenOnAdditionalError_Preview: PreviewProvider {
    static var previews: some View {
        GithubReposScreen(
            uiState: .additionalError(
                githubOrg: GithubOrg(id: GithubOrgId(1), name: GithubOrgName("kazakago"), imageUrl: URL(string: "https://avatars.githubusercontent.com/u/7742104?v=4")!),
                githubRepos: [
                    GithubRepo(id: GithubRepoId(1), name: "cueue_server", url: URL(string: "https://github.com/KazaKago/cueue_server")!),
                    GithubRepo(id: GithubRepoId(2), name: "cueue_flutter", url: URL(string: "https://github.com/KazaKago/cueue_flutter")!),
                    GithubRepo(id: GithubRepoId(3), name: "cueue_page", url: URL(string: "https://github.com/KazaKago/cueue_page")!)
                ],
                error: DummyError.dummy
            ),
            onBottomReached: {},
            onRefresh: {},
            onRetry: {},
            onRetryAdditional: {}
        )
    }

    private enum DummyError: Error {
        case dummy
    }
}
