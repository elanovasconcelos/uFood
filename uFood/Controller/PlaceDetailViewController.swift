//
//  PlaceDetailViewController.swift
//  uFood
//
//  Created by Elano on 14/03/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

final class PlaceDetailViewController: BaseViewController {

    private let placeDetailViewModel: PlaceDetailViewModel
    
    //MARK: -
    init(placeDetailViewModel: PlaceDetailViewModel) {
        self.placeDetailViewModel = placeDetailViewModel
        
        super.init(cellIdentifiers: placeDetailViewModel.cellIdentifiers)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        title = "Detail"
        
        setupViewModel()
        setupBinding()
    }

    private func setupViewModel() {
        placeDetailViewModel.delegate = self
    }
    
    private func setupBinding() {
        placeDetailViewModel.cellModels.valueChanged = { [weak self] newModels in
            self?.items = newModels
        }
    }
}

//MARK: - PlaceDetailViewModelDelegate
extension PlaceDetailViewController: PlaceDetailViewModelDelegate {
    func placeDetailViewModel(_ placeDetailViewModel: PlaceDetailViewModel, didReceived error: ServerError) {
        AlertHelper.showSimpleAlert(self, message: error.localizedDescription)
    }
}
