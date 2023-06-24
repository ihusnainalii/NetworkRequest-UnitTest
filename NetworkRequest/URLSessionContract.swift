//
//  URLSessionContract.swift
//  Network-UnitTest
//
//  Created by Husnain Ali on 08/04/2023.
//

import Foundation

/// Protocol, we will use to design mock object


/// `URLSessionContract`, protocol that contains method to make Http request
///
/// - Copy the signature method from URLSession `func dataTask(with:, completionHandler:)`, which allow the implementor access the method to make Http request
protocol URLSessionContract {
    func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

/// Extend URLSession with the procotol `URLSessionContract`. It does not need to implement any method because it already have default implementation underneath
extension URLSession : URLSessionContract {}
