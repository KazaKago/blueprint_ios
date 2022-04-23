//
//  GithubOrgStateManager.swift
//  Data_Cache
//
//  Created by Kensuke Tamura on 2022/04/23.
//

import Foundation
import StoreFlowable

public class GithubOrgStateManager: FlowableDataStateManager<String> {

    public static let shared = GithubOrgStateManager()

    private override init() {
    }
}
