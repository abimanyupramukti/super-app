//
//  BottomsheetViewController.swift
//  SuperApp
//
//  Created by Abimanyu Pramukti on 11/08/23.
//

import UIKit

final class BottomsheetViewController: UIViewController {
    
    private let bottomsheetView: BottomsheetView
    
    init(contentView: UIView = UIView()) {
        self.bottomsheetView = BottomsheetView(contentView: contentView)
        
        super.init(nibName: nil, bundle: nil)
        
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
        
        self.bottomsheetView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOutsideView))
        view.addGestureRecognizer(tapGesture)
        view.backgroundColor = .black.withAlphaComponent(0.3)
        view.addSubview(bottomsheetView)
        
        bottomsheetView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        toggleShowBottomsheet()
    }
    
    private func toggleShowBottomsheet() {
        view.isUserInteractionEnabled = false
        
        var sheetYPosition = bottomsheetView.frame.minY
        let maxYPosition = view.frame.maxY
        
        if sheetYPosition.isZero {
            sheetYPosition = maxYPosition
            bottomsheetView.frame.origin.y = sheetYPosition
        }
        
        let sheetHeight = bottomsheetView.frame.height
        let isClosed = sheetYPosition == maxYPosition
        let targetYPosition = isClosed ? maxYPosition - sheetHeight : maxYPosition
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear) { [weak self] in
            self?.bottomsheetView.frame.origin.y = targetYPosition
            
        } completion: { [weak self] _ in
            self?.view.isUserInteractionEnabled = true
            if !isClosed {
                self?.dismiss(animated: true)
            }
        }
    }
    
    @objc private func didTapOutsideView(_ gesture: UITapGestureRecognizer) {
        if gesture.view == view {
            toggleShowBottomsheet()
        }
    }
}

extension BottomsheetViewController: BottomsheetViewDelegate {
    func didCloseBottomsheet() {
        toggleShowBottomsheet()
    }
}
