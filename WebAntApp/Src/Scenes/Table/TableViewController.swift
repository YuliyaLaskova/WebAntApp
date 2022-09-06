//
//  TableViewController.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 19.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

class TableViewController: UIViewController {
    
    internal var presenter: TablePresenter?
    var orders = [UserEntityForGet]()
    private let orderCell = "OrderCell"
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "OrderViewCell", bundle: nil), forCellReuseIdentifier: "OrderCell")

        self.setTabBarHidden(true)
//        self.navigationController?.navigationBar.backgroundColor = .blue
    }
    
    func setupStrings() {
        // Setup localizable strings
    }
}
// MARK: TableView extentions

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return orders.count
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as? OrderViewCell else {
            return UITableViewCell()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

//        let note = updateModel(index: indexPath, isChecked: cell.isSelected)
//        if !tableView.isEditing {
//            showNoteDetailsViewController(for: note)
//        }
    }
}

extension TableViewController: TableView {
    
}

final class OrderCell: UITableViewCell {
    
    @IBOutlet var orderCell: UIView!
}


final class TestCell: UITableViewCell {


}
