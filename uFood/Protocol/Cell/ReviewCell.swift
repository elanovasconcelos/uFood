//
//  ReviewCell.swift
//  uFood
//
//  Created by Elano on 16/03/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

protocol ReviewCell {
    var cellImageView: UIImageView! { get }
    var cellTextLabel: UILabel! { get }
    var cellNameLabel: UILabel! { get }
    var cellTimeLabel: UILabel! { get }
    var cellRatingLabel: UILabel! { get }
    var cellActivityIndicator: UIActivityIndicatorView! { get }
}
