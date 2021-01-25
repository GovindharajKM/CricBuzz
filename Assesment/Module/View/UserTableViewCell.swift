//
//  UserTableViewCell.swift
//  Assesment
//
//  Created by Govindharaj Murugan on 06/01/21.
//

import UIKit
import Kingfisher

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var imageViewAvatar: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblId: UILabel!
    
    var viewModel: UserTableCellViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageViewAvatar.layer.roundedCorner()
        self.viewBackground.layer.setBorder()
        self.viewBackground.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpCell(_ viewModel: UserTableCellViewModel) {
        let url = URL(string: viewModel.imageUrl ?? "")
        self.imageViewAvatar.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholder"))
        
        self.lblId.text = "\(viewModel.id ?? 0)"
        self.lblUserName.text = viewModel.userName
        self.themeBasedColors()
    }
    
    func themeBasedColors() {
        self.viewBackground.backgroundColor = ThemeModel.bgColor
        self.lblUserName.textColor = ThemeModel.textColor
        self.lblId.textColor = ThemeModel.textColor
        self.contentView.backgroundColor = ThemeModel.viewBgColor
    }
    
}
