import Foundation

protocol MessageDAO {
    func store(messages: [Message])
    
    func list() -> [Message]
    
    func truncate()
}
