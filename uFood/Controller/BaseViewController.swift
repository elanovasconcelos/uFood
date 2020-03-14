//
//  BaseViewController.swift
//  uFood
//
//  Created by Elano on 11/03/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    private let tableView: UITableView = {
        let newTableView = UITableView(frame: .zero)

        newTableView.rowHeight = UITableView.automaticDimension
        newTableView.estimatedRowHeight = 44
        newTableView.tableFooterView = UIView()
        if #available(iOS 13.0, *) {
            newTableView.backgroundView?.backgroundColor = .systemBackground //TODO create a custom color
        } else {
            newTableView.backgroundView?.backgroundColor = .white
        }
        
        return newTableView
    }()
    private let activityIndicator: UIActivityIndicatorView = {
        let newIndicatorView = UIActivityIndicatorView(style: .white)
        
        newIndicatorView.color = .systemGray
        
        return newIndicatorView
    }()
    
    //MARK: -
    var items = [CellViewModel]() { didSet { reloadTable() } }
    var isTableHidden = false { didSet { tableView.isHidden = isTableHidden } }
    
    //MARK: -
    init(cellIdentifiers: [String]) {
        super.init(nibName: nil, bundle: nil)
        
        register(cellIdentifiers: cellIdentifiers)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -
    private func register(cellIdentifiers: [String]) {
        cellIdentifiers.forEach({ tableView.register(nibNameAndIdentifier: $0) })
    }
    
    private func setup() {
        setupTableView()
        setupIndicator()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.fullAnchor(view: view)
    }

    private func setupIndicator() {
        view.addSubview(activityIndicator)
        
        activityIndicator.centetAnchor(view: view)
    }
}

//MARK: - Public functions
extension BaseViewController {
    func showActivityIndicator() {
        ThreadHelper.main { [weak self] in
            guard let self = self else { return }
            
            self.activityIndicator.startAnimating()
            self.activityIndicator.isHidden = false
        }
    }
    
    func hideActivityIndicator() {
        ThreadHelper.main { [weak self] in
            guard let self = self else { return }
            
            if !self.activityIndicator.isAnimating {
                return
            }
            
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }
    
    func reloadTable() {
        ThreadHelper.main {
            self.tableView.reloadData()
        }
    }
    
    func rowSelected(at indexPath: IndexPath) {
        
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension BaseViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("items.count: \(items.count)")
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: cellViewModel).cellIdentifier, for: indexPath)

        cellViewModel.configure(cell: cell)
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        rowSelected(at: indexPath)
    }
}

