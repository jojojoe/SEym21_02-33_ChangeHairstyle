//
//  CyHEditVC.swift
//  CyHymChangeHair
//
//  Created by JOJO on 2021/7/5.
//

import UIKit
import Photos
import SwifterSwift


class CyHEditVC: UIViewController {

    var ageStr: String
    var sex: String
    var originImage: UIImage
    let bottomBanner = UIView()
    var hairBar: CviewHairBar?
    let filterBar = CviewFilterBar()
    let topBanner = UIView()
    let canvasBgView = UIView()
    
    let canvasContentView = UIView()
    let canvasImgView = UIImageView()
    var currentSelectFilterItem: GCFilterItem?
    var didLayoutSubviewOnce = Once()
    var isFliped: Bool = false
    var isCurrentEditing: Bool = false
    let coinAlertView = CyHCoinAlertView()
    var shouldCostCoin: Bool = false
    
    init(originImage: UIImage, ageStr: String, sex: String) {
        self.originImage = originImage
        self.ageStr = ageStr
        self.sex = sex
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupContentBar()
        setupCoinAlertView()
        
        setupDefaultStatus()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let canvasBgViewWidth: CGFloat = canvasBgView.bounds.size.width
        let canvasBgViewHeight: CGFloat = canvasBgView.bounds.size.height
        
        var originX: CGFloat = 0
        var originY: CGFloat = 0
        var canWidth: CGFloat = 0
        var canHeight: CGFloat = 0
        
        if originImage.size.width / originImage.size.height > canvasBgViewWidth / canvasBgViewHeight {
            canWidth = canvasBgViewWidth
            canHeight = canvasBgViewWidth * (originImage.size.height / originImage.size.width)
            originY = (canvasBgViewHeight - canHeight) / 2
        } else {
            canHeight = canvasBgViewHeight
            canWidth = canHeight * (originImage.size.width / originImage.size.height)
            originX = (canvasBgViewWidth - canWidth) / 2
        }
        
        canvasContentView.frame = CGRect(x: originX, y: originY, width: canWidth, height: canHeight)
        
    }
     
    func setupDefaultStatus() {
        canvasImgView.image = originImage 
        
    }

}

extension CyHEditVC {
    func setupView() {
        view.backgroundColor = UIColor(hexString: "#F1F1F1")
        //
        
        view.addSubview(topBanner)
        topBanner.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top).offset(56)
        }
        
        //
        let padding: CGFloat = (UIScreen.main.bounds.width - 10 * 2 - 44 * 4 - 0.5) / 3
        //
        let backBtn = UIButton(type: .custom)
        topBanner.addSubview(backBtn)
        backBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(10)
            $0.width.height.equalTo(44)
        }
        backBtn.setImage(UIImage(named: "hairstyle_black_button"), for: .normal)
        backBtn.addTarget(self, action: #selector(backBtnClick(sender:)), for: .touchUpInside)
        //
        let filterBtn = UIButton(type: .custom)
        topBanner.addSubview(filterBtn)
        filterBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(backBtn.snp.right).offset(padding)
            $0.width.height.equalTo(44)
        }
        filterBtn.setImage(UIImage(named: "hairstyle_filter_button"), for: .normal)
        filterBtn.addTarget(self, action: #selector(filterBtnClick(sender:)), for: .touchUpInside)
        //
        let flipBtn = UIButton(type: .custom)
        topBanner.addSubview(flipBtn)
        flipBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(filterBtn.snp.right).offset(padding)
            $0.width.height.equalTo(44)
        }
        flipBtn.setImage(UIImage(named: "hairstyle_contrast_button"), for: .normal)
        flipBtn.addTarget(self, action: #selector(flipBtnClick(sender:)), for: .touchUpInside)
        //
        let downloadBtn = UIButton(type: .custom)
        topBanner.addSubview(downloadBtn)
        downloadBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalTo(-10)
            $0.width.height.equalTo(44)
        }
        downloadBtn.setImage(UIImage(named: "hairstyle_download_button"), for: .normal)
        downloadBtn.addTarget(self, action: #selector(downloadBtnClick(sender:)), for: .touchUpInside)
        //
        
        view.addSubview(bottomBanner)
        bottomBanner.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-156)
        }
        
        //
        canvasBgView.backgroundColor = UIColor(hexString: "#F1F1F1")
        view.addSubview(canvasBgView)
        canvasBgView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(topBanner.snp.bottom)
            $0.bottom.equalTo(bottomBanner.snp.top)
        }
        //
        canvasBgView.addSubview(canvasContentView)
        canvasContentView.clipsToBounds = true
        //
        canvasContentView.addSubview(canvasImgView)
        canvasImgView.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        canvasImgView.contentMode = .scaleAspectFit
        
    }
    
    func setupContentBar() {
        hairBar = CviewHairBar(frame: .zero, sexName: self.sex, ageString: self.ageStr)
        guard let hairBar = hairBar else { return }
        bottomBanner.addSubview(hairBar)
        hairBar.snp.makeConstraints {
            $0.left.right.top.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        hairBar.didClickItemBlock = {
            [weak self] item in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.selectHairItem(item: item)
            }
        }
        //
        filterBar.isHidden = true
        filterBar.originalImage = originImage.scaled(toWidth: 150)
        view.addSubview(filterBar)
        filterBar.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(topBanner.snp.bottom)
            $0.height.equalTo(85)
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            DispatchQueue.main.async {
                [weak self] in
                guard let `self` = self else {return}
                self.filterBar.roundCorners([.bottomLeft, .bottomRight], radius: 6)
            }
        }
        filterBar.didSelectFilterItemBlock = {
            [weak self] item in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                [weak self] in
                guard let `self` = self else {return}
                self.changeFilter(item: item)
            }
        }
    }
    
    func setupCoinAlertView() {
        
        coinAlertView.alpha = 0
        view.addSubview(coinAlertView)
        coinAlertView.snp.makeConstraints {
            $0.left.right.bottom.top.equalToSuperview()
        }
        coinAlertView.okBtnBlock = {
            [weak self] in
            guard let `self` = self else {return}
            
            if FKbCoinMana.default.coinCount >= FKbCoinMana.default.coinCostCount {
                DispatchQueue.main.async {
                    self.shouldCostCoin = true
                    self.downloadImage()
                }
            } else {
                DispatchQueue.main.async {
                    self.showAlert(title: "", message: "Insufficient coins, please buy first.", buttonTitles: ["OK"], highlightedButtonIndex: 0) { i in
                        DispatchQueue.main.async {
                            [weak self] in
                            guard let `self` = self else {return}
                            self.navigationController?.pushViewController(CyHStoreVC())
                        }
                    }
                }
            }
            UIView.animate(withDuration: 0.25) {
                self.coinAlertView.alpha = 0
            }
        }
        coinAlertView.closeBtnBlock = {
            [weak self] in
            guard let `self` = self else {return}
            UIView.animate(withDuration: 0.25) {
                self.coinAlertView.alpha = 0
            }
        }
    }
    
    @objc func backBtnClick(sender: UIButton) {
        if currentSelectFilterItem != nil || THAddonManager.default.addonStickersList.count >= 1 || isFliped == true  {
            isCurrentEditing = true
        } else {
            isCurrentEditing = false
        }
        
        if isCurrentEditing == true {
            showAlert(title: "Are you sure to quit?", message: "", buttonTitles: ["Cancel", "Ok"], highlightedButtonIndex: 1) { (index) in
                if index == 1 {
                    DispatchQueue.main.async {
                        [weak self] in
                        guard let `self` = self else {return}
                        if self.navigationController == nil {
                            self.dismiss(animated: true, completion: nil)
                        } else {
                            self.navigationController?.popViewController()
                        }
                        
                        THAddonManager.default.cancelCurrentAddonHilightStatus()
                        THAddonManager.default.clearAddonManagerDefaultStatus()
                    }
                }
            }
        } else {
            if self.navigationController == nil {
                self.dismiss(animated: true, completion: nil)
            } else {
                self.navigationController?.popViewController()
            }
            THAddonManager.default.cancelCurrentAddonHilightStatus()
            THAddonManager.default.clearAddonManagerDefaultStatus()
        }
        
    }
    
    @objc func filterBtnClick(sender: UIButton) {
        THAddonManager.default.cancelCurrentAddonHilightStatus()
        if filterBar.isHidden == true {
            showFilterBarStatus(isShow: true)
        } else {
            showFilterBarStatus(isShow: false)
        }
    }
    @objc func flipBtnClick(sender: UIButton) {
        THAddonManager.default.cancelCurrentAddonHilightStatus()
        isFliped = !isFliped
        self.canvasImgView.image = self.canvasImgView.image?.sd_flippedImage(withHorizontal: true, vertical: false)
    }
    @objc func downloadBtnClick(sender: UIButton) {
        THAddonManager.default.cancelCurrentAddonHilightStatus()
        
        var isProVip = false
        
        if let stickerView =  THAddonManager.default.addonStickersList.first {
            if stickerView.hairItem?.isPro == true {
                isProVip = true
            }
        }
        
        if isProVip {
            // 收费
            self.view.bringSubviewToFront(self.coinAlertView)
            UIView.animate(withDuration: 0.35) {
                self.coinAlertView.alpha = 1
            }
        } else {
            downloadImage()
        }
        
    }
    
}

extension CyHEditVC {
    func showFilterBarStatus(isShow: Bool) {
        filterBar.isHidden = !isShow
        if isShow {
            view.bringSubviewToFront(filterBar)
        } else {
            
        }
    }
    func changeFilter(item: GCFilterItem) {
        currentSelectFilterItem = item
        if let filteredImg = THDataManager.default.filterOriginalImage(image: self.originImage, lookupImgNameStr: item.imageName) {
            
            if isFliped == true {
                self.canvasImgView.image = filteredImg.sd_flippedImage(withHorizontal: true, vertical: false)
            } else {
                self.canvasImgView.image = filteredImg
            }
        }
    }
    
    func selectHairItem(item: THymHairItem) {
        guard let hairImage = UIImage(named: item.big ?? "") else {return}
        let hairImage_m = hairImage
        if let stickerView =  THAddonManager.default.addonStickersList.first {
            stickerView.contentImageview.image = hairImage_m
            stickerView.hairItem = item
        } else {
            THAddonManager.default.addNewStickerAddonWithStickerImage(stickerImage: hairImage_m, hairItem: item, atView: self.canvasContentView)
        }
        
    }
    
    func downloadImage() {
        
        if let image = canvasContentView.screenshot {
            saveToAlbumPhotoAction(images: [image])
        }
    }
    
    func saveToAlbumPhotoAction(images: [UIImage]) {
        DispatchQueue.main.async(execute: {
            PHPhotoLibrary.shared().performChanges({
                [weak self] in
                guard let `self` = self else {return}
                for img in images {
                    PHAssetChangeRequest.creationRequestForAsset(from: img)
                }
                
            }) { (finish, error) in
                if finish {
                    DispatchQueue.main.async {
                        [weak self] in
                        guard let `self` = self else {return}
                        self.showSaveSuccessAlert()
                        if self.shouldCostCoin {
                            FKbCoinMana.default.costCoin(coin: FKbCoinMana.default.coinCostCount)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        [weak self] in
                        guard let `self` = self else {return}
                        if error != nil {
                            let auth = PHPhotoLibrary.authorizationStatus()
                            if auth != .authorized {
                                self.showDenideAlert()
                            }
                        }
                    }
                }
            }
        })
    }
    
    func showSaveSuccessAlert() {
        HUD.success("Picture saved successfully!")
    }

    func showDenideAlert() {
        DispatchQueue.main.async {
            [weak self] in
            guard let `self` = self else {return}
            let alert = UIAlertController(title: "Oops", message: "You have declined access to photos, please active it in Settings>Privacy>Photos.", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "Ok", style: .default, handler: { (goSettingAction) in
                DispatchQueue.main.async {
                    let url = URL(string: UIApplication.openSettingsURLString)!
                    UIApplication.shared.open(url, options: [:])
                }
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(confirmAction)
            alert.addAction(cancelAction)
            
            self.present(alert, animated: true)
        }
    }
}

