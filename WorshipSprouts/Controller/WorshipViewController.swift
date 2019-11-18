//
//  ViewController.swift
//  WorshipSprouts
//
//  Created by 陳姿穎 on 2019/11/18.
//  Copyright © 2019 陳姿穎. All rights reserved.
//

import UIKit

class WorshipViewController: UIViewController {

    var worshipList: WorshipList = WorshipList(items_for_spout: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem(title: "Worship", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem = backButton
        
        if worshipList.items_for_spout.count == 0 {
            worshipTable.backgroundView = loadingView
            worshipTable.separatorStyle = .none
        } else {
            worshipTable.backgroundView = UIView()
            worshipTable.separatorStyle = .singleLine
        }
        
        getWorshipList { (worshipList) in
            self.worshipList = worshipList
            print(worshipList)
            DispatchQueue.main.async {
                self.worshipTable.reloadData()
            }
        }
    }
    
    @IBOutlet var worshipTable: UITableView!
    @IBOutlet var loadingView: UIView!
    @IBOutlet var worshiperName: UITextField!
    @IBAction func checkContent(_ sender: UITextField) {
        if sender.text?.trimmingCharacters(in: .whitespaces) == "" {
            worshipTable.reloadData()
        } else if sender.text?.trimmingCharacters(in: .whitespaces).count == 1 {
            worshipTable.reloadData()
        }
    }
    @IBAction func doNotTouch(_ sender: UIButton) {
        let alertController = UIAlertController(title: "摸屁摸啊！", message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "QQ", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
}

extension WorshipViewController {
    func getWorshipList(closure: @escaping (WorshipList) -> Void) {
        let address = "https://33660b8c.ngrok.io/api/spout"
        if let url = URL(string: address) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("error: \(error.localizedDescription)")
                }
                guard let data = data else { return }
                if let response = response as? HTTPURLResponse {
                    print("status code: \(response.statusCode)")
                    if let worshipList = try? JSONDecoder().decode(WorshipList.self, from: data) {
                        closure(worshipList)
                    }
                }
            }.resume()
        }
    }
    
    @objc func tapToWorship(sender: UIButton) {
        
        sender.isEnabled = false
        sender.backgroundColor = .lightGray
        
        let worshipData = WorshipData(name: worshiperName.text!.trimmingCharacters(in: .whitespaces), item_id: sender.tag + 1)
        guard let uploadData = try? JSONEncoder().encode(worshipData) else { return }
                
        let url = URL(string: "https://33660b8c.ngrok.io/api/spout")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
                
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { (data, response, error) in
            if let error = error {
            print ("error: \(error)")
                return
            }
            if let response = response as? HTTPURLResponse {
                print("status code: \(response.statusCode)")
                if let mimeType = response.mimeType,
                    mimeType == "application/json",
                    let data = data,
                    let dataString = String(data: data, encoding: .utf8) {
                    print ("got data: \(dataString)")
                    DispatchQueue.main.async {
                        let alertController = UIAlertController(title: "祭拜成功", message: nil, preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alertController, animated: true, completion: nil)
                        sender.isEnabled = true
                        sender.backgroundColor = UIColor(red: 0, green: 150/255, blue: 0, alpha: 1)
                    }
                }
            }
        }
        task.resume()
    }
}

extension WorshipViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension WorshipViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return worshipList.items_for_spout.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "worshipListCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! WorshipTableViewCell
        cell.setListData(worshipList: worshipList, indexPath: indexPath)
        
        cell.selectionStyle = .none
        
        if worshiperName.text?.trimmingCharacters(in: .whitespaces) == "" {
            cell.worshipButton.isEnabled = false
            cell.worshipButton.backgroundColor = .lightGray
        } else {
            cell.worshipButton.isEnabled = true
            cell.worshipButton.backgroundColor = UIColor(red: 0, green: 150/255, blue: 0, alpha: 1)
        }
        
        cell.worshipButton.tag = indexPath.row
        cell.worshipButton.addTarget(self, action: #selector(self.tapToWorship(sender:)), for: .touchUpInside)
        
        return cell
    }
    
}
