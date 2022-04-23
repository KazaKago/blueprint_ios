//
//  AboutController.swift
//  Presentation_View
//
//  Created by Kensuke Tamura on 2022/04/23.
//

import SwiftUI
import Presentation_ViewModel

struct AboutController: View {

    @ObservedObject private var viewModel: AboutViewModel = resolver().resolve(AboutViewModel.self)!

    var body: some View {
        AboutScreen(
            uiState: viewModel.uiState,
            onClickWebSite: { url in UIApplication.shared.open(url) },
            onClickMail: { email in UIApplication.shared.open(email.toURL()) }
        ).onAppear(perform: viewModel.initialize)
    }
}
