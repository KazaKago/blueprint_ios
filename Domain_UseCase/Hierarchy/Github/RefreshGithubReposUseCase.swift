//
//  RefreshGithubReposUseCase.swift
//  Domain.UseCase
//
//  Created by Kensuke Tamura on 2021/05/06.
//

import Foundation
import Domain_Model

public protocol RefreshGithubReposUseCase {

    func invoke(githubOrgName: GithubOrgName) async
}
