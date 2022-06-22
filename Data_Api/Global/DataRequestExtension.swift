//
//  DataRequestExtension.swift
//  Data.Api
//
//  Created by Kensuke Tamura on 2021/05/06.
//

import Foundation
import Alamofire

extension DataRequest {

    func publish<T>(_ type: T.Type) async throws -> T where T : Decodable {
        try await withCheckedThrowingContinuation { continuation in
            self.response { response in
                switch response.result {
                case .success(let element): do {
                    let decodedResponse = try JSONDecoder().decode(type, from: element!)
                    continuation.resume(returning: decodedResponse)
                } catch {
                    continuation.resume(throwing: error)
                }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
