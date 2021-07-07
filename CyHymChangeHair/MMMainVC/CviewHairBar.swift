//
//  CviewHairBar.swift
//  CyHymChangeHair
//
//  Created by JOJO on 2021/7/5.
//

import UIKit

class CviewHairBar: UIView {

    var sexName: String
    var ageString: String
    var didClickItemBlock: ((_ hairItem: THymHairItem) -> Void)?
    
    var collectionBundle: UICollectionView!
    var collectionContent: UICollectionView!
    
    var bundleList: [THymHairBundle] = []
    var currentBundle: THymHairBundle?
    var currentContentItem: THymHairItem?
    
    
    
    init(frame: CGRect, sexName: String, ageString: String) {
        self.sexName = sexName
        self.ageString = ageString
        super.init(frame: frame)
        loadData()
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadData() {
        if sexName == "female" {
            bundleList = THDataManager.default.girlHairBundleList
        } else {
            bundleList = THDataManager.default.manHairBundleList
        }
        bundleList.append(contentsOf: THDataManager.default.tattooBundleList)
        
        
        if let age = ageString.int {
            if age <= 30 {
                currentBundle = bundleList[0]
            } else if age <= 45 {
                currentBundle = bundleList[1]
            } else if age <= 60 {
                currentBundle = bundleList[2]
            } else if age <= 85 {
                currentBundle = bundleList[3]
            } else {
                currentBundle = bundleList[0]
            }
            
        }
        
    }
    
    func setupView() {
        
        
        let layoutB = UICollectionViewFlowLayout()
        layoutB.scrollDirection = .horizontal
        collectionBundle = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layoutB)
        collectionBundle.showsVerticalScrollIndicator = false
        collectionBundle.showsHorizontalScrollIndicator = false
        collectionBundle.backgroundColor = .clear
        collectionBundle.delegate = self
        collectionBundle.dataSource = self
        addSubview(collectionBundle)
        collectionBundle.snp.makeConstraints {
            $0.top.equalTo(0)
            $0.right.left.equalToSuperview()
            $0.height.equalTo(50)
        }
        collectionBundle.register(cellWithClass: CviewHairBundleCell.self)
        
         
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionContent = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collectionContent.showsVerticalScrollIndicator = false
        collectionContent.showsHorizontalScrollIndicator = false
        collectionContent.backgroundColor = .clear
        collectionContent.delegate = self
        collectionContent.dataSource = self
        addSubview(collectionContent)
        collectionContent.snp.makeConstraints {
            $0.right.left.equalToSuperview()
            $0.height.equalTo(100)
            $0.bottom.equalTo(-6)
        }
        collectionContent.register(cellWithClass: CviewHairContentCell.self)
    }

}

extension CviewHairBar: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionBundle {
            let bundle = bundleList[indexPath.item]
            let cell = collectionView.dequeueReusableCell(withClass: CviewHairBundleCell.self, for: indexPath)
            cell.nameLabel.text = bundle.titleName
            if currentBundle?.titleName == bundle.titleName {
                cell.nameLabel.font = UIFont(name: "Lexend-ExtraBold", size: 14)
                cell.nameLabel.textColor = UIColor(hexString: "#FF3797")
            } else {
                cell.nameLabel.font = UIFont(name: "Lexend-Medium", size: 14)
                cell.nameLabel.textColor = UIColor(hexString: "#000000")?.withAlphaComponent(0.25)
            }
            
            return cell
        } else {
            let item = currentBundle?.items[indexPath.item]
            let cell = collectionView.dequeueReusableCell(withClass: CviewHairContentCell.self, for: indexPath)
            cell.contentImgV.image = UIImage(named: item?.thumbnail ?? "")
            if item?.isPro == true {
                cell.vipImgV.isHidden = false
            } else {
                cell.vipImgV.isHidden = true
            }
            
            if item?.thumbnail == currentContentItem?.thumbnail {
                
                    cell.contentImgV.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
                    cell.contentImgV.center = CGPoint(x: cell.bounds.size.width / 2, y: cell.bounds.size.height / 2)
                
                
            } else {
                
                    cell.contentImgV.frame = CGRect(x: 0, y: 0, width: 68, height: 68)
                    cell.contentImgV.center = CGPoint(x: cell.bounds.size.width / 2, y: cell.bounds.size.height / 2)
                
                
            }
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionBundle {
            return bundleList.count
        } else {
            return currentBundle?.items.count ?? 0
        }
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension CviewHairBar: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionBundle {
            return CGSize(width: 100, height: 40)
        } else {
            return CGSize(width: 80, height: 80)
        }
        return CGSize(width: 10, height: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == collectionBundle {
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        } else {
            return UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        }
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == collectionBundle {
            return 5
        } else {
            return 5
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == collectionBundle {
            return 5
        } else {
            return 5
        }
        return 0
    }
    
}

extension CviewHairBar: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionBundle {
            currentBundle = bundleList[indexPath.item]
            collectionBundle.reloadData()
            collectionContent.reloadData()
        } else {
            currentContentItem = currentBundle?.items[indexPath.item]
//            collectionContent.reloadData()
            if let currentContentItem_m = currentContentItem {
                didClickItemBlock?(currentContentItem_m)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
}





class CviewHairBundleCell: UICollectionViewCell {
    
    var nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentView.addSubview(nameLabel)
        nameLabel.font = UIFont(name: "Lexend-Medium", size: 14)
        nameLabel.textColor = UIColor(hexString: "#000000")?.withAlphaComponent(0.25)
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.textAlignment = .center
        nameLabel.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        //        nameLabel.font = UIFont(name: "Lexend-ExtraBold", size: 14)
        //        nameLabel.textColor = UIColor(hexString: "#FF3797")
        
        
    }
    
    
    
}


class CviewHairContentCell: UICollectionViewCell {
    
    var contentImgV = UIImageView()
    var vipImgV = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentImgV.backgroundColor = .white
        contentImgV.layer.cornerRadius = 12
        
        contentImgV.layer.shadowColor = UIColor(hexString: "#434343")?.withAlphaComponent(0.1).cgColor
        contentImgV.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentImgV.layer.shadowRadius = 3
        contentImgV.layer.shadowOpacity = 0.8
        
        
        contentView.addSubview(contentImgV)
        contentImgV.contentMode = .scaleAspectFit
        contentImgV.frame = CGRect(x: 0, y: 0, width: 68, height: 68)
        contentImgV.center = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        
        vipImgV.image = UIImage(named: "vip_ic")
        contentView.addSubview(vipImgV)
        vipImgV.contentMode = .scaleAspectFit
        vipImgV.snp.makeConstraints {
            $0.top.right.equalToSuperview()
            $0.width.height.equalTo(30)
        }
        
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                UIView.animate(withDuration: 0.3) {
                    [weak self] in
                    guard let `self` = self else {return}
                    self.contentImgV.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
                    self.contentImgV.center = CGPoint(x: self.bounds.size.width / 2, y: self.bounds.size.height / 2)

//                    self.contentView.layoutIfNeeded()
                }

            } else {

                UIView.animate(withDuration: 0.3) {
                    [weak self] in
                    guard let `self` = self else {return}
                    self.contentImgV.frame = CGRect(x: 0, y: 0, width: 68, height: 68)
                    self.contentImgV.center = CGPoint(x: self.bounds.size.width / 2, y: self.bounds.size.height / 2)
//                    self.contentView.layoutIfNeeded()
                }
            }
        }
    }
    
    
}
