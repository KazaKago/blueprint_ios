//
//  RequestAdditionalGithubOrgsUseCase.swift
//  Domain.UseCase
//
//  Created by Kensuke Tamura on 2021/05/06.
//

import Foundation

public protocol RequestAdditionalGithubOrgsUseCase {

    func invoke(continueWhenError: Bool) async
}
