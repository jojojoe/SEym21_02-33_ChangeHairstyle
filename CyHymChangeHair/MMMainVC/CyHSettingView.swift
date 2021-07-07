//
//  CyHSettingView.swift
//  CyHymChangeHair
//
//  Created by JOJO on 2021/7/2.
//

import UIKit
import MessageUI
import StoreKit
import Defaults
import NoticeObserveKit
import DeviceKit

let AppName: String = "WoW"
let purchaseUrl = ""
let TermsofuseURLStr = "https://www.app-privacy-policy.com/live.php?token=hE0JE1ZoKNhau4zAgyJSefAMU4Nk81H5"
let PrivacyPolicyURLStr = "https://www.app-privacy-policy.com/live.php?token=ceUjd0m14H7TJ0tqAZKPJhAmNILBCADZ"
let feedbackEmail: String = "ctuhjesin@yandex.com"
let AppAppStoreID: String = ""


class CyHSettingView: UIView {

    let userPlaceIcon = UIImageView(image: UIImage(named: "setting_head"))
    let userNameLabel = UILabel()
    let feedbackBtn = SettingContentBtn(frame: .zero, name: "Feedback", iconImage: UIImage(named: "feedback_bg_ic")!)
    let privacyLinkBtn = SettingContentBtn(frame: .zero, name: "Privacy Policy", iconImage: UIImage(named: "feedback_bg_ic")!)
    let termsBtn = SettingContentBtn(frame: .zero, name: "Terms of use", iconImage: UIImage(named: "feedback_bg_ic")!)
    let logoutBtn = SettingContentBtn(frame: .zero, name: "Log out", iconImage: UIImage(named: "log_out_bg_ic")!)
    let loginBtn = UIButton(type: .custom)
    let backBtn = UIButton(type: .custom)
    
    var upVC: UIViewController?
    var backBtnClickBlock: (()->Void)?
    var loginBtnClickBlock: (()->Void)?
    let contentBgView = UIView()
    let contentBgTopView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupContentView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

extension CyHSettingView {
    @objc func backBtnClick(sender: UIButton) {
        
        backBtnClickBlock?()
//        if self.navigationController != nil {
//            self.navigationController?.popViewController()
//        } else {
//            self.dismiss(animated: true, completion: nil)
//        }
    }
}

extension CyHSettingView {
    func setupView() {
        //
        addSubview(backBtn)
        backBtn.addTarget(self, action: #selector(backBtnClick(sender:)), for: .touchUpInside)
        backBtn.setImage(UIImage(named: "ic_back"), for: .normal)
        backBtn.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
        //
//        let namelabel = UILabel()
//        namelabel.font = UIFont(name: "Poppins-Bold", size: 18)
//        namelabel.textColor = UIColor(hexString: "#292929")
//        namelabel.textAlignment = .center
//        namelabel.text = "Setting"
//        view.addSubview(namelabel)
//        namelabel.adjustsFontSizeToFitWidth = true
//        namelabel.snp.makeConstraints {
//            $0.centerY.equalTo(backBtn)
//            $0.centerX.equalToSuperview()
//            $0.width.greaterThanOrEqualTo(1)
//            $0.height.greaterThanOrEqualTo(1)
//        }
        //
        
        contentBgView.backgroundColor = .white
        addSubview(contentBgView)
        contentBgView.snp.makeConstraints {
            $0.right.top.bottom.equalToSuperview()
            $0.width.equalTo(200)
        }
        contentBgView.layer.shadowColor = UIColor.black.withAlphaComponent(0.21).cgColor
        contentBgView.layer.shadowOffset = CGSize(width: -6, height: 0)
        contentBgView.layer.shadowRadius = 3
        contentBgView.layer.shadowOpacity = 0.8
        
        //
        //
        let contentBgTopViewTopView = UIView()
        contentBgTopViewTopView.backgroundColor = UIColor(hexString: "#FF3797")
        contentBgView.addSubview(contentBgTopViewTopView)
        contentBgTopViewTopView.snp.makeConstraints {
            $0.left.top.right.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.top)
        }
        //
        contentBgTopView.backgroundColor = UIColor(hexString: "#FF3797")
        contentBgView.addSubview(contentBgTopView)
        contentBgTopView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.top).offset(200)
        }
        
        contentBgTopView.addSubview(userPlaceIcon)
        userPlaceIcon.image = UIImage(named: "setting_ava_ic")
        userPlaceIcon.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-8)
            $0.width.height.equalTo(45)
        }
        
        //
        userNameLabel.font = UIFont(name: "Lexend-Bold", size: 14)
//        userNameLabel.layer.shadowColor = UIColor(hexString: "#292929")?.cgColor
//        userNameLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
//        userNameLabel.layer.shadowRadius = 3
//        userNameLabel.layer.shadowOpacity = 0.8
        userNameLabel.textColor = UIColor(hexString: "#FFFFFF")
        userNameLabel.textAlignment = .center
        userNameLabel.text = "Log in"
        contentBgTopView.addSubview(userNameLabel)
        userNameLabel.adjustsFontSizeToFitWidth = true
        userNameLabel.snp.makeConstraints {
            $0.top.equalTo(userPlaceIcon.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.left.equalTo(10)
            $0.height.greaterThanOrEqualTo(1)
        }
        //
        
        
    }
    @objc func loginBtnClick(sender: UIButton) {
        loginBtnClickBlock?()
        self.showLoginVC()
    }
    //
    func setupContentView() {
        addSubview(loginBtn)
        loginBtn.addTarget(self, action: #selector(loginBtnClick(sender:)), for: .touchUpInside)
         
        loginBtn.snp.makeConstraints {
            $0.left.right.equalTo(userPlaceIcon)
            $0.bottom.equalTo(userNameLabel.snp.bottom)
            $0.top.equalTo(userPlaceIcon.snp.top)
        }
        
        
        // feedback
        addSubview(feedbackBtn)
        feedbackBtn.clickBlock = {
            [weak self] in
            guard let `self` = self else {return}
            self.feedback()
        }
        feedbackBtn.snp.makeConstraints {
            $0.width.equalTo(140)
            $0.height.equalTo(44)
            $0.top.equalTo(contentBgTopView.snp.bottom).offset(24)
            $0.centerX.equalTo(contentBgTopView)
        }
        
//        if Device.current.diagonal == 4.7 || Device.current.diagonal > 7 {
//            feedbackBtn.snp.makeConstraints {
//                $0.width.equalTo(357)
//                $0.height.equalTo(64)
//                $0.top.equalTo(userNameLabel.snp.bottom).offset(27)
//                $0.centerX.equalToSuperview()
//            }
//        } else {
//            feedbackBtn.snp.makeConstraints {
//                $0.width.equalTo(357)
//                $0.height.equalTo(64)
//                $0.top.equalTo(userNameLabel.snp.bottom).offset(37)
//                $0.centerX.equalToSuperview()
//            }
//        }
        
        // privacy link
        addSubview(privacyLinkBtn)
        privacyLinkBtn.clickBlock = {
            [weak self] in
            guard let `self` = self else {return}
            UIApplication.shared.openURL(url: PrivacyPolicyURLStr)
        }
        privacyLinkBtn.snp.makeConstraints {
             
            $0.top.equalTo(feedbackBtn.snp.bottom).offset(18)
            $0.width.equalTo(140)
            $0.height.equalTo(44)
            $0.centerX.equalTo(contentBgTopView)
        }
        // terms
        
        addSubview(termsBtn)
        termsBtn.clickBlock = {
            [weak self] in
            guard let `self` = self else {return}
            UIApplication.shared.openURL(url: TermsofuseURLStr)
        }
        termsBtn.snp.makeConstraints {

            $0.top.equalTo(privacyLinkBtn.snp.bottom).offset(18)
            $0.width.equalTo(140)
            $0.height.equalTo(44)
            $0.centerX.equalTo(contentBgTopView)
        }
        
        // logout
        addSubview(logoutBtn)
        logoutBtn.clickBlock = {
            [weak self] in
            guard let `self` = self else {return}
            APLoginMana.shared.logout()
            self.updateUserAccountStatus()
        }
        logoutBtn.snp.makeConstraints {
            
            $0.top.equalTo(termsBtn.snp.bottom).offset(18)
            $0.width.equalTo(140)
            $0.height.equalTo(44)
            $0.centerX.equalTo(contentBgTopView)
        }
        
    }
    
    
}
extension CyHSettingView {
     
    
    func showLoginVC() {
        if APLoginMana.currentLoginUser() == nil {
            let loginVC = APLoginMana.shared.obtainVC()
            loginVC.modalTransitionStyle = .crossDissolve
            loginVC.modalPresentationStyle = .fullScreen
            
            self.upVC?.present(loginVC, animated: true) {
            }
        }
    }
    func updateUserAccountStatus() {
        if let userModel = APLoginMana.currentLoginUser() {
            let userName  = userModel.userName
            userNameLabel.text = (userName?.count ?? 0) > 0 ? userName : AppName
            logoutBtn.isHidden = false
            loginBtn.isHidden = true
//            loginBtn.isUserInteractionEnabled = false
            
        } else {
            userNameLabel.text = "Log in"
            logoutBtn.isHidden = true
            loginBtn.isHidden = false
//            loginBtn.isUserInteractionEnabled = true
            
        }
    }
}

extension CyHSettingView: MFMailComposeViewControllerDelegate {
    func feedback() {
        //首先要判断设备具不具备发送邮件功能
        if MFMailComposeViewController.canSendMail(){
            //获取系统版本号
            let systemVersion = UIDevice.current.systemVersion
            let modelName = UIDevice.current.modelName
            
            let infoDic = Bundle.main.infoDictionary
            // 获取App的版本号
            let appVersion = infoDic?["CFBundleShortVersionString"] ?? "8.8.8"
            // 获取App的名称
            let appName = "\(AppName)"

            
            let controller = MFMailComposeViewController()
            //设置代理
            controller.mailComposeDelegate = self
            //设置主题
            controller.setSubject("\(appName) Feedback")
            //设置收件人
            // FIXME: feed back email
            controller.setToRecipients([feedbackEmail])
            //设置邮件正文内容（支持html）
         controller.setMessageBody("\n\n\nSystem Version：\(systemVersion)\n Device Name：\(modelName)\n App Name：\(appName)\n App Version：\(appVersion )", isHTML: false)
            
            //打开界面
            self.upVC?.present(controller, animated: true, completion: nil)
        }else{
            HUD.error("The device doesn't support email")
        }
    }
    
    //发送邮件代理方法
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        
    }
 }




class SettingContentBtn: UIButton {
    var clickBlock: (()->Void)?
    var nameTitle: String
    var iconImage: UIImage
    init(frame: CGRect, name: String, iconImage: UIImage) {
        self.nameTitle = name
        self.iconImage = iconImage
        super.init(frame: frame)
        setupView()
        addTarget(self, action: #selector(clickAction(sender:)), for: .touchUpInside)
    }
    
    @objc func clickAction(sender: UIButton) {
        clickBlock?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.backgroundColor = .clear
//        self.layer.cornerRadius = 17
//        self.layer.borderWidth = 4
//        self.layer.borderColor = UIColor.black.cgColor
        
        
        //
        let iconImgV = UIImageView(image: iconImage)
        iconImgV.contentMode = .scaleAspectFit
        addSubview(iconImgV)
        iconImgV.snp.makeConstraints {
            $0.left.right.bottom.top.equalToSuperview()
        }
        //
        let nameLabel = UILabel()
        addSubview(nameLabel)
        nameLabel.text = nameTitle
        nameLabel.textAlignment = .center
        nameLabel.textColor = UIColor(hexString: "#E83289")
        if nameTitle == "Log out" {
            nameLabel.textColor = UIColor(hexString: "#707070")
        }
        
        nameLabel.font = UIFont(name: "Lexend-Bold", size: 14)
        nameLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.equalTo(15)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        
         
        
    }
    
}
