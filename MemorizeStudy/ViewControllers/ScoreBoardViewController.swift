//
//  ScoreBoardViewController.swift
//  MemorizeStudy
//
//  Created by Danila Savitsky on 28.05.25.
//

import UIKit

class ScoreBoardViewController: UIViewController {
    let scoreboardTitle: UILabel = {
        let label = UILabel()
        label.text = "ScoreBoard"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let scoreboard = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = UIColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    var dataSource: [User] {
        get {
            return CoreDataManager.shared.obtainData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreboard.dataSource = self
        scoreboard.delegate = self
        view.backgroundColor = UIColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
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
        view.addSubview(scoreboardTitle)
        print("setupLayoutworking")
        NSLayoutConstraint.activate([
            scoreboardTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scoreboardTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scoreboard.topAnchor.constraint(equalTo: scoreboardTitle.bottomAnchor, constant: 8),
            scoreboard.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scoreboard.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scoreboard.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
extension ScoreBoardViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(dataSource)
        if dataSource.count < 10 {
            return dataSource.count
        }
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var configuration = cell.defaultContentConfiguration()
        configuration.text = " \(indexPath.row + 1) \(String( self.dataSource[indexPath.row].nickName ?? ""))"
        configuration.textProperties.font = .systemFont(ofSize: 20, weight: .bold)
        configuration.textProperties.color = .white
        configuration.secondaryText = "Highscore:\(self.dataSource[indexPath.row].highscore)"
        configuration.secondaryTextProperties.font = .systemFont(ofSize: 15, weight: .light)
        configuration.secondaryTextProperties.color = .white
        cell.contentConfiguration = configuration
        cell.backgroundColor = .clear
        print("cell created")
        return cell
    }
}
