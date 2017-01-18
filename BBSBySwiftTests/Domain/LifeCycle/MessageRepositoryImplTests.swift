import XCTest
@testable import BBSBySwift

class MessageRepositoryImplTests: XCTestCase {
    let repository = MessageRepositoryImpl()
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
        let emptyList = repository.list()
        XCTAssert(emptyList.isEmpty)
    }
    
    // 投稿できる、投稿一覧を取得できる
    func testDefinedList() {
        let message1 = MessageImpl(name: "名前", text: "本文", photo: nil)!
        let messages: [Message] = [message1]
        repository.store(messages: messages)
        
        let definedList = repository.list()
        XCTAssert(definedList.count == 1)
        XCTAssert(definedList.first!.name == message1.name)
    }
    
    // サンプルの投稿一覧を取得できる
    func testSampleList() {
        let sampleList = repository.sampleList()
        let message = sampleList.first!
        
        XCTAssert(sampleList.count == 3)
        XCTAssert(message.name == "太郎")
        XCTAssert(message.text == "本文1")
        XCTAssert(message.photo == UIImage(named: "shinpai_ojisan"))
    }
}
