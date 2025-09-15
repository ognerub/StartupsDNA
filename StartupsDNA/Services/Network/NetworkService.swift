//
//  NetworkService.swift
//  EffectiveMobile
//
//  Created by Alexander Ognerubov on 04.09.2025.
//

import Foundation

final class NetworkService {

    private let urlSession: URLSession
    private let builder: URLRequestBuilder

    private var currentTask: URLSessionTask?

    init (
        urlSession: URLSession = .shared,
        builder: URLRequestBuilder = .shared
    ) {
        self.urlSession = urlSession
        self.builder = builder
    }

    func getToken(firebaseToken: String, completion: @escaping (Result<AuthResponseModel,Error>) -> Void) {
        if currentTask != nil { return } else { currentTask?.cancel() }
        guard let request = createUrlRequest(method: .post, token: firebaseToken) else {
            completion(.failure(NetworkError.urlSessionError))
            return
        }
        currentTask = urlSession.objectTask(for: request) { [weak self] (result: Result<AuthResponseModel,Error>) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.currentTask = nil
                switch result {
                case .success(let result):
                    completion(.success(result))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        currentTask?.resume()
    }
}

private extension NetworkService {
    func createUrlRequest(method: RequestMethod, token: String) -> URLRequest? {
        let path: String = "/rpc/client"
        return builder.makeHTTPRequest(
            path: path,
            httpMethod: method,
            baseURLString: NetworkConstants.baseUrl,
            bodyObject: AuthRequestModel(id: 1, jsonrpc: "2.0", method: "auth.firebaseLogin", params: AuthRequestParams(fbIdToken: token)),
            headers: [
                "Content-Type": "application/json"
            ]
        )
    }
}

enum NetworkConstants {
    static let baseUrl = "https://api.court360.ai"
}
