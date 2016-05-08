//
//  ViewController.swift
//  TestViewAnimation
//
//  Created by Karma on 16/4/10.
//  Copyright © 2016年 陈昆涛. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var mFirstView: UIView!
    
    //记录mFirestViewd的位置参数
    @IBOutlet var mSecondView: UIView!
    var mOriginFrame : CGRect!
    var mOriginFrame2 : CGRect!
    
    var mFirstSubview : UIView!
    var mOriginFrameSubview : CGRect! =  CGRect(x: 30, y: 70, width: 20, height: 20)
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.mOriginFrame = self.mFirstView.frame
        self.mOriginFrame2 = self.mSecondView.frame
        
        self.mFirstSubview = UIView(frame: self.mOriginFrameSubview)
        self.mFirstSubview.backgroundColor = UIColor.yellowColor()
        self.view.addSubview(mFirstSubview)
        self.mOriginFrameSubview = self.mFirstSubview.frame
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func StartBtnClicked(sender: AnyObject) {
        UIView.animateWithDuration(1) { () -> Void in
//            self.basicAnimation()
//            self.optionAnimation()
//            self.beginCommitAnimate()
//            self.operateSbuview()
            self.replaceView()
        }
        
        
    }

    @IBAction func FallbackAnimation(sender: AnyObject) {
        self.mFirstView.frame = mOriginFrame
        //停止动画
        self.mFirstView.layer.removeAllAnimations()
        
        
        self.mSecondView.frame = mOriginFrame2
        self.mSecondView.layer.removeAllAnimations()
        
        self.mFirstSubview.frame = self.mOriginFrameSubview
    }
    func basicAnimation(){
        self.mFirstView.frame.origin.x += 100
     
        
    }
    func optionAnimation(){
        UIView.animateWithDuration(2.0, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
            self.mFirstView.frame.origin.x += 200
            //内嵌动画默认会继承外层函数的所有的属性 必须重写方法之后再进行修改
//            UIView.animateWithDuration(10.0, delay: 0.0, options: [UIViewAnimationOptions.OverrideInheritedCurve,UIViewAnimationOptions.CurveEaseOut,UIViewAnimationOptions.OverrideInheritedDuration], animations: { () -> Void in
//                self.mSecondView.frame.origin.x += 200
//                }, completion: { (finsh) -> Void in
//                    print("inner animate finished")
//            })
            UIView.animateWithDuration(10.0, delay: 0.0, options: [UIViewAnimationOptions.OverrideInheritedOptions], animations: { () -> Void in
                self.mSecondView.frame.origin.x += 200
                },  completion: { (finsh) -> Void in
                        print("inner animate finished")
                               })

            }) { (finish) -> Void in
                print("outter animation finished")
        }
    }
    func beginCommitAnimate(){
        //1.声明开始配置动画的属性
        UIView.beginAnimations("testAnimate", context: nil)
        UIView.setAnimationDuration(2.0)
        UIView.setAnimationRepeatAutoreverses(true)
        UIView.setAnimationRepeatCount(10)
        
        //设置动画开始和结束的回调函数
        UIView.setAnimationDelegate(self)
        UIView.setAnimationWillStartSelector("animationDidStart:")
        UIView.setAnimationDidStopSelector("animationDidStop:finshed:")
        
        //2.操作视图
        self.mFirstView.backgroundColor = UIColor.magentaColor()
        
        //3.提交动画
        UIView.commitAnimations()
    }
    override func animationDidStart(anim: CAAnimation) {
        print("Animation Start")
    }
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        print("Animation Stop")
    }
    func operateSbuview(){
        UIView.transitionWithView(self.mFirstView, duration: 2.0, options: [UIViewAnimationOptions.TransitionCurlUp,UIViewAnimationOptions.AllowAnimatedContent], animations: { () -> Void in
            self.mFirstSubview.frame.origin.x += 100
            }) { (finshed) -> Void in
                print(finshed)
        }
    }
    func replaceView(){
        let view = UIView(frame: CGRect(x: 50, y: 400, width: 200, height: 50))
        view.backgroundColor = UIColor.magentaColor()
        UIView.transitionFromView(self.mSecondView, toView: view, duration: 2.0, options: [UIViewAnimationOptions.TransitionCurlUp,UIViewAnimationOptions.AllowAnimatedContent]) { (finshed) -> Void in
            print("finshed")
        }
    }
}

