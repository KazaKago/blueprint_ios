//
//  BlueprintApp.swift
//  Blueprint
//
//  Created by Kensuke Tamura on 2021/04/25.
//

import SwiftUI
import Presentation_Controller

@main
struct BlueprintApp: App {

    init() {
        resolver = { container }
    }

    var body: some Scene {
        WindowGroup {
            MainController()
        }
    }
}
