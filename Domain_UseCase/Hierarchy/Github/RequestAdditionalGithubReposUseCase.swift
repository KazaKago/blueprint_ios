//
//  RequestAdditionalGithubReposUseCase.swift
//  Domain.UseCase
//
//  Created by Kensuke Tamura on 2021/05/06.
//

import Foundation
import Domain_Model

public protocol RequestAdditionalGithubReposUseCase {

    func invoke(githubOrgName: GithubOrgName, continueWhenError: Bool) async
}
