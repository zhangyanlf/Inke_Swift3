# Inke_Swift3


#1.视频播放（由于IJKMediaFramework库太大需自己手动添加）

链接: https://pan.baidu.com/s/1bYm8Aa 密码: vcpc

##IJKMediaFramework.framework

##libcrypto.a

##librtmp.a

##libssl.a

##添加上面库及.a文件后需添加

注：在进入直播间打开视频播放后，返回主界面时要将视频关闭，否则程序会崩

#2.爱心特效  HeartFlyView

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
        
        
#3.烟花特效 emmitParticles

       //烟花特效
        let layerFw = CAEmitterLayer()
        view.layer.addSublayer(layerFw)
        emmitParticles(from: sender.center, emitter: layerFw, in: view)
        
