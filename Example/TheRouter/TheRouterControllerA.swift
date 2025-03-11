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
    
    @objc var desc: String = ""

    private lazy var resultLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .black
        lb.font = UIFont.systemFont(ofSize: 15)
        lb.textAlignment = .center
        lb.numberOfLines = 0
        return lb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .orange
        self.view.addSubview(resultLabel)
    
        resultLabel.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(200)
            make.center.equalTo(self.view.center)
        }
        
        self.resultLabel.text = self.desc
        
        let button = UIButton(type: .custom)
        button.setTitle("去ControllerA", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 44)
        button.center = CGPoint(x: view.center.x, y: view.center.y + 200)
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        view.addSubview(button)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            
            guard let _resultCallBack = self.qrResultCallBack?.closure else { return }
            _resultCallBack(["扫码回调了":"1"])
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @objc
    func buttonAction(_ button: UIButton) {
        TheRouter.openURL("scheme://router/A")
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

// MARK: -  用于验证A->B->C-D,删除ABC三个栈的功能

class ControllerA: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "A"
        
        view.backgroundColor = .red
        
        let button = UIButton(type: .custom)
        button.setTitle("去ControllerB", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 44)
        button.center = view.center
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc
    func buttonAction(_ button: UIButton) {
        TheRouter.openURL("scheme://router/B")
    }
}

extension ControllerA: TheRouterable {
    
    static var patternString: [String] {
        ["scheme://router/A"]
    }

}

class ControllerB: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "B"
        
        view.backgroundColor = .green
        
        let button = UIButton(type: .custom)
        button.setTitle("去ControllerC", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 44)
        button.center = view.center
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc
    func buttonAction(_ button: UIButton) {
        TheRouter.openURL("scheme://router/C")
    }
}

extension ControllerB: TheRouterable {
    
    static var patternString: [String] {
        ["scheme://router/B"]
    }

}

class ControllerC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "C"
        
        view.backgroundColor = .orange
        
        let button = UIButton(type: .custom)
        button.setTitle("去ControllerD", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 44)
        button.center = view.center
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc
    func buttonAction(_ button: UIButton) {
        TheRouter.openURL("scheme://router/D", userInfo: [LARemovePatterns: ["scheme://router/B", "scheme://router/C"]])
    }
}

extension ControllerC: TheRouterable {
    
    static var patternString: [String] {
        ["scheme://router/C"]
    }

}

class ControllerD: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "D"
        
        view.backgroundColor = .randomColor
        
        let button = UIButton(type: .custom)
        button.setTitle("返回TheRouterControllerA", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 44)
        button.center = view.center
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc
    func buttonAction(_ button: UIButton) {
        TheRouter.openURL("scheme://router/demo1", userInfo: [LAJumpTypeKey: "2"])
    }
}

extension ControllerD: TheRouterable {
    
    static var patternString: [String] {
        ["scheme://router/D"]
    }

}

