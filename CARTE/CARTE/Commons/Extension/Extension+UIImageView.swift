//
//  Extension+UIImageView.swift
//  CARTE
//
//  Created by tomoki.koga on 2019/06/12.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit
import Kingfisher

protocol ImageSource {
    var source: String { get }
    func reflectToImageView(_ imageView: UIImageView)
}

extension UIImage: ImageSource {
    
    var source: String {
        let base64 = jpegData(compressionQuality: 0.9)?.base64EncodedString() ?? ""
        return "data:image/jpg;base64,\(base64)"
    }
    
    func reflectToImageView(_ imageView: UIImageView) {
        imageView.image = self
    }
}

extension URL: ImageSource {
    
    var source: String {
        return absoluteString
    }
    
    func reflectToImageView(_ imageView: UIImageView) {
        imageView.kf.setImage(
            with: .network(self),
            placeholder: nil,
            options: [.transition(.fade(0.5))],
            progressBlock: nil,
            completionHandler: nil
        )
    }
}

extension String: ImageSource {
    
    var source: String {
        return self
    }
    
    func reflectToImageView(_ imageView: UIImageView) {
        guard let url = URL(string: self) else {
            return
        }
        url.reflectToImageView(imageView)
    }
}

extension UIImageView {
    
    func setImageSource(_ source: ImageSource?) {
        source?.reflectToImageView(self)
    }
}
