//
//  CAAnimationViewController.swift
//  TestViewAnimation
//
//  Created by Karma on 16/4/12.
//  Copyright © 2016年 陈昆涛. All rights reserved.
//

import UIKit

class CAAnimationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.grayColor()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func StartClicked(sender: AnyObject) {
//        self.testLayerProperty()
//        self.newBasicAnimate()
        self.keyFrameAnimate()
        
    }
    
    @IBAction func FallBackClicked(sender: AnyObject) {
    }

    @IBAction func StopClicked(sender: AnyObject) {
    }
    func testLayerProperty(){
        let myLayer = CALayer()
        myLayer.backgroundColor = UIColor.magentaColor().CGColor
        myLayer.borderColor = UIColor.yellowColor().CGColor
        myLayer.borderWidth  = 5.0
        
        //圆角半径
        myLayer.cornerRadius = 10.0
        myLayer.shadowColor = UIColor.purpleColor().CGColor
        myLayer.shadowOffset = CGSize(width: 25.0, height: 25.0)
        //透明度
        myLayer.shadowOpacity = 0.2
        
        myLayer.frame = CGRectMake(100, 100, 100, 100)
        self.view.layer.addSublayer(myLayer)
    }
    func newBasicAnimate(){
        let imgView = UIImageView(image: UIImage(named: "2.jpg"))
        imgView.frame = CGRectMake(100, 200, 150, 150)
        self.view.addSubview(imgView)
        
        //1.选定角色CALayer
        let layer = imgView.layer
        
        //2.写一个剧本CAAnimation
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        //缩小倍数
        scaleAnimation.fromValue  = 1.0
        //扩大倍数
        scaleAnimation.toValue = 1.5
        //是否连续放大缩小
        scaleAnimation.autoreverses = true
        scaleAnimation.repeatCount = MAXFLOAT
        scaleAnimation.duration = 2.0
        
        //写第二个透明的剧本
        let opaqueAnimation = CABasicAnimation(keyPath: "opacity")
        opaqueAnimation.fromValue = 0.0
        opaqueAnimation.toValue = 1.0
        opaqueAnimation.autoreverses = true
        opaqueAnimation.repeatCount = MAXFLOAT
        opaqueAnimation.duration = 2.0
        
        //3 把剧本交给演员开始动画
        layer.addAnimation(scaleAnimation, forKey: "scaleAnimate")
        layer.addAnimation(opaqueAnimation, forKey: "opaqueAnimate")
        
    }
    func keyFrameAnimate(){
        let imgView = UIImageView(image: UIImage(named: "2.jpg"))
        imgView.frame = CGRectMake(250, 200, 50, 50)
        self.view.addSubview(imgView)
        
        //1.选定演员
        let layer = imgView.layer
        
        //2.写剧本
        let keyAnimate = CAKeyframeAnimation(keyPath: "position")
        
        //3.设定关键帧
        let value0 = NSValue(CGPoint: layer.position)
        let value1 = NSValue(CGPoint: CGPointMake(layer.position.x, layer.position.y + 200))
        let value2 = NSValue(CGPoint: CGPointMake(layer.position.x - 150, layer.position.y + 200))
        let value3 = NSValue(CGPoint: CGPointMake(layer.position.x-150, layer.position.y)   )
        let value4 = NSValue(CGPoint: layer.position)
        keyAnimate.values = [value0,value1,value2,value3,value4]
        
        
        keyAnimate.autoreverses = false
        keyAnimate.repeatCount = MAXFLOAT
        keyAnimate.duration = 10.0
        
        //设置不同每段不同的运动曲线
        let tf0 = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        let tf1 = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        let tf2 = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        let tf3 = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        keyAnimate.timingFunctions = [tf0,tf1,tf2,tf3]
        
        //设置每段运动不同的时间
        keyAnimate.keyTimes = [0.0,0.5,0.6,0.7,1]
        //图片的翻转
        let scaleAni = CABasicAnimation(keyPath: "transform.scale.y")
        scaleAni.fromValue = 1.0
        scaleAni.toValue = 0.1
        scaleAni.autoreverses = true
        scaleAni.fillMode = kCAFillModeForwards
        scaleAni.repeatCount = MAXFLOAT
        scaleAni.duration = 0.3
        
        
        //4.start
        layer.addAnimation(keyAnimate, forKey: "keyAnimation")
        layer.addAnimation(scaleAni, forKey: "scale")
        
        
        
        
        
        
        
        
        
    }
}
