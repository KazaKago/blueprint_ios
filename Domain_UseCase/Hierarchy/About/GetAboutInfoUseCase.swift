//
//  GetAboutInfoUseCase.swift
//  Domain.UseCase
//
//  Created by Kensuke Tamura on 2021/05/10.
//

import Foundation
import Combine
import Domain_Model

public protocol GetAboutInfoUseCase {

    func invoke() -> AboutInfo
}
