//
//  CenterAlterController.swift
//  BaseProject
//
//  Created by 郑桂杰 on 2019/7/26.
//  Copyright © 2019 Sunsgne. All rights reserved.
//

import UIKit
import JJKit

extension CenterAlterController {
    
    /// 显示单个按钮的弹窗--- 为了OC调用，因为oc无法调用初始化方法........(无奈)
    ///
    /// - Parameters:
    ///   - title: 弹窗标题
    ///   - message: 弹窗内容
    ///   - buttonTitle: 按钮标题
    ///   - isDis: 点击按钮时弹窗是否dismiss
    ///   - controller: 从哪个控制器显示的
    ///   - action: 按钮action
    @objc static func showSingleButton(title: String?, message: NSAttributedString?, buttonTitle: String, dismissWhenClick isDis: Bool = true, from controller: UIViewController, action: (() -> ())?) {
        let alertVC = CenterAlterController(title: title, message: message, cancelConfig: nil, okConfig: (buttonTitle, isDis, action))
        let ccc = AlertPresentationController(show: alertVC, from: controller) { ctx in
            ctx.touchedCorverDismiss = false
        }
        alertVC.transitioningDelegate = ccc
        controller.present(alertVC, animated: true, completion: nil)
    }
    
    /// 显示两个个按钮的弹窗--- 为了OC调用，因为oc无法调用初始化方法........(无奈)
    ///
    /// - Parameters:
    ///   - title: 弹窗标题
    ///   - message: 弹窗内容
    ///   - controller: 从哪个控制器显示的
    ///   - leftButtonTitle: 左边按钮标题
    ///   - leftAction: 左边按钮antion
    ///   - rightButtonTitle: 右边按钮标题
    ///   - isDis: 点击右边按钮时弹窗是否dismiss
    ///   - rightAction: 右边按钮antion
    @objc static func showDoubleButton(title: String?, message: NSAttributedString?, from controller: UIViewController, leftButtonTitle: String, leftAction: (() -> ())? = nil, rightButtonTitle: String, dismissWhenClick isDis: Bool = true, rightAction: (() -> ())?) {
        let alertVC = CenterAlterController(title: title, message: message, cancelConfig: (leftButtonTitle, leftAction), okConfig: (rightButtonTitle, isDis, rightAction))
        let ccc = AlertPresentationController(show: alertVC, from: controller)
        alertVC.transitioningDelegate = ccc
        controller.present(alertVC, animated: true, completion: nil)
    }
    /// 显示提示登录界面
    ///
    /// - Parameter controller: 从哪个控制器显示的
    @objc static func showNoLogin(from controller: UIViewController) {
        let login: () -> () = { [unowned controller] in
            controller.present(UINavigationController(rootViewController: LoginViewController()), animated: true, completion: nil)
        }
        let alertVC = CenterAlterController(title: "请先登录再操作", message: nil, cancelConfig: ("取消", nil), okConfig: ("登录", true, login))
        let ccc = AlertPresentationController(show: alertVC, from: controller)
        alertVC.transitioningDelegate = ccc
        controller.present(alertVC, animated: true, completion: nil)
    }
    
    /// 显示版本更新
    ///
    /// - Parameters:
    ///   - content: 更新内容
    ///   - url: 更新url
    ///   - isForce: 是否强制更新
    ///   - controller: 从哪个控制器显示的
    @objc static func showUpdateVersion(content: String, url: String, isForce: Bool, from controller: UIViewController) {
        guard let updateURL = URL(string: url) else { return }
        let gotoUpdate: () -> () = {
            UIApplication.shared.openURL(updateURL)
        }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        let contentAtt = NSAttributedString(string: content, attributes: [.font: UIFont(style: .medium, size: 13), .foregroundColor: UIColor.f9, .paragraphStyle: paragraphStyle])
        let alertVC: CenterAlterController
        if isForce { // 强制更新
            alertVC = CenterAlterController(title: "版本更新", message: contentAtt, cancelConfig: nil, okConfig: ("更新", false, gotoUpdate))
        } else {
            alertVC = CenterAlterController(title: "版本更新", message: contentAtt, cancelConfig: ("取消", nil), okConfig: ("更新", true, gotoUpdate))
        }
        let ccc = AlertPresentationController(show: alertVC, from: controller) { ctx in
            ctx.touchedCorverDismiss = false
        }
        alertVC.transitioningDelegate = ccc
        controller.present(alertVC, animated: true, completion: nil)
    }
}


final class CenterAlterController: UIViewController {
    init(title: String?, message: NSAttributedString?, cancelConfig: (String, (() -> ())?)?, okConfig: (String, Bool, (() -> ())?)?) {
        self.altertitle = title
        self.message = message
        self.cancelConfig = cancelConfig
        self.okConfig = okConfig
        hasCancelButton = cancelConfig != nil
        hasOkButton = okConfig != nil
        super.init(nibName: nil, bundle: nil)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let altertitle: String?
    private let message: NSAttributedString?
    private let cancelConfig: (String, (() -> ())?)?
    private let okConfig: (String, Bool, (() -> ())?)?
    private let hasCancelButton: Bool
    private let hasOkButton: Bool
    private lazy var titleLabel = UILabel().jj.config {
        $0.textAlignment = .center
        $0.textColor = .f3
        $0.font = UIFont(style: .regular, size: 18)
        $0.numberOfLines = 0
    }
    private lazy var contentLabel = UILabel().jj.config {
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    private lazy var lineLayer = CALayer().jj.config {
        $0.backgroundColor = UIColor(hexString: "#E1E1E1")?.cgColor
    }
    private lazy var cancelButton = UIButton().jj.config {
        $0.setTitleColor(.f6, for: [])
        $0.titleLabel?.font = UIFont(style: .medium, size: 14)
    }
    private lazy var okButton = UIButton().jj.config {
        $0.setTitleColor(.white, for: [])
        $0.titleLabel?.font = UIFont(style: .medium, size: 14)
    }
    private var preferSize = CGSize.zero
}

extension CenterAlterController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let space = 16.fit
        if altertitle != nil {
            titleLabel.jj.top = space
            contentLabel.jj.top = titleLabel.jj.bottom + 10.fit
        } else {
            titleLabel.jj.top = 0
            contentLabel.jj.top = 0
        }
        if message != nil {
            lineLayer.jj.top = contentLabel.jj.bottom + space
        } else {
            lineLayer.jj.top = contentLabel.jj.bottom
        }
        switch (hasCancelButton, hasOkButton) {
        case (true, true):
            cancelButton.jj.left(is: 15.fit).top(is: lineLayer.jj.bottom + 14.fit)
            okButton.jj.frame = cancelButton.frame.offsetBy(dx: 15.fit + cancelButton.jj.width, dy: 0)
        case (true, false):
            cancelButton.jj.centerX(is: view.jj.width * 0.5).top(is: lineLayer.jj.bottom + 14.fit)
        case (false, true):
            okButton.jj.centerX(is: view.jj.width * 0.5).top(is: lineLayer.jj.bottom + 14.fit)
        case (false, false):
            break
        }
    }
}

private extension CenterAlterController {
    func configUI() {
        let vw = UIScreen.main.bounds.width - 50.fit * 2
        var th: CGFloat = 0
        let space = 16.fit
        var totalHeight: CGFloat = 0
        if altertitle != nil {
            titleLabel.text = altertitle
            view.addSubview(titleLabel)
            let ts = titleLabel.sizeThatFits(CGSize(width: vw - space * 2, height: 120))
            titleLabel.jj.size(is: ts).centerX(is: vw * 0.5)
            th = ts.height
        }
        totalHeight = th > 0 ? (th + space + 10.fit) : 0
        var ch: CGFloat = 0
        if message != nil {
            contentLabel.attributedText = message
            view.addSubview(contentLabel)
            let cs = contentLabel.sizeThatFits(CGSize(width: vw - space * 2, height: 400))
            contentLabel.jj.height(is: cs.height).width(is: vw - space * 2).centerX(is: vw * 0.5)
            ch = cs.height
        }
        let chh = ch > 0 ? (ch + 10.fit * 2) : 0
        totalHeight += chh
        if hasCancelButton {
            cancelButton.setTitle(cancelConfig?.0 ?? "", for: [])
            cancelButton.addTarget(self, action: #selector(cancelAction), for: .primaryActionTriggered)
            view.addSubview(cancelButton)
        }
        if hasOkButton {
            okButton.setTitle(okConfig?.0 ?? "", for: [])
            okButton.addTarget(self, action: #selector(okAction), for: .primaryActionTriggered)
            view.addSubview(okButton)
        }
        if hasOkButton || hasCancelButton {
            lineLayer.jj.width(is: vw).height(is: 1)
            view.layer.addSublayer(lineLayer)
            totalHeight += 1
        }
        var bh: CGFloat = 0
        var bw: CGFloat = 0
        var bbottom: CGFloat = 0
        switch (hasCancelButton, hasOkButton) {
        case (false, false):
            bh = 0
            bw = 0
            bbottom = 0
        case (true, true):
            bh = 36.fit
            bw = (vw - 45.fit) * 0.5
            bbottom = 14.fit
        default:
            bh = 36.fit
            bw = vw - 30.fit
            bbottom = 14.fit
        }
        cancelButton.jj.width(is: bw).height(is: bh)
        cancelButton.setBackgroundImage(UIImage(color: UIColor(hexString: "#EEEEEE")!, size: cancelButton.jj.size)?.jj.apply(radius: bh * 0.5), for: [])
        okButton.jj.width(is: bw).height(is: bh)
        okButton.setBackgroundImage(UIImage.linerThemeImage(with: okButton.jj.size)?.jj.apply(radius: bh * 0.5), for: [])
        totalHeight += (bbottom * 2 + bh)
        preferredContentSize = CGSize(width: vw, height: totalHeight)
    }
    
    @IBAction func cancelAction() {
        dismiss(animated: true) { [weak self] in
            self?.cancelConfig?.1?()
        }
    }
    
    @IBAction func okAction() {
        guard let okc = okConfig else { return }
        if okc.1 {
            dismiss(animated: true) { [weak self] in
                self?.okConfig?.2?()
            }
            return
        }
        okConfig?.2?()
    }
}
