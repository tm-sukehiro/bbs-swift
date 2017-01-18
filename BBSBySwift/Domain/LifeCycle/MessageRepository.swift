import Foundation

protocol MessageRepository {
    func store(messages: [Message])
    
    func list() -> [Message]
    
    func sampleList() -> [Message]
}
