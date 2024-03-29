//
//  GithubOrgRow.swift
//  Example
//
//  Created by Kensuke Tamura on 2020/12/26.
//

import SwiftUI
import Domain_Model

struct GithubOrgRow: View {

    let githubOrg: GithubOrg

    var body: some View {
        HStack {
            AsyncImage(url: githubOrg.imageUrl) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 40, height: 40)
            .cornerRadius(4)
            Spacer()
                .frame(width: 16)
            VStack(alignment: .leading) {
                Text(String(format: "id".localized, githubOrg.id.value))
                    .font(.caption)
                Spacer()
                    .frame(height: 4)
                Text(githubOrg.name.value)
                    .font(.body)
            }
        }
        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
    }
}

struct GithubOrgRow_Previews: PreviewProvider {
    static var previews: some View {
        GithubOrgRow(githubOrg: GithubOrg(id: GithubOrgId(1223), name: GithubOrgName("Organization Name"), imageUrl: URL(string: "https://avatars.githubusercontent.com/u/7742104?v=4")!))
    }
}
