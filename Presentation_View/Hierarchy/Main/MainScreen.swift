//
//  MainScreen.swift
//  Presentation.View
//
//  Created by Kensuke Tamura on 2021/04/30.
//

import SwiftUI

public struct MainScreen: View {

    public init() {
    }

    public var body: some View {
        NavigationView {
            GithubOrgsController()
        }
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
