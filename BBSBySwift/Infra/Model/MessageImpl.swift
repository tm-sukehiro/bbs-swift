import os.log
import UIKit

class MessageImpl: NSObject, NSCoding, Message {
    // MARK: Properties
    let name: String
    let text: String
    let photo: UIImage?
    
    // MARK: Types
    struct PropertyKey {
        static let name = "name"
        static let text = "text"
        static let photo = "photo"
    }
    
    init?(name: String, text: String, photo: UIImage?) {
        // 名前は必須
        guard !name.isEmpty else {
            return nil
        }
        
        // 本文は必須
        guard !text.isEmpty else {
            return nil
        }
        
        self.name = name
        self.text = text
        self.photo = photo
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // 名前は必須
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("名前をデコードできませんでした", log: OSLog.default, type: .debug)
            return nil
        }
        
        // 本文は必須
        guard let text = aDecoder.decodeObject(forKey: PropertyKey.text) as? String else {
            os_log("本文をデコードできませんでした", log: OSLog.default, type: .debug)
            return nil
        }
        
        // プロフィール画像は任意
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        self.init(name: name, text: text, photo: photo)
    }
    
    // MARK: NSCoding
    // NSCodingを実装すると、自作クラスでもアーカイブ&アンアーカイブできる
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(text, forKey: PropertyKey.text)
        aCoder.encode(photo, forKey: PropertyKey.photo)
    }
}
