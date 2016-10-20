import UIKit
import XCTest
import NSStringALEmail

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSample() {
        // This is an example of a functional test case.
        var sampleMail = "ali@gmail.co.uk"
        
        XCTAssert(sampleMail.isValidEmail() == true, "\(sampleMail) -Valid EMail- Pass")
        XCTAssert(sampleMail.isDisposableEmail() == false, "\(sampleMail) -Not Disposable EMail- Pass")
        
        
        sampleMail = "ali@10mail.com"
        
        XCTAssert(sampleMail.isValidEmail() == true, "\(sampleMail) -Valid EMail- Pass")
        XCTAssert(sampleMail.isDisposableEmail() == true, "\(sampleMail) -Not Disposable EMail- Pass")
        
        
        sampleMail = "ali@aaaaa"
        
        XCTAssert(sampleMail.isValidEmail() == false, "\(sampleMail) -Valid EMail- Pass")
        XCTAssert(sampleMail.isDisposableEmail() == false, "\(sampleMail) -Not Disposable EMail- Pass")
    }
    
    func testAllDisposables() {
        let blackList : [String] = ALEmailValidator.blacklist()
        for item in blackList {
            let sampleEmail =  "ali@" + item
            
            XCTAssert(sampleEmail.isDisposableEmail() == true, "\(sampleEmail) -Valid EMail- Pass")
        }
        
        XCTAssert(true, "Test completed")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
