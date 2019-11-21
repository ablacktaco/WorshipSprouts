//
//  getAPIData.swift
//  WorshipSprouts
//
//  Created by 陳姿穎 on 2019/11/19.
//  Copyright © 2019 陳姿穎. All rights reserved.
//

import Foundation

class getAPIData {
    
    func getData(api: String, closure: @escaping (Any) -> Void) {
        let address = "https://33660b8c.ngrok.io/"
        if let url = URL(string: address + api) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("error: \(error.localizedDescription)")
                    return
                }
                guard let data = data else { return }
                if let response = response as? HTTPURLResponse {
                    print("status code: \(response.statusCode)")
                    if let worshipData = try? JSONDecoder().decode(WorshipRecord.self, from: data) {
                        closure(worshipData)
                    }
                }
            }.resume()
        }
    }
    
}
