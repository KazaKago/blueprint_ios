//
//  FollowGithubOrgsUseCase.swift
//  Domain.UseCase
//
//  Created by Kensuke Tamura on 2021/05/06.
//

import Foundation
import StoreFlowable
import Domain_Model

public protocol FollowGithubOrgsUseCase {

    func invoke() -> StatePublisher<[GithubOrg]>
}
