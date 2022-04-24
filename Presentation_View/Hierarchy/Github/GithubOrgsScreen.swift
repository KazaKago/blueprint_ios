//
//  GithubOrgsView.swift
//  Presentation.View
//
//  Created by Kensuke Tamura on 2021/04/30.
//

import SwiftUI
import Presentation_ViewModel
import Domain_Model

struct GithubOrgsScreen: View {

    let uiState: GithubOrgsUiState
    let onBottomReached: () -> Void
    let onRefresh: () -> Void
    let onRetry: () -> Void
    let onRetryAdditional: () -> Void

    init(
        uiState: GithubOrgsUiState,
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
                    ForEach(uiState.getGithubOrgsOrEmpty()) { githubOrg in
                        NavigationLink(destination: GithubReposController(userName: githubOrg.name)) {
                            GithubOrgRow(githubOrg: githubOrg)
                                .onAppear {
                                    if githubOrg == uiState.getGithubOrgsOrEmpty().last {
                                        onBottomReached()
                                    }
                                }
                        }
                    }
                    switch uiState {
                    case .additionalLoading:
                        LoadingRow()
                    case .additionalError(_, let error):
                        ErrorRow(error: error, retry: onRetryAdditional)
                    case .loading, .completed, .error:
                        EmptyView()
                    }
                }
                switch uiState {
                case .loading:
                    LoadingContent()
                case .error(let error):
                    ErrorContent(error: error, retry: onRetry)
                case .completed, .additionalLoading, .additionalError:
                    EmptyView()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: AboutController()) {
                        Text("action_about".localized)
                    }
                }
                ToolbarItem {
                    switch uiState {
                    case .loading, .additionalLoading:
                        ProgressView()
                    case .completed, .error, .additionalError:
                        Button("refresh".localized) {
                            onRefresh()
                            if let first = uiState.getGithubOrgsOrEmpty().first {
                                withAnimation {
                                    scrollProxy.scrollTo(first.id)
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("app_name".localized)
        }
    }
}

struct GithubOrgsScreenOnLoading_Preview: PreviewProvider {
    static var previews: some View {
        GithubOrgsScreen(
            uiState: .loading,
            onBottomReached: {},
            onRefresh: {},
            onRetry: {},
            onRetryAdditional: {}
        )
    }
}

struct GithubOrgsScreenOnCompleted_Preview: PreviewProvider {
    static var previews: some View {
        GithubOrgsScreen(
            uiState: .completed(githubOrgs: [
                GithubOrg(id: GithubOrgId(1), name: GithubOrgName("kazakago"), imageUrl: URL(string: "https://avatars.githubusercontent.com/u/7742104?v=4")!),
                GithubOrg(id: GithubOrgId(2), name: GithubOrgName("apple"), imageUrl: URL(string: "https://avatars.githubusercontent.com/u/7742104?v=4")!),
                GithubOrg(id: GithubOrgId(3), name: GithubOrgName("google"), imageUrl: URL(string: "https://avatars.githubusercontent.com/u/7742104?v=4")!)
            ]),
            onBottomReached: {},
            onRefresh: {},
            onRetry: {},
            onRetryAdditional: {}
        )
    }
}

struct GithubOrgsScreenOnError_Preview: PreviewProvider {
    static var previews: some View {
        GithubOrgsScreen(
            uiState: .error(error: DummyError.dummy),
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

struct GithubOrgsScreenOnAdditionalLoading_Preview: PreviewProvider {
    static var previews: some View {
        GithubOrgsScreen(
            uiState: .additionalLoading(githubOrgs: [
                GithubOrg(id: GithubOrgId(1), name: GithubOrgName("kazakago"), imageUrl: URL(string: "https://avatars.githubusercontent.com/u/7742104?v=4")!),
                GithubOrg(id: GithubOrgId(2), name: GithubOrgName("apple"), imageUrl: URL(string: "https://avatars.githubusercontent.com/u/7742104?v=4")!),
                GithubOrg(id: GithubOrgId(3), name: GithubOrgName("google"), imageUrl: URL(string: "https://avatars.githubusercontent.com/u/7742104?v=4")!)
            ]),
            onBottomReached: {},
            onRefresh: {},
            onRetry: {},
            onRetryAdditional: {}
        )
    }
}

struct GithubOrgsScreenOnAdditionalError_Preview: PreviewProvider {
    static var previews: some View {
        GithubOrgsScreen(
            uiState: .additionalError(
                githubOrgs:[
                    GithubOrg(id: GithubOrgId(1), name: GithubOrgName("kazakago"), imageUrl: URL(string: "https://avatars.githubusercontent.com/u/7742104?v=4")!),
                    GithubOrg(id: GithubOrgId(2), name: GithubOrgName("apple"), imageUrl: URL(string: "https://avatars.githubusercontent.com/u/7742104?v=4")!),
                    GithubOrg(id: GithubOrgId(3), name: GithubOrgName("google"), imageUrl: URL(string: "https://avatars.githubusercontent.com/u/7742104?v=4")!)
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
