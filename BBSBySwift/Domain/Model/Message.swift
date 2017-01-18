import UIKit

protocol Message {
    var name: String { get }
    var text: String { get }
    var photo: UIImage? { get }
}
