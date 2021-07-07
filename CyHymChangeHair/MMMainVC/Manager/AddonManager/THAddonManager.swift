//
//  THAddonManager.swift
//  THymTryHair
//
//  Created by JOJO on 2021/2/25.
//

import UIKit
import Alertift


class THAddonManager: NSObject {

    static var `default` = THAddonManager()
    
    // sticker
    var addonStickersList: [THAddonHairTouchView] = []
    var currentStickerAddon: THAddonHairTouchView? = nil
    let stickerWidth = 240
    var removeStickerAddonActionBlock:(()->Void)?
    
    
    func clearAddonManagerDefaultStatus() {
        addonStickersList = []
        currentStickerAddon = nil
         
    }
    
    func cancelCurrentAddonHilightStatus() {
        if let currentSticker = currentStickerAddon {
            currentSticker.setHilight(false)
        }
         
    }
    
}

// sticker
extension THAddonManager {
    
    func addNewStickerAddonWithStickerImage(stickerImage: UIImage, hairItem: THymHairItem, atView stickerCanvasView:UIView) {
        
        cancelCurrentAddonHilightStatus()
        
        let stickerView: THAddonHairTouchView = THAddonHairTouchView.init(withImage:stickerImage , viewSize: CGSize.init(width: stickerWidth, height: stickerWidth))
        stickerView.center = CGPoint.init(x: stickerCanvasView.width() / 2, y: stickerCanvasView.height() / 2)
        addonStickersList.append(stickerView)
        currentStickerAddon = stickerView
        stickerCanvasView.addSubview(stickerView)
        stickerView.setHilight(true)
        stickerView.delegate = self
        stickerView.deleteActionBlock = { [weak self] contentTouchView in
            guard let `self` = self else { return }
            self.removeStickerTouchView(stickerTouchView: stickerView)
            
        }
        
        stickerView.hairItem = hairItem
        
    }
    
    
    func removeStickerTouchView(stickerTouchView: THAddonHairTouchView) {
        stickerTouchView.removeFromSuperview()
        addonStickersList.removeAll(stickerTouchView)
        currentStickerAddon = nil
        removeStickerAddonActionBlock?()
    }
    
}


extension THAddonManager: TouchStuffViewDelegate {
    
    func viewDoubleClick(_ sender: TouchStuffView!) {
        cancelCurrentAddonHilightStatus()
        sender.setHilight(true)
        
    }
    
    func viewSingleClick(_ sender: TouchStuffView!) {
        if sender.isHilightStatus == true {
            sender.setHilight(false)
        } else {
            cancelCurrentAddonHilightStatus()
            sender.setHilight(true)
        }
        
        let className = type(of: sender).description()
        
        if className.contains("THAddonHairTouchView") {
            let stickerAddon: THAddonHairTouchView = sender as! THAddonHairTouchView
            if addonStickersList.contains(stickerAddon) {
                currentStickerAddon = stickerAddon
            }
            stickerAddon.superview?.bringSubviewToFront(stickerAddon)
        }
        
    }
    
    func viewTouchUp(_ sender: TouchStuffView!) {
        
    }
    
}
