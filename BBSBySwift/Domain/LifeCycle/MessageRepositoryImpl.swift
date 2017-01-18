import os.log
import UIKit

class MessageRepositoryImpl: MessageRepository {
    let dao = MessageDAOImpl()
    
    func store(messages: [Message]) {
        dao.store(messages: messages)
    }
    
    func list() -> [Message] {
        return dao.list()
    }
    
    func sampleList() -> [Message] {
        let photo1 = UIImage(named: "shinpai_ojisan")
        let photo2 = UIImage(named: "pose_kiri_man")
        let photo3 = UIImage(named: "pose_kiri_woman")
        
        guard let message1 = MessageImpl(name: "太郎", text: "本文1", photo: photo1) else {
            fatalError("message1がインスタンス化できません")
        }
        
        guard let message2 = MessageImpl(name: "次郎", text: "本文2", photo: photo2) else {
            fatalError("message2がインスタンス化できません")
        }
        
        guard let message3 = MessageImpl(name: "花子", text: "本文3", photo: photo3) else {
            fatalError("message3がインスタンス化できません")
        }
        
        return [message1, message2, message3]
    }
}
