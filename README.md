# NetworkRequest-UnitTest

1. Use Dependency Injection to design object

```
final class HttpClient {
    typealias completeClosure = (_ data : Data?, _ error : Error?) -> Void
   
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
```

<br>
<br>
<br>

2. Use prcotocol to design mock object

```
protocol URLSessionContract {
    func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession : URLSessionContract {}
```
<br>
<br>
<br>

```
final class MockURLSession : URLSessionContract {
    var capturedURLRequest : URL?
    var data : Data?
    var error : Error?
    
    func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.capturedURLRequest = request.url
        let data = self.data
        let error = self.error
        
        return FakeDataTask {
            completionHandler(data, nil, error)
        }
    }
}
```

<br>
<br>
<br>

3. Test data used by object

```
  func test_get_request_withURL() {
        // Arrage
        // Given a url “https://mockurl”
        guard let url = URL(string: "https//mockurl") else {
            fatalError("URL is not valid")
        }
        
        // Act
        // Submit a Http GET request
        httpClient.get(url: url) { data, error in }
        
        // Assert
        // Submitted URL should equal “https://mockurl”
        XCTAssertEqual(url, session.capturedURL)
    }
```

<br>
<br>
<br>

4. Test behaviour of object

```
    func test_get_request_resumeShouldBeCalled() {
        guard let url = URL(string: "https//mockurl") else {
            fatalError("URL is not valid")
        }
        
        httpClient.get(url: url) { data, error in }
        
        // Assert
        // Identify if HttpClient should submit request
        XCTAssertTrue(session.dataTask.resumeWasCalled, "dataTask")
    }
```
