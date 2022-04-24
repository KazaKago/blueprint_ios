//
//  ErrorRow.swift
//  Example
//
//  Created by Kensuke Tamura on 2020/12/26.
//

import SwiftUI

struct ErrorRow: View {

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
        .padding()
    }
}

struct ErrorItem_Previews: PreviewProvider {
    static var previews: some View {
        ErrorRow(error: DummyError.dummy, retry: {})
    }

    private enum DummyError: Error {
        case dummy
    }
}
