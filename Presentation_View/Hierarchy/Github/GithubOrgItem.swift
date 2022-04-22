//
//  GithubOrgItem.swift
//  Example
//
//  Created by Kensuke Tamura on 2020/12/26.
//

import SwiftUI
import Domain_Model

struct GithubOrgItem: View {

    let githubOrg: GithubOrg

    var body: some View {
        VStack(alignment: .leading) {
            Text(String(format: "id".localized, githubOrg.id.value))
                .font(.caption)
            Spacer()
                .frame(height: 4)
            Text(githubOrg.name.value)
                .font(.body)
        }
        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
    }
}

struct GithubOrgItem_Previews: PreviewProvider {
    static var previews: some View {
        GithubOrgItem(githubOrg: GithubOrg(id: GithubOrgId(1223), name: GithubOrgName("Organization Name")))
    }
}
