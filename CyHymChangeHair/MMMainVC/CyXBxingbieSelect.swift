//
//  CyXBxingbieSelect.swift
//  CyHymChangeHair
//
//  Created by JOJO on 2021/7/5.
//

import UIKit
import Photos
import YPImagePicker


class CyXBxingbieSelect: UIViewController, UINavigationControllerDelegate {

    let ageRefreshBtn = UIButton(type: .custom)
    let pickerBgView = UIView()
    let agePicker = UIPickerView()
    let pickerBtnSureBtn = UIButton(type: .custom)
    let maleBtn = UIButton(type: .custom)
    let femaleBtn = UIButton(type: .custom)
    let setAgeBtn = UIButton(type: .custom)
    let alertLabel = UILabel()
    let okBtn = UIButton(type: .custom)
    
    var currentAge: String = "20"
    var ageList: [String] = []
    var hasSetAgeSex: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupView()
        setupPickerview()
        setupdefaultStatus()
        if let item = ageList.firstIndex(of: currentAge) {
            agePicker.selectRow(Int(item), inComponent: 0, animated: false)
        }
    }
    
    func setupdefaultStatus() {
        ageRefreshBtn.isHidden = true
        alertLabel.isHidden = true
        okBtn.isSelected = false
        pickerBgView.isHidden = true
    }
    
    func loadData() {
        ageList = []
        for age in 14...85 {
            ageList.append("\(age)")
        }
    }

    func setupView() {
        view.backgroundColor = .white
        let closeBtn = UIButton(type: .custom)
        view.addSubview(closeBtn)
        closeBtn.setImage(UIImage(named: "log_in_close_jic"), for: .normal)
        closeBtn.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.right.equalTo(-10)
            $0.width.height.equalTo(44)
        }
        closeBtn.addTarget(self, action: #selector(closeBtnClick(sender:)), for: .touchUpInside)
        
        //
        
        okBtn.layer.cornerRadius = 32
        okBtn.layer.masksToBounds = true
        view.addSubview(okBtn)
        okBtn.setBackgroundColor(UIColor(hexString: "#BEBEBE")!, for: .normal)
        okBtn.setTitleColor(UIColor.white, for: .normal)
        okBtn.titleLabel?.font = UIFont(name: "Lexend-Bold", size: 22)
        okBtn.setTitle("OK", for: .normal)
        
        okBtn.setBackgroundColor(UIColor(hexString: "#000000")!, for: .selected)
        okBtn.setTitleColor(UIColor.white, for: .selected)
        okBtn.addTarget(self, action: #selector(okBtnClick(sender:)), for: .touchUpInside)
        okBtn.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-35)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(64)
        }
        
        //
        

        alertLabel.font = UIFont(name: "Lexend-Medium", size: 12)
        alertLabel.textColor = UIColor(hexString: "#FF889D")
        alertLabel.text = "* Please select gender and age"
        view.addSubview(alertLabel)
        alertLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(okBtn.snp.top).offset(-15)
            $0.width.greaterThanOrEqualTo(1)
            $0.height.greaterThanOrEqualTo(15)
        }
        
        //

        setAgeBtn.backgroundColor = UIColor(hexString: "#E8E8E8")
        setAgeBtn.setTitleColor(UIColor.black, for: .normal)
        setAgeBtn.setImage(UIImage(named: "set_age_ic"), for: .normal)
        setAgeBtn.setTitle("Set Age", for: .normal)
        setAgeBtn.titleLabel?.font = UIFont(name: "Lexend-Bold", size: 12)
        setAgeBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        setAgeBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        setAgeBtn.addTarget(self, action: #selector(setAgeBtnClick(sender:)), for: .touchUpInside)
        setAgeBtn.layer.cornerRadius = 17
        view.addSubview(setAgeBtn)
        setAgeBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(alertLabel.snp.top).offset(-8)
            $0.width.equalTo(138)
            $0.height.equalTo(34)
        }
        
         
        //
        
        ageRefreshBtn.backgroundColor = UIColor(hexString: "#FF3797")
        ageRefreshBtn.setTitleColor(UIColor.white, for: .normal)
        ageRefreshBtn.setTitle("Age: \(currentAge)", for: .normal)
        ageRefreshBtn.titleLabel?.font = UIFont(name: "Lexend-Bold", size: 12)
        ageRefreshBtn.layer.cornerRadius = 17
        view.addSubview(ageRefreshBtn)
        ageRefreshBtn.snp.makeConstraints {
            $0.center.equalTo(setAgeBtn)
            $0.width.height.equalTo(setAgeBtn)
        }
        ageRefreshBtn.addTarget(self, action: #selector(ageRefreshBtnClick(sender:)), for: .touchUpInside)
        let ageRefreshImgV = UIImageView(image: UIImage(named: "age_change_ic"))
        ageRefreshBtn.addSubview(ageRefreshImgV)
        ageRefreshImgV.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalTo(-13)
            $0.width.height.equalTo(11)
        }
        
        //
        let topBgView = UIView()
        view.addSubview(topBgView)
        topBgView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(closeBtn.snp.bottom)
            $0.bottom.equalTo(setAgeBtn.snp.top)
        }
        //

        topBgView.addSubview(femaleBtn)
        femaleBtn.setImage(UIImage(named: "female_no_ic"), for: .normal)
        femaleBtn.setImage(UIImage(named: "female_yes_ic"), for: .selected)
        femaleBtn.addTarget(self, action: #selector(femaleBtnClick(sender:)), for: .touchUpInside)
        femaleBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(topBgView.snp.centerY).offset(-3)
            $0.width.equalTo(440/2)
            $0.height.equalTo(408/2)
        }
        //

        topBgView.addSubview(maleBtn)
        maleBtn.setImage(UIImage(named: "male_no_ic"), for: .normal)
        maleBtn.setImage(UIImage(named: "male_yes_ic"), for: .selected)
        maleBtn.addTarget(self, action: #selector(maleBtnClick(sender:)), for: .touchUpInside)
        maleBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(topBgView.snp.centerY).offset(3)
            $0.width.equalTo(440/2)
            $0.height.equalTo(408/2)
        }
        //
        
        
    }
    
    func setupPickerview() {
        pickerBgView.layer.cornerRadius = 28
        view.addSubview(pickerBgView)
        pickerBgView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-12)
            $0.left.equalTo(10)
            $0.height.equalTo(270)
        }
        pickerBgView.backgroundColor = .black
        //

        pickerBgView.addSubview(pickerBtnSureBtn)
        pickerBtnSureBtn.snp.makeConstraints {
            $0.bottom.equalTo(-12)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(323)
            $0.height.equalTo(54)
        }
        pickerBtnSureBtn.layer.cornerRadius = 27
        pickerBtnSureBtn.backgroundColor = .white
        pickerBtnSureBtn.setTitleColor(UIColor.black, for: .normal)
        pickerBtnSureBtn.titleLabel?.font = UIFont(name: "Lexend-Bold", size: 22)
        pickerBtnSureBtn.setTitle("Sure", for: .normal)
        pickerBtnSureBtn.addTarget(self, action: #selector(agePickerBtnClick(sender:)), for: .touchUpInside)
        //
        
        agePicker.dataSource = self
        agePicker.delegate = self
        pickerBgView.addSubview(agePicker)
        agePicker.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.equalToSuperview().offset(20)
            $0.bottom.equalTo(pickerBtnSureBtn.snp.top).offset(-12)
        }
        
        
    }
    
    
    @objc func closeBtnClick(sender: UIButton) {
        if self.navigationController != nil {
            self.navigationController?.popViewController()
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    @objc func setAgeBtnClick(sender: UIButton) {
        pickerBgView.isHidden = false
    }
    @objc func ageRefreshBtnClick(sender: UIButton) {
        pickerBgView.isHidden = false
    }
    @objc func femaleBtnClick(sender: UIButton) {
        femaleBtn.isSelected = true
        maleBtn.isSelected = false
        checkAlertlabelStatusIsOk()
    }
    @objc func maleBtnClick(sender: UIButton) {
        femaleBtn.isSelected = false
        maleBtn.isSelected = true
        checkAlertlabelStatusIsOk()
    }
    @objc func agePickerBtnClick(sender: UIButton) {
        pickerBgView.isHidden = true
        ageRefreshBtn.isHidden = false
        setAgeBtn.isHidden = true
        checkAlertlabelStatusIsOk()
        self.ageRefreshBtn.setTitle("Age: \(self.currentAge)", for: .normal)
        
    }
    
    @objc func okBtnClick(sender: UIButton) {
        if okBtn.isSelected {
            // show edit vc
            checkAlbumAuthorization()
            
        } else {
            alertLabel.isHidden = false
        }
    }
    
    
    func checkAlertlabelStatusIsOk() -> Bool {
        var hasSetSex: Bool = true
        
        if femaleBtn.isSelected == false && maleBtn.isSelected == false {
            hasSetSex = false
        }
        
        if setAgeBtn.isHidden == false || hasSetSex == false {
            // 没设置age 没设置性别
//            alertLabel.isHidden = false
            okBtn.isSelected = false
            return false
        } else {
            alertLabel.isHidden = true
            okBtn.isSelected = true
            return true
        }
    }
    
    
}


extension CyXBxingbieSelect: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ageList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 200
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let agestr = ageList[row]
        
        let attrStr = NSAttributedString(string: agestr, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18), .foregroundColor : UIColor.white])
        return attrStr
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let agestr = ageList[row]
        currentAge = agestr
    }
    
    
}

extension CyXBxingbieSelect: UIImagePickerControllerDelegate {
    
    func checkAlbumAuthorization() {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                switch status {
                case .authorized:
                    DispatchQueue.main.async {
                        self.presentPhotoPickerController()
                    }
                case .limited:
                    DispatchQueue.main.async {
                        self.presentLimitedPhotoPickerController()
                    }
                case .notDetermined:
                    if status == PHAuthorizationStatus.authorized {
                        DispatchQueue.main.async {
                            self.presentPhotoPickerController()
                        }
                    } else if status == PHAuthorizationStatus.limited {
                        DispatchQueue.main.async {
                            self.presentLimitedPhotoPickerController()
                        }
                    }
                case .denied:
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
                    
                case .restricted:
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
                default: break
                }
            }
        }
    }
    
    func presentLimitedPhotoPickerController() {
        var config = YPImagePickerConfiguration()
        config.library.maxNumberOfItems = 1
        config.screens = [.library]
        config.library.defaultMultipleSelection = false
        config.library.skipSelectionsGallery = true
        config.showsPhotoFilters = false
        config.library.preselectedItems = nil
        let picker = YPImagePicker(configuration: config)
        picker.didFinishPicking { [unowned picker] items, cancelled in
            var imgs: [UIImage] = []
            for item in items {
                switch item {
                case .photo(let photo):
                    if let img = photo.image.scaled(toWidth: 1200) {
                        imgs.append(img)
                    }
                    print(photo)
                case .video(let video):
                    print(video)
                }
            }
            picker.dismiss(animated: true, completion: nil)
            if !cancelled {
                if let image = imgs.first {
                    self.showEditVC(image: image)
                }
            }
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    
    
//    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//        picker.dismiss(animated: true, completion: nil)
//        var imgList: [UIImage] = []
//
//        for result in results {
//            result.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { (object, error) in
//                if let image = object as? UIImage {
//                    DispatchQueue.main.async {
//                        // Use UIImage
//                        print("Selected image: \(image)")
//                        imgList.append(image)
//                    }
//                }
//            })
//        }
//        if let image = imgList.first {
//            self.showEditVC(image: image)
//        }
//    }
    
 
    func presentPhotoPickerController() {
        let myPickerController = UIImagePickerController()
        myPickerController.allowsEditing = false
        myPickerController.delegate = self
        myPickerController.sourceType = .photoLibrary
        self.present(myPickerController, animated: true, completion: nil)

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.showEditVC(image: image)
        } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.showEditVC(image: image)
        }

    }
//
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func showEditVC(image: UIImage) {
        var sexName = "male"
        if femaleBtn.isSelected == true {
            sexName = "female"
        }
        let editVC = CyHEditVC(originImage: image, ageStr: currentAge, sex: sexName)
        
        self.navigationController?.pushViewController(editVC)
    }

}



