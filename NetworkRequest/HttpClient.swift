//
//  HttpClient.swift
//  Network-UnitTest
//
//  Created by Husnain Ali on 08/04/2023.
//

import Foundation


/// Dependency Injection, we will use to design object

/// `HttpClient`, class responsible to make Http related request
///
/// `Requirements`
/// 1. Sumbit the request with the same URL as the assigned one
/// 2. Submit the request
final class HttpClient {
    typealias completeClosure = (_ data : Data?, _ error : Error?) -> Void
    
    /// `session`,  environment to connect the app to internet
    ///
    /// `session`
    /// - Can be injected when the `HttpClient` get created which allow to use different session in production and test environment
    private let session : URLSessionContract
    
    init(session: URLSessionContract = URLSession.shared) {
        self.session = session
    }
    
    func get(url : URL, completion : @escaping completeClosure ) {
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { data, response, error in
            completion(data, error)
        }
        task.resume()
    }
}
