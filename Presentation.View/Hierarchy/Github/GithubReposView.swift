//
//  GithubReposView.swift
//  Presentation.View
//
//  Created by Kensuke Tamura on 2021/05/05.
//

import SwiftUI
import Presentation_ViewModel
import Domain_Model

struct GithubReposView: View {

    @ObservedObject private var githubReposViewModel: GithubReposViewModel

    init(userName: GithubOrgName) {
        githubReposViewModel = resolver().resolve(GithubReposViewModel.self, argument: userName)!
    }

    var body: some View {
        ScrollViewReader { scrollProxy in
            ZStack {
                List {
                    ForEach(githubReposViewModel.githubRepos) { githubRepo in
                        GithubRepoItem(githubRepo: githubRepo)
                            .onAppear {
                                if githubRepo == githubReposViewModel.githubRepos.last {
                                    githubReposViewModel.requestAdditional()
                                }
                            }
                    }
                    if githubReposViewModel.isAdditionalLoading {
                        LoadingItem()
                    }
                    if let error = githubReposViewModel.additionalError {
                        ErrorItem(error: error) {
                            githubReposViewModel.retryAdditional()
                        }
                    }
                }
                if githubReposViewModel.isMainLoading {
                    ProgressView()
                }
                if let error = githubReposViewModel.mainError {
                    VStack {
                        Text(error.localizedDescription)
                            .foregroundColor(Color.red)
                            .multilineTextAlignment(.center)
                        Spacer()
                            .frame(height: 4)
                        Button("Retry") {
                            githubReposViewModel.retry()
                        }
                    }
                    .padding()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if githubReposViewModel.isMainLoading || githubReposViewModel.isAdditionalLoading {
                        ProgressView()
                    } else {
                        Button("Refresh") {
                            githubReposViewModel.refresh()
                            if let first = githubReposViewModel.githubRepos.first {
                                withAnimation { scrollProxy.scrollTo(first.id) }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(githubReposViewModel.githubOrgName.value)
            .onAppear {
                githubReposViewModel.initialize()
            }
        }
    }
}

struct GithubReposView_Previews: PreviewProvider {
    static var previews: some View {
        GithubReposView(userName: GithubOrgName("github"))
    }
}
