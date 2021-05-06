//
//  GithubRepoItem.swift
//  Presentation.View
//
//  Created by Kensuke Tamura on 2021/05/05.
//

import SwiftUI
import Domain_Model

struct GithubRepoItem: View {

    let githubRepo: GithubRepo

    var body: some View {
        VStack(alignment: .leading) {
            Text("ID: \(githubRepo.id.value)")
                .font(.caption)
            Spacer()
                .frame(height: 4)
            Text(githubRepo.name)
                .font(.body)
            Spacer()
                .frame(height: 4)
            Link(githubRepo.url.absoluteString, destination: githubRepo.url)
                .foregroundColor(Color.blue)
        }
        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
    }
}

struct GithubRepoItem_Previews: PreviewProvider {
    static var previews: some View {
        GithubRepoItem(githubRepo: GithubRepo(id: GithubRepoId(1223), name: "User Name", url: URL(string: "http://example.com")!))
    }
}
