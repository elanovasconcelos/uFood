//
//  ReviewTableViewCell.swift
//  uFood
//
//  Created by Elano on 11/03/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

final class ReviewTableViewCell: UITableViewCell, ReviewCell {

    @IBOutlet var cellImageView: UIImageView!
    @IBOutlet var cellTextLabel: UILabel!
    @IBOutlet var cellNameLabel: UILabel!
    @IBOutlet var cellTimeLabel: UILabel!
    @IBOutlet var cellRatingLabel: UILabel!
    @IBOutlet var cellActivityIndicator: UIActivityIndicatorView!

}
