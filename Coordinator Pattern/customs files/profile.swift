//
//  profile.swift
//  Coordinator Pattern
//
//  Created by Mariak Achuoth on 2019-08-16.
//  Copyright © 2019 The Future I Dream. All rights reserved.
//

import UIKit

@IBDesignable
class profile: UIImageView {

    override init(image: UIImage?) {
        super.init(image: image)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.height / 2
        self.clipsToBounds = true
    }
}
