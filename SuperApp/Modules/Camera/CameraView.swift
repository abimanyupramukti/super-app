//
//  CameraView.swift
//  SuperApp
//
//  Created by Abimanyu Pramukti on 11/08/23.
//

import UIKit
import AVFoundation

final class CameraView: DefaultView {
    
    // MARK: - AVFoundation Properties
    private let session = AVCaptureSession()
    private let metadataOutput = AVCaptureMetadataOutput()
    
    private var currentDevice: AVCaptureDevice?
    
    // MARK: - Component Properties
    private let previewView: VideoPreviewView = {
        let view = VideoPreviewView()
        view.previewLayer.borderWidth = 1
        view.previewLayer.borderColor = UIColor.white.cgColor
        view.previewLayer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private let objectStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
        return stackView
    }()
    
    override func setupSubviews() {
        scrollView.addSubview(objectStackView)
        
        addSubviews([
            previewView,
            scrollView
        ])
    }
    
    override func setupConstraints() {
        previewView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(safeAreaLayoutGuide).inset(20)
        }
        
        scrollView.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(previewView.snp.bottom).offset(4)
            make.bottom.leading.trailing.equalTo(safeAreaLayoutGuide).inset(20)
        }
        
        objectStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    private func checkCaptureAuthorization(onAuthorized: @escaping (Bool) -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            onAuthorized(true)
        default:
            AVCaptureDevice.requestAccess(for: .video) { isAuthorized in
                onAuthorized(isAuthorized)
            }
        }
    }
    
    func configureSession() {
        checkCaptureAuthorization { [weak self] isAuthorized in
            guard let self = self, isAuthorized else { return }
            
            currentDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
            if let device = currentDevice, let input = try? AVCaptureDeviceInput(device: device), session.canAddInput(input) {
                session.addInput(input)
            }
            
            if session.canAddOutput(metadataOutput) {
                session.addOutput(metadataOutput)
                metadataOutput.setMetadataObjectsDelegate(self, queue: .main)
                metadataOutput.metadataObjectTypes = [.qr, .humanBody, .face, .catBody, .dogBody]
            }
            
            session.sessionPreset = .high
            
            previewView.previewLayer.session = session
            previewView.previewLayer.videoGravity = .resizeAspectFill
        }
    }
    
    func toggleSessionRunning() {
        guard !session.isRunning else {
            session.stopRunning()
            return
        }
        
        DispatchQueue.global().async {
            self.session.startRunning()
        }
    }
    
    func changeCameraOrientation() {
        previewView.previewLayer.connection?.videoOrientation = AVCaptureVideoOrientation(rawValue: UIDevice.current.orientation.rawValue)!
    }
}

extension CameraView: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        var objectDictionary: [String: Int] = [:]
        
        previewView.subviews.forEach{ $0.removeFromSuperview() }
        objectStackView.arrangedSubviews.forEach{ $0.removeFromSuperview() }
        
        for metadataObject in metadataObjects {
            if let transformedObject = previewView.previewLayer.transformedMetadataObject(for: metadataObject) {
                let typeLabel = makeTypeLabel(transformedObject.bounds, type: transformedObject.type)
                let highilghtView = makeHighilghtRect(transformedObject.bounds, type: transformedObject.type)
                
                highilghtView.addSubview(typeLabel)
                previewView.addSubview(highilghtView)
                
                if objectDictionary[transformedObject.type.rawValue] == nil {
                    objectDictionary[transformedObject.type.rawValue] = 1
                } else {
                    objectDictionary[transformedObject.type.rawValue]! += 1
                }
            }
        }
        
        let views = objectDictionary.keys.sorted().map{ makeObjectCounterView(name: $0, count: objectDictionary[$0]!)}
        objectStackView.addArrangedSubviews(views)
    }
    
    private func makeHighilghtRect(_ rect: CGRect, type: AVMetadataObject.ObjectType) -> UIView {
        let view = UIView(frame: rect)
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.systemGreen.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 4
        return view
    }
    
    private func makeTypeLabel(_ rect: CGRect, type: AVMetadataObject.ObjectType) -> UILabel {
        let label = UILabel()
        label.text = type.rawValue
        label.font = .systemFont(ofSize: 12)
        label.backgroundColor = .systemGreen.withAlphaComponent(0.2)
        label.textColor = .white
        label.frame.size = label.intrinsicContentSize
        label.frame.origin = CGPoint(x: (rect.width - label.intrinsicContentSize.width)/2, y: (rect.height - label.intrinsicContentSize.height)/2)
        return label
    }
    
    private func makeObjectCounterView(name: String, count: Int) -> UIView {
        let nameLabel = UILabel()
        nameLabel.text = name
        nameLabel.textColor = .white
        
        let countLabel = UILabel()
        countLabel.text = "\(count) " + (count > 1 ? "objects" : "object")
        countLabel.textColor = .white
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel, countLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4)
        stackView.layer.borderColor = UIColor.white.cgColor
        stackView.layer.borderWidth = 1
        stackView.layer.cornerRadius = 4
        return stackView
    }
}
