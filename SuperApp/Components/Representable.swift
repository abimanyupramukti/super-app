//
//  Representable.swift
//  SuperApp
//
//  Created by Abimanyu Pramukti on 24/08/23.
//

import Foundation
import SwiftUI

struct DefaultViewControllerRepresentable: UIViewControllerRepresentable {
    
    private let viewController: UIViewController
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}

struct DefaultViewRepresentable: UIViewRepresentable {
    
    private let view: UIView
    
    init(_ view: UIView) {
        self.view = view
    }
    
    func makeUIView(context: Context) -> some UIView {
        view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}
