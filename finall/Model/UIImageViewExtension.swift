//
//  UIImageViewExtension.swift
//  finall
//
//  Created by רם צמח on 15/07/2023.
//

import UIKit
import Alamofire
import AlamofireImage

extension UIImageView {
    func load(urlString: String?, placeholder: UIImage?) {
        self.image = placeholder
        guard let url =  NSURL(string: urlString ?? "") as URL? else {
            return
        }
        self.af.setImage(withURL: url)
    }
}
