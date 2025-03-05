//
//  TheRouterControllerA.swift
//  TheRouter_Example
//
//  Created by mars.yao on 2023/7/27.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import TheRouter
import SnapKit


@objcMembers
class TheRouterControllerA: UIViewController {

    // 扫码完成回调
    @objc public var qrResultCallBack: TheRouerParamsClosureWrapper?
    
    @objc public var willAppearCallback: TheRouerParamsClosureWrapper?
    
    @objc var desc: String = ""
    
    @objc var id: String = ""
    
    @objc var name: String = ""
    
    @objc var value: String = ""

    private lazy var resultLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .black
        lb.font = UIFont.systemFont(ofSize: 15)
        lb.textAlignment = .center
        lb.numberOfLines = 0
        return lb
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let _resultCallBack = self.willAppearCallback?.closure else { return }
        _resultCallBack(["页面即将打开":"1"])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .orange
        self.view.addSubview(resultLabel)
    
        resultLabel.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(200)
            make.center.equalTo(self.view.center)
        }
        
        self.resultLabel.text = id + name + value + desc
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            
            guard let _resultCallBack = self.qrResultCallBack?.closure else { return }
            _resultCallBack(["扫码回调了":"1"])
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension TheRouterControllerA: TheRouterable {
    
    static var patternString: [String] {
        ["scheme://router/demo1"]
    }
}
