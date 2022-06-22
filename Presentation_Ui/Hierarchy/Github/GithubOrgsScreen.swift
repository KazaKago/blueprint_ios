//
//  GithubOrgsView.swift
//  Presentation.View
//
//  Created by Kensuke Tamura on 2021/04/30.
//

import SwiftUI
import Presentation_UiState
import Domain_Model

public struct GithubOrgsScreen<GithubRepoDestination: View, AboutDestination: View>: View {

    let uiState: GithubOrgsUiState
    let onBottomReached: () -> Void
    let onRefresh: () -> Void
    let onRetry: () -> Void
    let onRetryAdditional: () -> Void
    let githubReposDestination: (_ githubOrg: GithubOrg) -> GithubRepoDestination
    let aboutDestination: () -> AboutDestination

    public init(
        uiState: GithubOrgsUiState,
        onBottomReached: @escaping () -> Void,
        onRefresh: @escaping () -> Void,
        onRetry: @escaping () -> Void,
        onRetryAdditional: @escaping () -> Void,
        githubReposDestination: @escaping (_ githubOrg: GithubOrg) -> GithubRepoDestination,
        aboutDestination: @escaping () -> AboutDestination
    ) {
        self.uiState = uiState
        self.onBottomReached = onBottomReached
        self.onRefresh = onRefresh
        self.onRetry = onRetry
        self.onRetryAdditional = onRetryAdditional
        self.githubReposDestination = githubReposDestination
        self.aboutDestination = aboutDestination
    }

    public var body: some View {
        ScrollViewReader { scrollProxy in
            ZStack {
                List {
                    ForEach(uiState.getGithubOrgsOrEmpty()) { githubOrg in
                        NavigationLink(destination: githubReposDestination(githubOrg)) {
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
                }.refreshable { onRefresh() }
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
                ToolbarItem {
                    NavigationLink(destination: aboutDestination()) {
                        Text("action_about".localized)
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
            onRetryAdditional: {},
            githubReposDestination: { _ in Spacer() },
            aboutDestination: { Spacer() }
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
            onRetryAdditional: {},
            githubReposDestination: { _ in Spacer() },
            aboutDestination: { Spacer() }
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
            onRetryAdditional: {},
            githubReposDestination: { _ in Spacer() },
            aboutDestination: { Spacer() }
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
            onRetryAdditional: {},
            githubReposDestination: { _ in Spacer() },
            aboutDestination: { Spacer() }
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
            onRetryAdditional: {},
            githubReposDestination: { _ in Spacer() },
            aboutDestination: { Spacer() }
        )
    }

    private enum DummyError: Error {
        case dummy
    }
}
