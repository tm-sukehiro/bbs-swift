import XCTest
@testable import BBSBySwift

class MessageDAOImplTests: XCTestCase {
    let dao = MessageDAOImpl()
    
    override func setUp() {
        super.setUp()
        dao.truncate()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    // 空の投稿一覧を取得できる
    func testEmptyList() {
        let emptyList = dao.list()
        XCTAssert(emptyList.isEmpty)
    }

    // 投稿できる、投稿一覧を取得できる
    func testDefinedList() {
        let message1 = MessageImpl(name: "名前", text: "本文", photo: nil)!
        let messages: [Message] = [message1]
        dao.store(messages: messages)
        
        let definedList = dao.list()
        XCTAssert(definedList.count == 1)
        XCTAssert(definedList.first!.name == message1.name)
    }
    
    // 投稿一覧を初期化できる
    func testTruncateDefinedList() {
        let message1 = MessageImpl(name: "名前", text: "本文", photo: nil)!
        let messages: [Message] = [message1]
        dao.store(messages: messages)
        dao.truncate()
        
        let truncateList = dao.list()
        XCTAssert(truncateList.count == 0)
    }
}
