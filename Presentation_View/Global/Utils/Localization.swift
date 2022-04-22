//
//  Localization.swift
//  Presentation.View
//
//  Created by Kensuke Tamura on 2021/05/10.
//

import Foundation

extension String {

    var localized: String {
        NSLocalizedString(self, bundle: Bundle.current, comment: self)
    }
}
