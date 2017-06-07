//
//  ViewController.swift
//  Inke_Swift3
//
//  Created by 张彦林 on 17/6/6.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var live: ZylCell!
    var playerView : UIView!
    var ijZylPlayer : IJKMediaPlayback!
    
    
    
    
    /**背景图片*/
    @IBOutlet weak var backImg: UIImageView!
    
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var btnGift: UIButton!
    
    @IBOutlet weak var btnLike: UIButton!
    /**加载文字*/
    @IBOutlet weak var loadLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
         dump(live)
        setBg()
        //设置播放
        setPlayView()
        
        bringBtnToFront()
        
    }
    
    func setPlayView() {
        //初始化一个空白的View
        self.playerView = UIView(frame: view.bounds)
        view.addSubview(self.playerView)
        
        //初始化IJ播放器的控制器和view
        ijZylPlayer = IJKFFMoviePlayerController(contentURLString: live.url, with: nil)
        let pv = ijZylPlayer.view!
        
         //将播放器view自适应后,加入容器
        pv.frame = playerView.bounds
        pv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        playerView.insertSubview(pv, at: 1)
        ijZylPlayer.scalingMode = .aspectFill
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !self.ijZylPlayer.isPlaying() {
            ijZylPlayer.prepareToPlay()
        }
    }
    
    func setBg() {
        let imgUrl = URL(string: live.portrait)
        backImg.kf.setImage(with: imgUrl)
        
        let blurEffect = UIBlurEffect(style: .light)
        let effectView = UIVisualEffectView(effect: blurEffect)
        effectView.frame = backImg.bounds
        backImg.addSubview(effectView)
    }
    
    func bringBtnToFront() {
         view.bringSubview(toFront: btnLike)
         view.bringSubview(toFront: btnBack)
         view.bringSubview(toFront: btnGift)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//点击返回
    @IBAction func clickBack(_ sender: UIButton) {
        ijZylPlayer.shutdown()
        
        self.navigationController?.popViewController(animated: true)
         navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    

//点击送礼物
    @IBAction func clickGift(_ sender: UIButton) {
        let duration = 3.0
        let car = UIImageView(image: #imageLiteral(resourceName: "porsche"))
        
        car.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        view.addSubview(car)
        
        
        let widthCar: CGFloat = 250
        let heightCar: CGFloat = 125
        
        //显示动画(送车特效)
        UIView.animate(withDuration: duration) { 
            car.frame = CGRect(x: self.view.center.x - widthCar/2, y: self.view.center.y - heightCar/2, width: widthCar, height: heightCar)
        }
        
        //3秒消失
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            UIView.animate(withDuration: duration, animations: { 
                car.alpha = 0
            }, completion: { (completion) in
                car.removeFromSuperview()
            })
        }
        
        //烟花特效
        let layerFw = CAEmitterLayer()
        view.layer.addSublayer(layerFw)
        emmitParticles(from: sender.center, emitter: layerFw, in: view)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration * 2) { 
            layerFw.removeFromSuperlayer()
        }
        
        
    }
    
//点击喜欢
    @IBAction func clickLike(_ sender: UIButton) {
        //爱心特效
        let heart = DMHeartFlyView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        heart.center = CGPoint(x: btnLike.frame.origin.x, y: btnLike.frame.origin.y)
        view.addSubview(heart)
        heart.animate(in: view)
        
        //爱心按钮 大小的关键帧动画
        let btnAnime = CAKeyframeAnimation(keyPath: "transform.scale")
        btnAnime.values = [1.0, 0.7, 0.5, 0.3, 0.5, 1.0, 1.2, 1.4, 1.2, 1.0]
        btnAnime.keyTimes = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
        btnAnime.duration = 0.2
        sender.layer.add(btnAnime, forKey: "SHOW")
        
    }

}

