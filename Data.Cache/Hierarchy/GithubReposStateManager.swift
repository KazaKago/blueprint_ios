//
//  GithubReposStateManager.swift
//  Data.Cache
//
//  Created by Kensuke Tamura on 2021/05/07.
//

import Foundation
import StoreFlowable

public class GithubReposStateManager: FlowableDataStateManager<String> {

    public static let shared = GithubReposStateManager()

    private override init() {
    }
}
