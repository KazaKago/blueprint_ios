//
//  LoadingContent.swift
//  Presentation_View
//
//  Created by Kensuke Tamura on 2022/04/23.
//

import SwiftUI

struct LoadingContent: View {

    var body: some View {
        HStack {
            Spacer()
            ProgressView()
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

struct LoadingContent_Previews: PreviewProvider {
    static var previews: some View {
        LoadingContent()
    }
}
