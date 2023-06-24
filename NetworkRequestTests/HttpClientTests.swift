@testable import NetworkRequest
import XCTest


final class HttpClientTests: XCTestCase {
    
    var httpClient  : HttpClient!
    let session = MockURLSession()
    
    override func setUp() {
        super.setUp()
        httpClient = HttpClient(session: session)
    }
    
    override func tearDown() {
        httpClient = nil
        super.tearDown()
    }
    
    // MARK:  Test First Requirement - Test Correctness of the passing values
    // Http should submit the request same URL as the assign one
    
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
    
    // MARK:  Test Second Requirement - Test behaviour of certain function
    // HttpClient should sumbit the request
    
    func test_get_request_resumeShouldBeCalled() {
        guard let url = URL(string: "https//mockurl") else {
            fatalError("URL is not valid")
        }
        
        httpClient.get(url: url) { data, error in }
        
        // Assert
        // Identify if HttpClient should submit request
        XCTAssertTrue(session.dataTask.resumeWasCalled, "dataTask")
    }
}
