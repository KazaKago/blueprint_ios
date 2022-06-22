//
//  MainController.swift
//  Presentation_Controller
//
//  Created by Kensuke Tamura on 2022/06/22.
//

import SwiftUI
import Presentation_Ui
import Presentation_UiState

public struct MainController: View {

    public init() {
    }

    public var body: some View {
        MainScreen(
            githubOrgsDestination: { GithubOrgsController() }
        )
    }
}
