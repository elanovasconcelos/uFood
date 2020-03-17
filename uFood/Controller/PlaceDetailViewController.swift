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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func setup() {
        title = "Detail"
        setupBinding()
    }

    private func setupBinding() {
        placeDetailViewModel.cellModels.valueChanged = { [weak self] newModels in
            print("valueChanged")
            self?.items = newModels
        }
    }
}
