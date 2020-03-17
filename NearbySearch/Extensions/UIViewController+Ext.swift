//
//  UIViewController+Ext.swift
//  NearbySearch
//
//  Created by Michal Iwanski on 17/03/2020.
//  Copyright © 2020 michalronin.com. All rights reserved.
//

import UIKit

extension UIViewController {
    func adjustLargeTitleSize() {
      guard let title = title else { return }

      let maxWidth = UIScreen.main.bounds.size.width - 60
      var fontSize = UIFont.preferredFont(forTextStyle: .largeTitle).pointSize
        var width = title.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]).width

      while width > maxWidth {
        fontSize -= 1
        width = title.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]).width
      }

      navigationController?.navigationBar.largeTitleTextAttributes =
        [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize)
      ]
    }
}
