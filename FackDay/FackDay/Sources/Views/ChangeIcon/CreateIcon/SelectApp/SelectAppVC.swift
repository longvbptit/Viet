//
//  SelectAppVC.swift
//  FackDay
//
//  Created by Vegeta on 22/03/2021.
//

import UIKit
import SnapKit
import MTSDK

protocol SelectAppViewControllerDelegate {
    func didPopToRootView()
}

class SelectAppVC: UIViewController {

    init(apps: [AppModel], selectedApp: AppModel?) {
        super.init(nibName: nil, bundle: nil)
        self.listApps = apps
        self.selectedApp = selectedApp
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var tableView: UITableView!
    var searchBar: UISearchBar!
    var delegate: SelectAppViewControllerDelegate?
    var isSearching = false
    var listApps: [AppModel]!
    var listAppFilters: [AppModel]!
    var selectedApp: AppModel?
    
    var didSelectApp: ((_ app: AppModel) -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
        self.hideKeyboardEvent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}

extension SelectAppVC {
    func setupView() {
        view.backgroundColor = Color.backgroundColor
        
        let backButton = UIButton()
        backButton >>> view >>> {
            $0.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(Padding.leading)
                $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Padding.top)
                $0.height.width.equalTo(30)
            }
            $0.setImage(UIImage(named: "ic_close"), for: .normal)
            $0.handle {
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        let titleLabel = UILabel()
        titleLabel >>> view >>> {
            $0.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.centerY.equalTo(backButton.snp.centerY)
            }
            $0.font = Font.title
            $0.textColor = Color.title
            $0.text = "Choose app"
        }
        
        searchBar = UISearchBar()
        searchBar >>> view >>> {
            $0.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(Padding.top)
                $0.leading.equalToSuperview().offset(Padding.leading)
                $0.trailing.equalToSuperview().offset(-Padding.trailing)
                $0.height.equalTo(39)
            }
            $0.barTintColor = Color.normal
            $0.isTranslucent = false
            $0.searchBarStyle = .minimal
            $0.placeholder = "Search avaiable app"
            $0.delegate = self
            
            let textFieldInsideSearchBar = $0.value(forKey: "searchField") as? UITextField
            textFieldInsideSearchBar?.textColor = Color.normal
        }
        
        let lineView = UIView()
        lineView >>> view >>> {
            $0.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview()
                $0.top.equalTo(searchBar.snp.bottom).offset(Padding.top * 2)
                $0.height.equalTo(1)
            }
            $0.backgroundColor = .lightGray
        }
        
        tableView = UITableView()
        tableView >>> view >>> {
            $0.snp.makeConstraints {
                $0.top.equalTo(lineView.snp.bottom)
                $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
                $0.leading.trailing.equalToSuperview()
            }
            $0.register(ChooseAppTVC.self, forCellReuseIdentifier: String(describing: ChooseAppTVC.self))
            $0.separatorStyle = .none
            $0.delegate = self
            $0.dataSource = self
            $0.backgroundColor = Color.backgroundColor
        }
    }
}

extension SelectAppVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        listAppFilters = self.listApps.filter({(($0.name ).localizedCaseInsensitiveContains(searchText))})
        if (listAppFilters.count > 0 || !searchText.isEmpty) {
            isSearching = true
        } else {
            isSearching = false
        }
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func isSelected(app: AppModel) -> Bool {
        if self.selectedApp == nil {return false}
        if self.selectedApp! == app {return true}
        return false
    }
}


extension SelectAppVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? listAppFilters.count : listApps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ChooseAppTVC.self)) as! ChooseAppTVC
        let app = isSearching ? listAppFilters[indexPath.row] : listApps[indexPath.row]
        
        cell.configsView(app: app, isChecked: self.isSelected(app: app))
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedApp = isSearching ? listAppFilters[indexPath.row] : listApps[indexPath.row]
        self.didSelectApp?(self.selectedApp!)
        self.dismiss(animated: true, completion: {
            self.delegate?.didPopToRootView()
        })
    }
}
