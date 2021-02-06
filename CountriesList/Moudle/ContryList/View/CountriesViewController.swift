//
//  CountriesViewController.swift
//  Countries
//
//  Created by mozhgan on 3/2/2020.
//  Copyright © 2019 mozhgan. All rights reserved.
//

import UIKit
import SnapKit

final class CountriesViewController: UIViewController {

    deinit {
        print("Deinit ::\(self)")
    }

    typealias SelectedCountriesCallback = (([Country]) -> Void)
    let reuseIdentifier = "\(CountryCell.self)"
    var presenter: VTPCountriesProtocol?
    private lazy var searchController: UISearchController = {
        let tmp = UISearchController(searchResultsController: nil)
        tmp.searchResultsUpdater = self
        tmp.searchBar.delegate = self
        tmp.obscuresBackgroundDuringPresentation = false
        tmp.searchBar.placeholder = LocalizeStrings.CountryListView.searchbarPlaceHolder
        navigationItem.searchController = tmp
        definesPresentationContext = true
        return tmp
    }()

    private lazy var refreshCtrl: UIRefreshControl = {
        let tmp = UIRefreshControl()
        tmp.attributedTitle = NSAttributedString(string: LocalizeStrings.CountryListView.refreshingString)
        tmp.addTarget(self, action: #selector(self.refresh(sender:)), for: UIControl.Event.valueChanged)
        return tmp
    }()

    private lazy var tableView: UITableView = {
        let tmp = UITableView()
        tmp.allowsSelection = false
        tmp.delegate = self
        tmp.dataSource = self
        tmp.register(CountryCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tmp)
        tmp.addSubview(self.refreshCtrl)
        return tmp
    }()

    private lazy var doneBtn: CustomButton = {
        let tmp = CustomButton()
        tmp.setTitle(LocalizeStrings.CountryListView.done, for: UIControl.State.normal)
        view.addSubview(tmp)
        tmp.backgroundColor = UIColor.red
        return tmp
    }()

    var callback: SelectedCountriesCallback!

    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }

    init(callback : @escaping SelectedCountriesCallback) {
        super.init(nibName: "\(CountriesViewController.self)", bundle: nil)
        self.callback = callback
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
// MARK: - ViewController Lifecycle
extension CountriesViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = LocalizeStrings.CountryListView.countryListView
        self.doneBtn.addTarget(self, action: #selector(done(sender: )), for: UIControl.Event.touchUpInside)
        searchController.searchResultsUpdater = self
        self.refreshCtrl.beginRefreshing()
        self.presenter?.fetchCountries()
    }
    override func loadView() {
        super.loadView()
        tableView.snp.makeConstraints { (maker) in
            maker.edges.top.left.right.equalToSuperview()
        }
        doneBtn.snp.makeConstraints { (maker) in
            maker.left.right.bottom.equalToSuperview()
            maker.top.equalTo(self.tableView.snp_bottomMargin)
            maker.height.equalTo(Layout.doneButtonHeight)
        }
    }
}
// MARK: - Rotation
extension CountriesViewController {
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
}
// MARK: - Table view data source
extension CountriesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.presenter?.numberOfSection ?? 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.numberOfRowsInSection ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? CountryCell else {
            return UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: reuseIdentifier)
        }
        cell.configCell(country: self.presenter!.fetch(index: indexPath), delegate: self)
        return cell
    }
}

// MARK: - Table view delegate
extension CountriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
// MARK: - Serach Bar Delegate
extension CountriesViewController: UISearchResultsUpdating, UISearchBarDelegate {
  func updateSearchResults(for searchController: UISearchController) {
    guard isFiltering == true else {
        return
    }
    self.presenter?.filter(term: searchController.searchBar.text!)
  }
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    self.presenter?.filterCanceledByUser()
  }
}
// MARK: - Table view pull to refresh
extension CountriesViewController {
    @objc func refresh(sender: AnyObject) {
        self.presenter?.fetchCountries()
    }

    @objc func done(sender: UIButton) {
        self.dismiss(animated: true) {
            self.callback(self.presenter?.selectedCountries ?? [])
        }
    }
}
// MARK: - View to presenter
extension CountriesViewController: PTVCountriesProtocol {
    func reload(at indexPath: IndexPath) {
        self.tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.fade)
    }
    func stopLoading() {
        self.refreshCtrl.endRefreshing()
    }

    func refresh() {
        self.tableView.reloadData()
    }

    func show(error: Error) {
        let alert = UIAlertController(title: LocalizeStrings.CommonStrings.alertTitle, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: LocalizeStrings.CommonStrings.ok, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
// MARK: - Table view delegate
extension CountriesViewController: CountryCellDelegate {
    func toggle(cell: CountryCell) {
        guard let indexPath = self.tableView.indexPath(for: cell) else {
            return
        }
        self.presenter?.toggle(index: indexPath)
    }
}
