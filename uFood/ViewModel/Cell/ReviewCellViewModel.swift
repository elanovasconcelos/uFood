//
//  ReviewCellViewModel.swift
//  uFood
//
//  Created by Elano on 16/03/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

final class ReviewCellViewModel: NSObject, CellViewModel {
    static let cellIdentifier = "ReviewTableViewCell"
    
    let isLoading = Observable<Bool>(true)
    let image = Observable<UIImage?>(nil)
    let authorName: String
    let photoUrl: URL?
    let rating: String
    let timeDescription: String
    let text: String
    
    //MARK: -
    init(review: Review) {
        self.authorName = review.authorName
        self.photoUrl = URL(string: review.profilePhotoUrl)
        self.rating = "\(review.rating)"
        self.timeDescription = review.relativeTimeDescription
        self.text = review.text
    }
    
    func configure(cell: UITableViewCell) {
        guard let cell = cell as? ReviewCell else { return }
        
        configureLabel(in: cell)
        configureBinding(for: cell)
        requestImage()
    }
    
    private func configureLabel(in cell: ReviewCell) {
        cell.cellNameLabel.text = authorName
        cell.cellRatingLabel.text = rating
        cell.cellTimeLabel.text = timeDescription
        cell.cellTextLabel.text = text
    }

    private func configureBinding(for cell: ReviewCell) {
        image.valueChanged = { (newImage) in
            cell.cellImageView.image = newImage
        }
        
        isLoading.valueChanged = { newValue in
            if newValue {
                cell.cellActivityIndicator.startAnimating()
            } else {
                cell.cellActivityIndicator.stopAnimating()
            }
        }
    }

    func requestImage(cache: Cache = Cache.shared) {
        isLoading.value = true
        image.value = nil
        
        cache.image(for: photoUrl) { [weak self] (result) in
            self?.isLoading.value = false
            
            switch result {
            case .failure(let error):
                print("[ReviewCellViewModel|requestImage]: \(error)")
                self?.image.value = nil
            case .success(let image): self?.image.value = image
            }
        }
    }
    
    static func from(reviews: [Review]?) -> [ReviewCellViewModel] {
        guard let reviews = reviews else { return [] }
        
        return reviews.map({ ReviewCellViewModel(review: $0) })
    }
}
