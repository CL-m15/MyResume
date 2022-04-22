//
//  UIApplication.swift
//  MyResume
//
//  Created by Chen Le on 10/04/2022.
//

import Foundation
import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
