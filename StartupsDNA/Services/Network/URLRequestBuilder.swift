//
//  URLRequestBuilder.swift
//  EffectiveMobile
//
//  Created by Alexander Ognerubov on 04.09.2025.
//


import Foundation

enum RequestMethod: String {
    case get
    case post
    case patch
    case delete
}

final class URLRequestBuilder {
    
    static let shared = URLRequestBuilder()
    
    private func makeBaseRequestAndURL<T: Encodable>(
        path: String,
        httpMethod: RequestMethod,
        baseURLString: String,
        bodyObject: T? = nil,
        headers: [String: String]? = nil
    ) -> (request: URLRequest, baseUrl: URL) {
        let emptyURL = URL(fileURLWithPath: "")
        guard let url = URL(string: baseURLString),
              let baseURL = URL(string: path, relativeTo: url)
        else {
            assertionFailure("Impossible to create URLRequest of URL")
            return (URLRequest(url: emptyURL), emptyURL)
        }
        
        var request = URLRequest(url: baseURL)
        request.httpMethod = httpMethod.rawValue
        request.timeoutInterval = 10

        if let bodyObject = bodyObject {
            do {
                request.httpBody = try JSONEncoder().encode(bodyObject)
                if headers?["Content-Type"] == nil {
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                }
            } catch {
                assertionFailure("Failed to encode body: \(error)")
            }
        }

        headers?.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }

        return (request, baseURL)
    }
    
    func makeHTTPRequest<T: Encodable>(
        path: String,
        httpMethod: RequestMethod,
        baseURLString: String,
        bodyObject: T? = nil,
        headers: [String: String]? = nil
    ) -> URLRequest?  {
        return makeBaseRequestAndURL(
            path: path,
            httpMethod: httpMethod,
            baseURLString: baseURLString,
            bodyObject: bodyObject,
            headers: headers
        ).request
    }
}
