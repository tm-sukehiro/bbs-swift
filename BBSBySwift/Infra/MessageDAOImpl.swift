import os.log
import UIKit

class MessageDAOImpl: MessageDAO {
    
    // MARK: Archiving Paths
    private static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    private static let ArchiveURL = DocumentsDirectory.appendingPathComponent("messages")
    
    func store(messages: [Message]) {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(messages, toFile: MessageDAOImpl.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("投稿の保存に成功しました", log: OSLog.default, type: .debug)
        } else {
            os_log("投稿の保存に失敗しました", log: OSLog.default, type: .error)
        }
    }
    
    func list() -> [Message] {
        guard let messages = NSKeyedUnarchiver.unarchiveObject(withFile: MessageDAOImpl.ArchiveURL.path) as? [Message] else {
            return []
        }
        return messages
    }
    
    func truncate() {
        NSKeyedArchiver.archiveRootObject([], toFile: MessageDAOImpl.ArchiveURL.path)
    }
}
