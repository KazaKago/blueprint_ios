//
//  MainView.swift
//  Presentation.View
//
//  Created by Kensuke Tamura on 2021/04/30.
//

import SwiftUI

public struct MainView: View {

    public init() {
    }

    public var body: some View {
        NavigationView {
            GithubOrgsView()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
