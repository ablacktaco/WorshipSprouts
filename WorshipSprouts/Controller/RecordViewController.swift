//
//  RecordViewController.swift
//  WorshipSprouts
//
//  Created by 陳姿穎 on 2019/11/18.
//  Copyright © 2019 陳姿穎. All rights reserved.
//

import UIKit

class RecordViewController: UIViewController {

    var worshipHistory = WorshipRecord(worship_history_for_spout: [])
    @IBOutlet var loadingView: UIView!
    @IBOutlet var historyTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.tintColor = .white
        navigationItem.title = "History"
        
        let backButton = UIBarButtonItem(title: "Worship", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem = backButton
        
        if worshipHistory.worship_history_for_spout.count == 0 {
            historyTable.backgroundView = loadingView
            historyTable.separatorStyle = .none
        } else {
            historyTable.backgroundView = UIView()
            historyTable.separatorStyle = .singleLine
        }
        
        getHistory { (worshipHistory) in
            self.worshipHistory = worshipHistory
            print(worshipHistory)
            DispatchQueue.main.async {
                self.historyTable.reloadData()
            }
        }
    }

}

extension RecordViewController {
    
    func getHistory(closure: @escaping (WorshipRecord) -> Void) {
        let address = "https://33660b8c.ngrok.io/api/spout/history"
        if let url = URL(string: address) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("error: \(error.localizedDescription)")
                }
                guard let data = data else { return }
                if let response = response as? HTTPURLResponse {
                    print("status code: \(response.statusCode)")
                    if let worshipHistory = try? JSONDecoder().decode(WorshipRecord.self, from: data) {
                        closure(worshipHistory)
                    }
                }
            }.resume()
        }
    }
    
}


extension RecordViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return worshipHistory.worship_history_for_spout.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "historyCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! RecordTableViewCell
        cell.setHistory(worshipHistory: worshipHistory, indexPath: indexPath)
        
        return cell
    }


}
