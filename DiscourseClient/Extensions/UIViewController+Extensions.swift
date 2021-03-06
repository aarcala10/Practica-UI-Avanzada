//
//  UIViewController+Extensions.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

extension UIViewController {
    /// Muestra un alertcontroller con una única acción
    /// - Parameters:
    ///   - alertMessage: Mensaje del alert
    ///   - alertTitle: Título del alert
    ///   - alertActionTitle: Título de la acción
    func showAlert(_ alertMessage: String,
                               _ alertTitle: String = NSLocalizedString("Error", comment: ""),
                               _ alertActionTitle: String = NSLocalizedString("OK", comment: "")) {

        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: alertActionTitle, style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
extension UIColor {

  @nonobjc class var black: UIColor {
    return UIColor(white: 12.0 / 255.0, alpha: 1.0)
  }
  @nonobjc class var tangerine: UIColor {
    return UIColor(red: 243.0 / 255.0, green: 144.0 / 255.0, blue: 0.0, alpha: 1.0)
  }
  @nonobjc class var pumpkin: UIColor {
    return UIColor(red: 221.0 / 255.0, green: 99.0 / 255.0, blue: 0.0, alpha: 1.0)
  }
  @nonobjc class var brownGrey: UIColor {
    return UIColor(white: 135.0 / 255.0, alpha: 1.0)
  }
  @nonobjc class var white82: UIColor {
    return UIColor(white: 248.0 / 255.0, alpha: 0.82)
  }
}
