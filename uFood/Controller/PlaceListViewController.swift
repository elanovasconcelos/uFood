//
//  PlaceListViewController.swift
//  uFood
//
//  Created by Elano on 14/03/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

final class PlaceListViewController: BaseViewController {

    private let placeListViewModel: PlaceListViewModel
    
    //MARK: -
    init(placeListViewModel: PlaceListViewModel = PlaceListViewModel()) {
        self.placeListViewModel = placeListViewModel
        
        super.init(cellIdentifiers: placeListViewModel.cellIdentifiers)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updatePlaces()
    }
    
    private func setup() {
        title = "Places"
        
        setupViewModel()
        setupBinding()
        setupTable()
    }
    
    private func setupViewModel() {
        placeListViewModel.delegate = self
    }
    
    private func setupBinding() {
        placeListViewModel.cellModels.valueChanged = { [weak self] newPlaces in
            self?.hideActivityIndicator()
            self?.isTableHidden = false
            self?.items = newPlaces
        }
    }
    
    private func setupTable() {
        isTableHidden = true
    }
    
    private func updatePlaces() {
        showActivityIndicator()
        placeListViewModel.requestPlaces()
    }

    override func rowSelected(at indexPath: IndexPath) {
        if let place = placeListViewModel.place(at: indexPath) {
            let placeDetailViewModel = PlaceDetailViewModel(place: place)
            let controller = PlaceDetailViewController(placeDetailViewModel: placeDetailViewModel)
            
            self.navigationController?.pushViewController(controller, animated: true)
        }else {
            print("PlaceListViewController|rowSelected: nil place")
        }
    }
}

extension PlaceListViewController: PlaceListViewModelDelegate {
    func placeListViewModel(_ placeListViewModel: PlaceListViewModel, didReceived error: ServerError) {
        hideActivityIndicator()
        print("placeListViewModel|didReceived - error: \(error)")
        AlertHelper.showSimpleAlert(self, message: error.localizedDescription)
    }
}
