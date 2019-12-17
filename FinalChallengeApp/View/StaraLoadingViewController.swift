//
//  Loading.swift
//  FinalChallengeApp
//
//  Created by George Joseph Kristian on 17/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class StaraLoadingViewController : UIViewController{
    var loadingView : UIView?
    
    func configureLoading(){
        let loadingView = UIView()
        let loadingImage = UIImageView()
        loadingView.backgroundColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.5)
        loadingImage.animationImages = (0...29).map { UIImage(named: "stara-icon-\($0)")!}
        loadingImage.startAnimating()
        loadingView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        loadingImage.frame = CGRect(x: loadingView.center.x, y: loadingView.center.y, width: 120, height: 248)
        loadingView.addSubview(loadingImage)
        
        loadingImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingImage.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            loadingImage.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor)
        ])
        
        view.addSubview(loadingView)
        self.loadingView = loadingView
    }
    
    func startLoading(){
        if loadingView == nil{
            configureLoading()
        }
        loadingView?.isHidden = false
    }
    
    func dismissLoading(){
        loadingView?.isHidden = true
    }
}
