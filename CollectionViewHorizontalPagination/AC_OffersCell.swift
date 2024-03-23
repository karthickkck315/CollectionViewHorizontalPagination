//
//  AC_OffersCell.swift
//  EasyDaily
//
//  Created by Kambaa on 19/03/24.
//

import UIKit

class AC_OffersCell: UICollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var valueLabel: UILabel!
    
    static var identifier: String {
        return String(describing: self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUPCell()
    }
    
    func setUPCell() {
        
        self.bgView.backgroundColor = .bg_lightThemecolor
        self.bgView.layer.borderColor = UIColor.primary_color.cgColor
        self.bgView.layer.borderWidth = 1
        self.bgView.layer.cornerRadius = 5
        self.bgView.clipsToBounds = true
        
        self.iconImage.image = UIImage(named: "travel")
        self.iconImage.layer.cornerRadius = 5
        self.iconImage.layer.masksToBounds = true
        self.iconImage.contentMode = .scaleAspectFit

        self.valueLabel.setUpLabel(font: .systemFont(ofSize: 16), title: "Travel".uppercased(), alignment: .center, textColor: .black, bgColor: .clear)
        
    }


}
