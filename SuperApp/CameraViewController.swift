//
//  CameraViewController.swift
//  SuperApp
//
//  Created by Abimanyu Pramukti on 11/08/23.
//

import UIKit
import AVFoundation

final class CameraViewController: TabBarViewController {
    
    private let cameraView  = CameraView()
    
    override func commonInit() {
        setTabBarItem(title: "Camera", image: UIImage(systemName: "camera"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = cameraView
        cameraView.configureSession()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        cameraView.changeCameraOrientation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cameraView.toggleSessionRunning()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        cameraView.toggleSessionRunning()
    }
}




