//
//  MainScreen.swift
//  Presentation.View
//
//  Created by Kensuke Tamura on 2021/04/30.
//

import SwiftUI

public struct MainScreen<GithubOrgsDestination : View>: View {

    let githubOrgsDestination: () -> GithubOrgsDestination

    public init(githubOrgsDestination: @escaping () -> GithubOrgsDestination) {
        self.githubOrgsDestination = githubOrgsDestination
    }

    public var body: some View {
        NavigationView {
            githubOrgsDestination()
        }
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen(
            githubOrgsDestination: { Spacer() }
        )
    }
}
