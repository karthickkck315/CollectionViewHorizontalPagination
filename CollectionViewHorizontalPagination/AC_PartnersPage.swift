//
//  .swift
//
//
//  Created by Karthick on 18/03/24.
//

import UIKit

let numberOfItemsPerRow = 3
let numberOfRows = 2
let numberOfPages = 1

class AC_PartnersPage: UIViewController, UICollectionViewDataSource, UIScrollViewDelegate, UICollectionViewDelegate {
    
    @IBOutlet weak var appsBGView: UIView!
    @IBOutlet weak var appsDetailLabel: UILabel!
    @IBOutlet weak var appsTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var appPAgeControl: UIPageControl!
    
    @IBOutlet weak var offersBGView: UIView!
    @IBOutlet weak var offersTitleLabel: UILabel!
    @IBOutlet weak var offersDetailLabel: UILabel!
    @IBOutlet weak var offersCollectionView: UICollectionView!
    @IBOutlet weak var offersPageControl: UIPageControl!
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        self.setUPUI()
        
        let layout = GridFlowLayout()
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.scrollDirection = .horizontal
        
        collectionView.collectionViewLayout = layout
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.tag = 1
        self.collectionView.register(UINib.init(nibName: AC_PartnersCell.identifier, bundle: nil), forCellWithReuseIdentifier: AC_PartnersCell.identifier)
        
        
        
        
        let offersLayout = GridOffersFlowLayout()
        offersLayout.minimumInteritemSpacing = 15
        offersLayout.minimumLineSpacing = 15
        offersLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        offersLayout.scrollDirection = .horizontal
        
        
        self.offersCollectionView.tag = 2
        self.offersCollectionView.collectionViewLayout = offersLayout
        self.offersCollectionView.isPagingEnabled = true
        self.offersCollectionView.dataSource = self
        self.offersCollectionView.delegate = self
        self.offersCollectionView.backgroundColor = .clear
        self.offersCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        self.offersCollectionView.register(UINib.init(nibName: AC_OffersCell.identifier, bundle: nil), forCellWithReuseIdentifier: AC_OffersCell.identifier)
        self.offersCollectionView.showsHorizontalScrollIndicator = false
    }
    
    func setUPUI() {
        
        self.appsBGView.backgroundColor = .bg_lightThemecolor
        self.appsDetailLabel.setUpLabel(font: .systemFont(ofSize: 16), title: "Below, showing banners, are our partners.", alignment: .center, textColor: .black, bgColor: .clear)
        self.appsTitle.setUpLabel(font: .boldSystemFont(ofSize: 20), title: "Our partner apps".uppercased(), alignment: .center, textColor: .primary_color, bgColor: .clear)
        
        self.appPAgeControl.hidesForSinglePage = true
        self.appPAgeControl.currentPageIndicatorTintColor = .primary_color
        self.appPAgeControl.tintColor = .gray
        self.appPAgeControl.pageIndicatorTintColor = .gray
        self.appPAgeControl.currentPage = 0
        let numberOfPages = calculateNumberOfPages(numberOfItems: 10, itemsPerPage: 6)
        self.appPAgeControl.numberOfPages = numberOfPages
        
        self.offersBGView.backgroundColor = .white
        self.offersTitleLabel.setUpLabel(font: .boldSystemFont(ofSize: 20), title: "PARTNER OFFERS".uppercased(), alignment: .center, textColor: .primary_color, bgColor: .clear)
        self.offersDetailLabel.setUpLabel(font: .systemFont(ofSize: 16), title: "Click and check for the great offers", alignment: .center, textColor: .black, bgColor: .clear)
        self.offersPageControl.hidesForSinglePage = true
        self.offersPageControl.currentPageIndicatorTintColor = .primary_color
        self.offersPageControl.pageIndicatorTintColor = .gray
        self.offersPageControl.tintColor = .gray
        let pages = calculateNumberOfPages(numberOfItems: 15, itemsPerPage: 6)
        self.offersPageControl.numberOfPages = pages
        self.offersPageControl.currentPage = 0
        
    }
    
    func calculateNumberOfPages(numberOfItems: Int, itemsPerPage: Int) -> Int {
        guard numberOfItems > 0 && itemsPerPage > 0 else {
            return 0
        }
        return Int(ceil(Double(numberOfItems) / Double(itemsPerPage)))
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       
        if scrollView.tag == 1 {
            let offSet = scrollView.contentOffset.x
            let width = scrollView.frame.width
            let horizontalCenter = width / 2
            self.appPAgeControl.currentPage = Int(offSet + horizontalCenter) / Int(width)
        } else {
            let offSet = scrollView.contentOffset.x
            let width = scrollView.frame.width
            let horizontalCenter = width / 2
            self.offersPageControl.currentPage = Int(offSet + horizontalCenter) / Int(width)
        }
        
    }
    
    // MARK: - UICollectionViewDataSource methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.offersCollectionView {
            return 15
        } else {
            return 11
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.offersCollectionView {
            let cell = self.offersCollectionView.dequeueReusableCell(withReuseIdentifier: AC_OffersCell.identifier, for: indexPath) as! AC_OffersCell
            
            return cell
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AC_PartnersCell.identifier, for: indexPath) as! AC_PartnersCell
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.offersCollectionView {
           print("Offers Collection View")
        } else {
            print("Partners Collection View")
        }
        
    }
}


class GridFlowLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        let availableWidth = collectionView.bounds.width - sectionInset.left - sectionInset.right - minimumInteritemSpacing * CGFloat(numberOfItemsPerRow - 1)
        let itemWidth = availableWidth / CGFloat(numberOfItemsPerRow)
        
        let availableHeight = collectionView.bounds.height - sectionInset.top - sectionInset.bottom - minimumLineSpacing * CGFloat(numberOfRows - 1)
        let itemHeight = availableHeight / CGFloat(numberOfRows)
        
        itemSize = CGSize(width: itemWidth, height: itemHeight)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        
        return layoutAttributes
    }
    
    override var collectionViewContentSize: CGSize {
        guard let collectionView = collectionView else { return CGSize.zero }
        
        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        let itemsPerPage = numberOfItemsPerRow * numberOfRows
        let numberOfPages = Int(ceil(Double(numberOfItems) / Double(itemsPerPage)))
        
        return CGSize(width: collectionView.bounds.width * CGFloat(numberOfPages), height: collectionView.bounds.height)
    }
}

class GridOffersFlowLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        let availableWidth = collectionView.bounds.width - sectionInset.left - sectionInset.right - minimumInteritemSpacing * CGFloat(numberOfItemsPerRow - 1)
        let itemWidth = availableWidth / CGFloat(numberOfItemsPerRow)
        
        let availableHeight = collectionView.bounds.height - sectionInset.top - sectionInset.bottom - minimumLineSpacing * CGFloat(numberOfRows - 1)
        let itemHeight = availableHeight / CGFloat(numberOfRows)
        
        itemSize = CGSize(width: itemWidth, height: itemHeight)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        
        return layoutAttributes
    }
    
    override var collectionViewContentSize: CGSize {
        guard let collectionView = collectionView else { return CGSize.zero }
        
        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        let itemsPerPage = numberOfItemsPerRow * numberOfRows
        let numberOfPages = Int(ceil(Double(numberOfItems) / Double(itemsPerPage)))
        
        return CGSize(width: collectionView.bounds.width * CGFloat(numberOfPages), height: collectionView.bounds.height)
    }
}


extension UIColor {
    
    static let primary_color = UIColor(rgba: "#F49D04")
    static let primary_color_light = UIColor(rgba: "#F5D26A")
    static let secondary_color = UIColor(rgba: "#0F1431")
    static let bg_lightThemecolor = UIColor(red: 244/255, green: 157/255, blue: 4/255, alpha: 0.05)
    static let partnerCellcolor = UIColor(red: 244/255, green: 157/255, blue: 4/255, alpha: 0.3)
    static let ac_categoryBordercolor = UIColor(red: 62/255, green: 67/255, blue: 71/255, alpha: 0.35)
    static let ac_greencolor = UIColor(rgba: "#1CE371")
    
    convenience init(rgba: String) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0

        if rgba.hasPrefix("#") {
            let index   = rgba.index(rgba.startIndex, offsetBy: 1)
            let hex     = rgba[index...]
            let scanner = Scanner(string: String(hex))

            var hexValue: CUnsignedLongLong = 0
            if scanner.scanHexInt64(&hexValue) {
                if hex.count == 6 {
                    red   = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
                    green = CGFloat((hexValue & 0x00FF00) >> 8)  / 255.0
                    blue  = CGFloat(hexValue & 0x0000FF) / 255.0
                } else if hex.count == 8 {
                    red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                    green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                    blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                    alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
                } else {
                    print("invalid rgb string, length should be 7 or 9", terminator: "")
                }
            } else {
                print("scan hex error")
            }
        } else {
            print("invalid rgb string, missing '#' as prefix", terminator: "")
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}


extension UILabel {
    func setUpLabel(font: UIFont,title:String,alignment: NSTextAlignment,textColor:UIColor,bgColor:UIColor) {
        self.font = font
        self.textAlignment = alignment
        self.backgroundColor = bgColor
        self.text = title
        self.textColor = textColor
    }
}
