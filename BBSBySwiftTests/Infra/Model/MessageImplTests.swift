import XCTest
@testable import BBSBySwift

class MessageImplTests: XCTestCase {
    // 正常系
    func testMessageInitializationSucceeds() {
        // 正しいMessage
        let validMessage = MessageImpl.init(name: "名前", text: "本文", photo: nil)
        XCTAssertNotNil(validMessage)
    }
    
    // 異常系
    func testMessageInitializationFails() {
        // 名前が空
        let emptyNameMessage = MessageImpl.init(name: "", text: "本文", photo: nil)
        XCTAssertNil(emptyNameMessage)
        
        // 本文が空
        let emptyTextMessage = MessageImpl.init(name: "名前", text: "", photo: nil)
        XCTAssertNil(emptyTextMessage)
    }
}
