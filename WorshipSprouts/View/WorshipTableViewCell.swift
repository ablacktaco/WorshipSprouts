//
//  WorshipTableViewCell.swift
//  WorshipSprouts
//
//  Created by 陳姿穎 on 2019/11/18.
//  Copyright © 2019 陳姿穎. All rights reserved.
//

import UIKit

class WorshipTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBOutlet private var itemImage: UIImageView!
    @IBOutlet private var itemName: UILabel!
    @IBOutlet var worshipButton: UIButton!
    
}

extension WorshipTableViewCell {
    
    func setListData(worshipList: WorshipList, indexPath: IndexPath) {
        itemImage.image = UIImage(named: worshipList.items_for_spout[indexPath.row].item_name)
        itemName.text = "\(worshipList.items_for_spout[indexPath.row].item_name)"
    }
    
    
}
