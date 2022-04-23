//
//  ErrorContent.swift
//  Presentation_View
//
//  Created by Kensuke Tamura on 2022/04/23.
//

import SwiftUI

struct ErrorContent: View {

    let error: Error
    let retry: () -> Void

    var body: some View {
        VStack {
            Text(error.localizedDescription)
                .foregroundColor(Color.red)
                .multilineTextAlignment(.center)
            Spacer()
                .frame(height: 4)
            Button("retry".localized) {
                retry()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

struct ErrorContent_Previews: PreviewProvider {
    static var previews: some View {
        ErrorContent(error: DummyError.dummy, retry: {})
    }

    private enum DummyError: Error {
        case dummy
    }
}
