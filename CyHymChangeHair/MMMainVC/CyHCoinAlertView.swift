//
//  CyHCoinAlertView.swift
//  CyHymChangeHair
//
//  Created by JOJO on 2021/7/5.
//

import UIKit


class CyHCoinAlertView: UIView {

    
    var closeBtnBlock: (()->Void)?
    var okBtnBlock: (()->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        backgroundColor = UIColor.black.withAlphaComponent(0.9)
        
        let closeBtn = UIButton(type: .custom)
        closeBtn.alpha = 0.7
        closeBtn.setImage(UIImage(named: "close_popup_ic"), for: .normal)
        closeBtn.addTarget(self, action: #selector(closeBtnClick(sender:)), for: .touchUpInside)
        addSubview(closeBtn)
        closeBtn.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(15)
            $0.right.equalToSuperview().offset(-20)
            $0.width.height.equalTo(40)
        }
        
        //
        let contentBgView = UIView()
        contentBgView.backgroundColor = .white
        contentBgView.layer.cornerRadius = 32
        addSubview(contentBgView)
        contentBgView.snp.makeConstraints {
            $0.width.equalTo(240)
            $0.height.equalTo(155)
            $0.center.equalToSuperview()
        }
        
        //
        let icon = UIImageView()
        icon.contentMode = .center
        addSubview(icon)
        icon.image = UIImage(named: "popup_v_ic")
        icon.snp.makeConstraints {
            $0.centerY.equalTo(contentBgView.snp.top).offset(-1)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(174)
        }
        
        let titleLabel = UILabel(text: "It will cost \(FKbCoinMana.default.coinCostCount) coins to confirm the use of the paid item.")
        titleLabel.textColor = UIColor(hexString: "#171B2F")
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 3
        titleLabel.font = UIFont(name: "Lexend-Bold", size: 14)
        contentBgView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(contentBgView.snp.centerY).offset(-5)
            $0.width.equalTo(180)
            $0.height.greaterThanOrEqualTo(40)
        }
        
        // ok
        
        let okBtn = UIButton(type: .custom)
        addSubview(okBtn)
        okBtn.addTarget(self, action: #selector(okBtnClick(sender:)), for: .touchUpInside)
        okBtn.setBackgroundImage(UIImage(named: "popup_ok_bg_ic"), for: .normal)
        okBtn.setTitle("OK", for: .normal)
        okBtn.titleLabel?.font = UIFont(name: "Lexend-Bold", size: 16)
        okBtn.setTitleColor(UIColor.white, for: .normal)
        
        okBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(contentBgView.snp.bottom)
            $0.width.equalTo(193)
            $0.height.equalTo(61)
        }
        
    }

}

extension CyHCoinAlertView {
    
    @objc func closeBtnClick(sender: UIButton) {
        closeBtnBlock?()
    }
    @objc func okBtnClick(sender: UIButton) {
        okBtnBlock?()
    }
    
}


