//
//  OrientationViewModifier.swift
//  CVS_Challenge
//
//  Created by Derek Howes on 7/13/24.
//

import Foundation
import SwiftUI

struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    
    func body(content: Content) -> some View {
        content
            .onAppear {
                action(UIDeviceOrientation(rawValue: UIDevice.current.orientation.rawValue) ?? .unknown)
            }
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}


extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}
