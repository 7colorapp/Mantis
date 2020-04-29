//
//  CustomizedCropToolBar.swift
//  MantisExample
//
//  Created by Echo on 4/26/20.
//  Copyright © 2020 Echo. All rights reserved.
//

import UIKit
import Mantis

class CustomizedCropToolbar: UIView, CropToolbarProtocol {    
    var heightForVerticalOrientationConstraint: NSLayoutConstraint?
    var widthForHorizonOrientationConstraint: NSLayoutConstraint?
    var delegate: CropToolbarDelegate?
    
    var fixedRatioSettingButton: UIButton?
    var cropButton: UIButton?
    var cancelButton: UIButton?
    
    var stackView: UIStackView?
    var config: CropToolbarConfig!
    
    func createToolbarUI(config: CropToolbarConfig) {
        self.config = config
        
        backgroundColor = .red
        
        cropButton = createOptionButton(withTitle: "Crop", andAction: #selector(crop))
        cancelButton = createOptionButton(withTitle: "Cancel", andAction: #selector(cancel))
        fixedRatioSettingButton = createOptionButton(withTitle: "Ratio", andAction: #selector(showRatioList))
        
        stackView = UIStackView()
        addSubview(stackView!)
        
        stackView?.translatesAutoresizingMaskIntoConstraints = false
        stackView?.alignment = .center
        stackView?.distribution = .fillEqually
        
        stackView?.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView?.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView?.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView?.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        stackView?.addArrangedSubview(cancelButton!)
        stackView?.addArrangedSubview(fixedRatioSettingButton!)
        stackView?.addArrangedSubview(cropButton!)
    }
    
    func adjustUIWhenOrientationChange() {
        if UIApplication.shared.statusBarOrientation.isPortrait {
            stackView?.axis = .horizontal
        } else {
            stackView?.axis = .vertical
        }
    }
            
    @objc private func crop() {
        delegate?.didSelectedCrop()
    }
    
    @objc private func cancel() {
        delegate?.didSelectedCancel()
    }
    
    @objc private func showRatioList() {
        delegate?.didSelectedetRatio()
    }
    
    private func createOptionButton(withTitle title: String?, andAction action: Selector) -> UIButton {
        let buttonColor = UIColor.white
        let buttonFontSize: CGFloat = (UIDevice.current.userInterfaceIdiom == .pad) ?
            config.optionButtonFontSizeForPad :
            config.optionButtonFontSize
        
        let buttonFont = UIFont.systemFont(ofSize: buttonFontSize)
        
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.titleLabel?.font = buttonFont
        
        if let title = title {
            button.setTitle(title, for: .normal)
            button.setTitleColor(buttonColor, for: .normal)
        }
        
        button.addTarget(self, action: action, for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)
        
        return button
    }
    
    func getRatioListPresentSourceView() -> UIView? {
        return fixedRatioSettingButton
    }
}
