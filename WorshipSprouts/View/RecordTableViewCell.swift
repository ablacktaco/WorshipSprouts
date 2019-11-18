//
//  RecordTableViewCell.swift
//  WorshipSprouts
//
//  Created by 陳姿穎 on 2019/11/18.
//  Copyright © 2019 陳姿穎. All rights reserved.
//

import UIKit

class RecordTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBOutlet var worshiper: UILabel!
    @IBOutlet var worshipTime: UILabel!
    @IBOutlet var worshipItem: UILabel!
    

}

extension RecordTableViewCell {
    
    func setHistory(worshipHistory: WorshipRecord, indexPath: IndexPath) {
        let history = worshipHistory.worship_history_for_spout[indexPath.row]
        worshiper.text = history.name
        worshipTime.text = history.created_at
        worshipItem.text = history.item.item_name
    }
    
}
