//
//  CyHMainVC.swift
//  CyHymChangeHair
//
//  Created by JOJO on 2021/7/2.
//

import UIKit


class CyHMainVC: UIViewController {
    var collection: UICollectionView!
    let topCoinLabel = UILabel()
    let settingView = CyHSettingView()
    var currentPageIndex: Int = 0
    var totalPage: Int = 10000
    var scrollTimer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        setupSettingView()
        setupTimerScroll()
        
        AppFlyerEventManager.default.event_LaunchApp()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        topCoinLabel.text = "\(FKbCoinMana.default.coinCount)"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        scrollTimer?.fireDate = Date()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        scrollTimer?.fireDate = .distantFuture
    }
    
     

}

extension CyHMainVC {
    func setupView() {
        let setttBtn = UIButton(type: .custom)
        view.addSubview(setttBtn)
        setttBtn.setImage(UIImage(named: "setting_ic"), for: .normal)
        setttBtn.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.left.equalTo(10)
            $0.width.height.equalTo(44)
        }
        setttBtn.addTarget(self, action: #selector(setttBtnClick(sender:)), for: .touchUpInside)
        //
        let nameLabel = UILabel()
        nameLabel.font = UIFont(name: "Lexend-Bold", size: 16)
        nameLabel.textColor = UIColor.black
        nameLabel.text = AppName
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.centerY.equalTo(setttBtn)
            $0.left.equalTo(setttBtn.snp.right).offset(2)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        //
        
        //
        topCoinLabel.textAlignment = .right
        topCoinLabel.text = "\(FKbCoinMana.default.coinCount)"
        topCoinLabel.textColor = UIColor(hexString: "#292929")
        topCoinLabel.font = UIFont(name: "Lexend-Bold", size: 14)
        view.addSubview(topCoinLabel)
        topCoinLabel.snp.makeConstraints {
            $0.centerY.equalTo(setttBtn)
            $0.right.equalTo(-18)
            $0.height.greaterThanOrEqualTo(35)
            $0.width.greaterThanOrEqualTo(25)
        }
        //
        let coinImageV = UIImageView()
        coinImageV.image = UIImage(named: "vip_ic")
        coinImageV.contentMode = .scaleAspectFit
        view.addSubview(coinImageV)
        coinImageV.snp.makeConstraints {
            $0.centerY.equalTo(setttBtn)
            $0.right.equalTo(topCoinLabel.snp.left).offset(-8)
            $0.width.equalTo(60/2)
            $0.height.equalTo(60/2)
        }
        //
        let storeBtn = UIButton(type: .custom)
        view.addSubview(storeBtn)
        storeBtn.snp.makeConstraints {
            $0.left.equalTo(coinImageV.snp.left)
            $0.right.equalTo(topCoinLabel.snp.right)
            $0.height.equalTo(44)
            $0.centerY.equalTo(topCoinLabel)
        }
        storeBtn.addTarget(self, action: #selector(storeBtnClick(sender:)), for: .touchUpInside)
        //
        let collBgView = UIView()
        collBgView.backgroundColor = .clear
        view.addSubview(collBgView)
        
        //
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collection = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled = true
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        collBgView.addSubview(collection)
        
        collection.register(cellWithClass: CyHHomeMainCell.self)
//        collection.isUserInteractionEnabled = false
        
        //
        let starBtn = UIButton(type: .custom)
        view.addSubview(starBtn)
        starBtn.backgroundColor = UIColor(hexString: "#FFD6EA")
        starBtn.setTitle("Begin  ", for: .normal)
        starBtn.setTitleColor(UIColor(hexString: "#E83289"), for: .normal)
        starBtn.titleLabel?.font = UIFont(name: "Lexend-Bold", size: 22)
        starBtn.layer.cornerRadius = 29
        starBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-45)
            $0.width.equalTo(236)
            $0.height.equalTo(58)
        }
        starBtn.addTarget(self, action: #selector(gostrartBtnClick(sender:)), for: .touchUpInside)
        //
        let arrowImgV = UIImageView(image: UIImage(named: "get_next_ic"))
        view.addSubview(arrowImgV)
        arrowImgV.snp.makeConstraints {
            $0.centerY.equalTo(starBtn)
            $0.right.equalTo(starBtn.snp.right).offset(-34)
            $0.width.height.equalTo(22)
        }
        
        //
        let infogBgView = UIView()
        view.addSubview(infogBgView)
        infogBgView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(100)
            $0.bottom.equalTo(starBtn.snp.top).offset(-25)
        }
        //
        //
        let infoLabel1 = UILabel()
        infogBgView.addSubview(infoLabel1)
        infoLabel1.font = UIFont(name: "Lexend-Bold", size: 28)
        infoLabel1.numberOfLines = 2
        infoLabel1.text = "WoW help you get a New Look in Seconds!"
        infoLabel1.textColor = .black
        infoLabel1.textAlignment = .center
        infoLabel1.snp.makeConstraints {
            $0.center.equalToSuperview()
            
            $0.left.equalTo(35)
            $0.height.greaterThanOrEqualTo(70)
        }
        //
        //
//        let infoLabel2 = UILabel()
//        infogBgView.addSubview(infoLabel2)
//        infoLabel2.numberOfLines = 0
//        infoLabel2.font = UIFont(name: "Lexend-Bold", size: 12)
//        infoLabel2.text = "Recommended You To Use After Before Breast Enhancement o Use After Before Breast En"
//        infoLabel2.textColor = UIColor(hexString: "#9196B6")
//        infoLabel2.textAlignment = .center
//        infoLabel2.snp.makeConstraints {
//            $0.centerX.equalToSuperview()
//            $0.top.equalTo(infoLabel1.snp.bottom).offset(18)
//            $0.left.equalTo(35)
//            $0.height.greaterThanOrEqualTo(30)
//        }
        //
        collBgView.snp.makeConstraints {
            $0.top.equalTo(setttBtn.snp.bottom).offset(8)
            $0.bottom.equalTo(infogBgView.snp.top)
            $0.left.right.equalToSuperview()
        }
        collection.snp.makeConstraints {
            $0.top.bottom.right.left.equalToSuperview()
        }
    }
    
    func setupSettingView() {
        
        view.addSubview(settingView)
        settingView.snp.makeConstraints {
            $0.bottom.top.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.left.equalTo(view.snp.right)
        }
        settingView.upVC = self
        settingView.loginBtnClickBlock = {
            DispatchQueue.main.async {
                [weak self] in
                guard let `self` = self else {return}
                self.settingView.snp.remakeConstraints {
                    $0.bottom.top.equalToSuperview()
                    $0.width.equalTo(UIScreen.main.bounds.width)
                    $0.left.equalTo(self.view.snp.right)
                }
                UIView.animate(withDuration: 0.35) {
                    self.view.layoutIfNeeded()
                }
            }
        }
        settingView.backBtnClickBlock = {
            DispatchQueue.main.async {
                [weak self] in
                guard let `self` = self else {return}
                self.settingView.snp.remakeConstraints {
                    $0.bottom.top.equalToSuperview()
                    $0.width.equalTo(UIScreen.main.bounds.width)
                    $0.left.equalTo(self.view.snp.right)
                }
                UIView.animate(withDuration: 0.35) {
                    self.view.layoutIfNeeded()
                }
            }
        }
        
    }
    
    @objc func scrollAutoAction() {
        DispatchQueue.main.async {
            [weak self] in
            guard let `self` = self else {return}
            self.currentPageIndex += 1
            if self.currentPageIndex < self.totalPage {
                self.collection.scrollToItem(at: IndexPath(item: self.currentPageIndex, section: 0), at: .centeredHorizontally, animated: true)
            } else {
                self.collection.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: false)
            }
            
        }
    }
    
    func setupTimerScroll() {
        
        
        let countdownTimer =  Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(scrollAutoAction), userInfo: nil, repeats: true)
        scrollTimer = countdownTimer
        
        
         
    }
    
    @objc func setttBtnClick(sender: UIButton) {
        settingView.updateUserAccountStatus()
        showSettingView()
    }
    @objc func storeBtnClick(sender: UIButton) {
        self.navigationController?.pushViewController(CyHStoreVC())
    }
    
    @objc func gostrartBtnClick(sender: UIButton) {
        let selectVVC = CyXBxingbieSelect()
        self.navigationController?.pushViewController(selectVVC)
    }
    
//
    func showSettingView() {
        self.settingView.snp.remakeConstraints {
            $0.bottom.top.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.left.equalTo(view.snp.left)
        }
        UIView.animate(withDuration: 0.35) {
            self.view.layoutIfNeeded()
        }
    }
   
}

extension CyHMainVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: CyHHomeMainCell.self, for: indexPath)
        
        let page = indexPath.item % 2
        
        if page == 0 {
            cell.contentImgV.image = UIImage(named: "woman_home_ic")
        } else {
            cell.contentImgV.image = UIImage(named: "man_home_ic")
        }
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalPage
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension CyHMainVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = UIScreen.main.bounds.width
        let height: CGFloat = collectionView.bounds.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension CyHMainVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
}






class CyHHomeMainCell: UICollectionViewCell {
    let contentImgV = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentImgV.contentMode = .scaleAspectFit
        contentImgV.clipsToBounds = true
        contentView.addSubview(contentImgV)
        contentImgV.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.top.equalTo(25)
            $0.right.bottom.equalTo(-25)
        }
        
        
    }
}

