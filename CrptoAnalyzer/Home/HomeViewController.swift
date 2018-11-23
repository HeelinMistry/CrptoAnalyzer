//
//  ViewController.swift
//  CrptoAnalyzer
//
//  Created by Heelin Mistry on 2018/09/03.
//  Copyright © 2018 Heelin Mistry. All rights reserved.
//

import UIKit

var rowHeight : CGFloat = 60

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate{

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    
    lazy private var loadingAnimation: UIImageView = {
        UIImageView(image: UIImage.gifImageWithName("loader"))
    }()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var segmentedControl = UISegmentedControl()
    
    let identifier = String(describing: HomeViewCell.self)
    
    lazy private var viewModel: HomeViewModel = {
        HomeViewModel(view: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTable()
        setupSearch()
        checkConnection()
    }
    
    private func setupSearch() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search For Cryptocurrency (Symbol)"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func checkConnection(){
        if (NetworkManager.reachability.connection == .none){
            showErrorState()
        } else {
            getData()
        }
    }
    
    fileprivate func getData() {
        self.showLoadingState()
        self.viewModel.loadScreenContent()
    }
    
    func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = rowHeight
        
        tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.tableFooterView = UIView()
    }
    
    func updateSegmentControl(){
        segmentedControl = UISegmentedControl(items: viewModel.getFromCurrencies())
        segmentedControl.tintColor = UIColor.lightGray
        segmentedControl.center = self.view.center
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(updateTableBasedOnSegment), for: .valueChanged)
        stackView.insertArrangedSubview(segmentedControl, at: 0)
        updateTableBasedOnSegment()
    }
    
    @objc func updateTableBasedOnSegment(){
        if let currencyFilter = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex){
            viewModel.filterTickerData(value : currencyFilter)
            self.updateNavigationTitle(value: currencyFilter)
            updateSearchResults(for: self.searchController)
            tableView.reloadData()
        }
    }
    
    private func updateNavigationTitle(value : String) {
        self.title = "\(value) -> ..."
    }
    
    func showLoadingState(){
        navigationController?.isNavigationBarHidden = true
        tableView.isHidden = true
        loadingAnimation.frame = self.view.frame
        stackView.addSubview(loadingAnimation)
    }
    
    func showSuccessState(){
        loadingAnimation.removeFromSuperview()
        navigationController?.isNavigationBarHidden = false
        tableView.isHidden = false
    }
    
    func showErrorState(){
        loadingAnimation.removeFromSuperview()
        navigationController?.isNavigationBarHidden = false
        tableView.isHidden = false
    }
    
    //    MARK:TableView Data Source
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getTickerCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! HomeViewCell
        cell.setDisplayValues(value: viewModel.getTickersForDisplay(index: indexPath.row))
        return cell
    }

    //    MARK:DZNEmpty Methods
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        if(viewModel.isTickerData()){
            let str = "Cannot find any information"
            let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)]
            return NSAttributedString(string: str, attributes: attrs)
        } else {
            let str = "There appears to be no internet connectivity, Please check."
            let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)]
            return NSAttributedString(string: str, attributes: attrs)
        }
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = ""
        let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage()
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView, for state: UIControl.State) -> NSAttributedString? {
        if(viewModel.isTickerData()){
            let str = ""
            let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.callout)]
            return NSAttributedString(string: str, attributes: attrs)
        } else {
            let str = "Try Again"
            let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.callout),
                         NSAttributedString.Key.strokeColor: UIColor.white]
            return NSAttributedString(string: str, attributes: attrs)
        }
    }
    
    func emptyDataSet(_ scrollView: UIScrollView, didTap button: UIButton) {
        getData()
    }
}

extension HomeViewController : HomeViewContract {
    func populateWithTickers() {
        if(viewModel.isTickerData()){
            updateSegmentControl()
            showSuccessState()
        } else {
            showErrorState()
        }
    }
    
    func filterWithTickers() {
        tableView.reloadData()
    }
}

extension HomeViewController : UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.filterContentForSearchText(searchController.searchBar.text!)
    }
}
