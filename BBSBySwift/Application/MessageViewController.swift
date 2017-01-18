import os.log
import UIKit

// 新規投稿・編集画面
class MessageViewController: UIViewController {

    // MARK: Properties
    @IBOutlet weak private var nameTextField: UITextField!
    @IBOutlet weak fileprivate var photoImageView: UIImageView!
    @IBOutlet weak private var textField: UITextField!
    @IBOutlet weak fileprivate var saveButton: UIBarButtonItem!
    
    // MessageTableViewControllerから参照される
    var message: Message?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        textField.delegate = self
        
        if let message = message {
            navigationItem.title = message.name
            nameTextField.text = message.name
            photoImageView.image = message.photo
            textField.text = message.text
        }
        
        updateSaveButtonState()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMessageMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMessageMode {
            dismiss(animated: true, completion: nil)
        } else if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)
        } else {
            fatalError("The MessageViewController is not inside a navigation controller.")
        }
    }
    
    // 別画面に遷移したときの振る舞い
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Saveボタンが押されなかったときの振る舞い
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }

        // Saveボタンが押されたときの振る舞い
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let text = textField.text ?? ""
        
        message = MessageImpl(name: name, text: text, photo: photo)
    }
    
    // MARK: Actions
    // プロフィール画像フィールドの振る舞い
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        // キーボードを隠す
        nameTextField.resignFirstResponder()
        textField.resignFirstResponder()
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.sourceType = .photoLibrary
        
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    // MARK: FilePrivate Methods
    fileprivate func updateSaveButtonState() {
        // 名前もしくは本文が空の場合、Saveボタンを無効化する
        let name = nameTextField.text ?? ""
        let text = textField.text ?? ""
        saveButton.isEnabled = !name.isEmpty && !text.isEmpty
    }
    
}

extension MessageViewController: UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを隠す
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // 編集中はSaveボタンを無効化
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as?
            UIImage else {
                fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
}
