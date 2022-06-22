//
//  GithubRepoTopRow.swift
//  Presentation_View
//
//  Created by Kensuke Tamura on 2022/04/24.
//

import SwiftUI
import Domain_Model

struct GithubRepoTopRow: View {

    let githubOrg: GithubOrg

    var body: some View {
        VStack(alignment: .center) {
            AsyncImage(url: githubOrg.imageUrl) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 128, height: 128)
            .cornerRadius(8)
            Spacer()
                .frame(height: 16)
            Text(String(format: "id".localized, githubOrg.id.value))
                .font(.caption)
            Spacer()
                .frame(height: 4)
            Text(githubOrg.name.value)
                .font(.title)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

struct GithubRepoTopRow_Previews: PreviewProvider {
    static var previews: some View {
        GithubRepoTopRow(githubOrg: GithubOrg(id: GithubOrgId(1223), name: GithubOrgName("Organization Name"), imageUrl: URL(string: "https://avatars.githubusercontent.com/u/7742104?v=4")!))
    }
}
