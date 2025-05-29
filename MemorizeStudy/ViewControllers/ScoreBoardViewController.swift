//
//  ScoreBoardViewController.swift
//  MemorizeStudy
//
//  Created by Danila Savitsky on 28.05.25.
//

import UIKit

class ScoreBoardViewController: UIViewController {
    var pageIndex: Int!
    let scoreboard = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    var dataSource: [User] {
        get{
            return CoreDataManager.shared.obtainData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreboard.dataSource = self
        scoreboard.delegate = self
//        view.backgroundColor = .white
        setupLayout()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scoreboard.reloadData()
    }
    
    func setupLayout() {
        view.addSubview(scoreboard)
        print("setupLayoutworking")
        NSLayoutConstraint.activate([
            scoreboard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scoreboard.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scoreboard.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scoreboard.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ScoreBoardViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(dataSource)
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var configuration = cell.defaultContentConfiguration()
        configuration.text = self.dataSource[indexPath.row].nickName
        configuration.secondaryText = "\(self.dataSource[indexPath.row].highscore)"
        cell.contentConfiguration = configuration
        print("cell created")
        return cell
    }
}
