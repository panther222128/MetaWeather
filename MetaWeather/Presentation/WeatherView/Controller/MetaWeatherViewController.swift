//
//  ViewController.swift
//  MetaWeather
//
//  Created by Jun Ho JANG on 2022/04/28.
//

import UIKit

final class MetaWeatherViewController: UIViewController {
    
    @IBOutlet weak var localWeatherTitleLabel: UILabel!
    @IBOutlet weak var weatherInformationTableView: UITableView!
    
    private var metaWeatherViewModel: MetaWeatherViewModel!
    private let tableViewRefreshControl = UIRefreshControl()
    
    lazy var dataLoadingActivityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = self.view.center
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.dataLoadingActivityIndicator)
        self.hideAllViews()
        self.weatherInformationTableView.dataSource = self
        self.weatherInformationTableView.delegate = self
        self.configureLocalWeatherTitle()
        self.configureWeatherInformationListTableView()
        self.configureRefreshControl()
        self.fetchSearchedLocationResult()
    }
    
    private func bind() {
        self.metaWeatherViewModel.locationWeathersStorage.bind { [weak self] _ in
            guard let self = self else { return }
            self.weatherInformationTableView.reloadData()
        }
        self.metaWeatherViewModel.isError.bind { [weak self] isError in
            guard let self = self else { return }
            guard let error = self.metaWeatherViewModel.error.value else { return }
            self.presentErrorAlert(of: error)
        }
    }
    
    private func fetchSearchedLocationResult() {
        self.metaWeatherViewModel.fetchSearchResult(searchKeyword: "se") { result in
            switch result {
            case .success(_):
                self.showAllViews()
                self.dataLoadingActivityIndicator.stopAnimating()
            case .failure(let error):
                self.presentErrorAlert(of: error)
            }
        }
    }
    
    private func presentErrorAlert(of error: Error) {
        let errorAlert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: UIAlertController.Style.alert)
        let addErrorAlertAction = UIAlertAction(title: "OK", style: .default)
        errorAlert.addAction(addErrorAlertAction)
        self.present(errorAlert, animated: true, completion: nil)
    }

    func instantiateWeatherViewController(with viewModel: MetaWeatherViewModel) {
        self.metaWeatherViewModel = viewModel
    }
    
    @objc func refreshData(refreshUsing: UIRefreshControl) {
        self.weatherInformationTableView.isHidden = true
        self.metaWeatherViewModel.removeAllData()
        self.fetchSearchedLocationResult()
        self.bind()
        DispatchQueue.main.async {
            self.weatherInformationTableView.refreshControl?.endRefreshing()
        }
    }
    
}

extension MetaWeatherViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.metaWeatherViewModel.locationWeathersStorage.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = weatherInformationTableView.dequeueReusableCell(withIdentifier: "WeatherInformationCellID") as? WeatherInformationCell else { return UITableViewCell() }
        let locationWeather = self.metaWeatherViewModel.locationWeathersStorage.value[indexPath.row]
        cell.configure(with: locationWeather)
        return cell
    }
    
}

extension MetaWeatherViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

}

extension MetaWeatherViewController {
    
    private func configureLocalWeatherTitle() {
        self.localWeatherTitleLabel.text = "Local Weather"
        self.localWeatherTitleLabel.font = UIFont(name: Values.defaultFont, size: 30)
        self.localWeatherTitleLabel.font = UIFont.boldSystemFont(ofSize: 30)
    }

    private func configureWeatherInformationListTableView() {
        self.weatherInformationTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        let headerWidth = self.weatherInformationTableView.contentSize.width
        let header = WeatherInformationTableHeaderView(frame: CGRect(x: 0, y: 0, width: headerWidth, height: 40))
        header.locationTitleLabel.text = "Local"
        header.todayTitleLabel.text = "Today"
        header.tomorrowTitleLabel.text = "Tomorrow"
        self.weatherInformationTableView.tableHeaderView = header
        self.bind()
    }

    private func configureRefreshControl() {
        self.tableViewRefreshControl.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
        self.weatherInformationTableView.refreshControl = tableViewRefreshControl
    }
    
    private func hideAllViews() {
        self.localWeatherTitleLabel.isHidden = true
        self.weatherInformationTableView.isHidden = true
    }
    
    private func showAllViews() {
        self.localWeatherTitleLabel.isHidden = false
        self.weatherInformationTableView.isHidden = false
    }
    
}
