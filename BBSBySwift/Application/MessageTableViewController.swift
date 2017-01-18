import os.log
import UIKit

// 投稿一覧画面
class MessageTableViewController: UIViewController {
    
    // MARK: Properties
    let repository = MessageRepositoryImpl()
    @IBOutlet weak fileprivate var tableView: UITableView!
    fileprivate let dataSource = MessageTableViewDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = dataSource
        
        // Editボタンを追加する
        navigationItem.leftBarButtonItem = editButtonItem

        // 保存済みの投稿を読み込む。またはサンプルデータを読み込む
        let list = repository.list()
        if list.count > 0 {
            dataSource.messages += list
        } else {
            // サンプルデータを読み込む
            dataSource.messages += repository.sampleList()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation
    // 別画面に遷移したときの振る舞い
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            // 新規投稿画面に遷移
            case "AddItem":
                os_log("投稿を追加します", log: OSLog.default, type: .debug)
            // 編集画面に遷移
            case "ShowDetail":
                guard let messageDetailViewController = segue.destination as? MessageViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")
                }
            
                guard let selectedMessageCell = sender as? MessageTableViewCell else {
                    fatalError("Unexpected sender: \(sender)")
                }
            
                guard let indexPath = tableView.indexPath(for: selectedMessageCell) else {
                    fatalError("The selected cell is not begin displayed by the table")
                }
            
                let selectedMessage = dataSource.messages[indexPath.row]
                messageDetailViewController.message = selectedMessage
            default:
                fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    
    // 一覧画面に戻ってきたときに選択状態を解除する
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPathForSelectedRow = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
    }
    
    // MARK: Actions
    // Saveボタンの振る舞い
    @IBAction func unwindToMessageList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? MessageViewController, let message = sourceViewController.message {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // 投稿を編集する
                dataSource.messages[selectedIndexPath.row] = message
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                // 投稿を追加する
                let newIndexPath = IndexPath(row: dataSource.messages.count, section: 0)
                
                dataSource.messages.append(message)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            // 投稿を保存する
            repository.store(messages: dataSource.messages)
        }
    }
}

extension MessageTableViewController: UITableViewDelegate {
    // Editボタンの振る舞い
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.isEditing = editing
    }
}
