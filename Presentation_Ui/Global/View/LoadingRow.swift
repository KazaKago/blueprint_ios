//
//  LoadingRow.swift
//  Example
//
//  Created by Kensuke Tamura on 2020/12/26.
//

import SwiftUI

struct LoadingRow: View {

    var body: some View {
        HStack {
            Spacer()
            ProgressView()
            Spacer()
        }
        .padding()
    }
}

struct LoadingRow_Previews: PreviewProvider {
    static var previews: some View {
        LoadingRow()
    }
}
