//
//  UIImageView+Extension.swift
//  SpaceX
//
//  Created by Богдан Баринов on 02.08.2022.
//

import UIKit

//MARK: - UIImageView

extension UIImageView {

    // MARK: - Public methods

    func load(url: URL) {
        DispatchQueue.global().async { [ weak self ] in
            guard
                let self = self,
                let data = try? Data(contentsOf: url),
                let image = UIImage(data: data) else { return }

            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
