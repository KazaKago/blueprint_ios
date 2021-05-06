//
//  GithubOrgsStateManager.swift
//  Data.Cache
//
//  Created by Kensuke Tamura on 2021/05/07.
//

import Foundation
import StoreFlowable

public class GithubOrgsStateManager: FlowableDataStateManager<UnitHash> {

    public static let shared = GithubOrgsStateManager()

    private override init() {
    }
}
