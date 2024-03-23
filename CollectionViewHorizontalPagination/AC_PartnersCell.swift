//
//  AC_PartnersCell.swift
//  EasyDaily
//
//  Created by Kambaa on 18/03/24.
//

import UIKit

class AC_PartnersCell: UICollectionViewCell {

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
        
        self.bgView.backgroundColor = .partnerCellcolor
        self.bgView.layer.cornerRadius = 5
        self.bgView.clipsToBounds = true
        
        self.iconImage.image = UIImage(named: "travel")
        self.iconImage.layer.cornerRadius = 5
        self.iconImage.layer.masksToBounds = true
        self.iconImage.contentMode = .scaleAspectFit

        self.valueLabel.setUpLabel(font: .systemFont(ofSize: 16), title: "Milk", alignment: .center, textColor: .black, bgColor: .clear)
        
    }

}
