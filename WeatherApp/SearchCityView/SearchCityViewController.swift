//
//  SearchCityViewController.swift
//  WeatherApp
//
//  Created by Greed on 2/10/24.
//

import UIKit

final class SearchCityViewController: BaseViewController {
    
    let mainView = SearchCityView()

    var cityInfos: [CityInfo] = []
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityInfos = load()
    }
    
    override func configureView() {
        view.backgroundColor = .black
        mainView.tableView.backgroundColor = .black
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(CityTableViewCell.self, forCellReuseIdentifier: CityTableViewCell.identifier)
        mainView.tableView.rowHeight = 60
        navigationItem.title = "search"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//        navigationItem.largeTitleDisplayMode = .always
    }

}

extension SearchCityViewController {
    
    func load() -> [CityInfo] {
        
        guard let file = Bundle.main.url(forResource: "CityList", withExtension: "json") else {
            fatalError("파일을 찾을 수 없습니다.")
        }
        
        do {
            let data = try Data(contentsOf: file)
            return try JSONDecoder().decode([CityInfo].self, from: data)
        } catch {
            print(error)
            fatalError("파일을 로드할 수 없습니다")
        }
        
    }
}

extension SearchCityViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityInfos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as! CityTableViewCell
        cell.cityName.text = cityInfos[indexPath.row].name
        cell.country.text = cityInfos[indexPath.row].country
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
