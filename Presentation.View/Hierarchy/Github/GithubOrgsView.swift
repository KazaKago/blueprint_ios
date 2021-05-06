//
//  GithubOrgsView.swift
//  Presentation.View
//
//  Created by Kensuke Tamura on 2021/04/30.
//

import SwiftUI
import Presentation_ViewModel

struct GithubOrgsView: View {

    @ObservedObject private var githubOrgsViewModel: GithubOrgsViewModel = resolver().resolve(GithubOrgsViewModel.self)!

    var body: some View {
        ScrollViewReader { scrollProxy in
            ZStack {
                List {
                    ForEach(githubOrgsViewModel.githubOrgs) { githubOrg in
                        NavigationLink(destination: GithubReposView(userName: githubOrg.name)) {
                            GithubOrgItem(githubOrg: githubOrg)
                                .onAppear {
                                    if githubOrg == githubOrgsViewModel.githubOrgs.last {
                                        githubOrgsViewModel.requestAdditional()
                                    }
                                }
                        }
                    }
                    if githubOrgsViewModel.isAdditionalLoading {
                        LoadingItem()
                    }
                    if let error = githubOrgsViewModel.additionalError {
                        ErrorItem(error: error) {
                            githubOrgsViewModel.retryAdditional()
                        }
                    }
                }
                if githubOrgsViewModel.isMainLoading {
                    ProgressView()
                }
                if let error = githubOrgsViewModel.mainError {
                    VStack {
                        Text(error.localizedDescription)
                            .foregroundColor(Color.red)
                            .multilineTextAlignment(.center)
                        Spacer()
                            .frame(height: 4)
                        Button("Retry") {
                            githubOrgsViewModel.retry()
                        }
                    }
                    .padding()
                }
            }
            .toolbar {
                ToolbarItem() {
                    if githubOrgsViewModel.isMainLoading || githubOrgsViewModel.isAdditionalLoading {
                        ProgressView()
                    } else {
                        Button("Refresh") {
                            githubOrgsViewModel.refresh()
                            if let first = githubOrgsViewModel.githubOrgs.first {
                                withAnimation {
                                    scrollProxy.scrollTo(first.id)
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Blueprint")
            .onAppear {
                githubOrgsViewModel.initialize()
            }
        }
    }
}

struct GithubOrgsView_Previews: PreviewProvider {
    static var previews: some View {
        GithubOrgsView()
    }
}
