//
//  MyPageMyPagePresenter.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import FirebaseAuth

class MyPagePresenter: MyPageModuleInput {
    
    weak var view: MyPageViewInput!
    var interactor: MyPageInteractorInput!
    var router: MyPageRouterInput!

    var sections = [Section]()

    func viewIsReady() {
        sections = createSections()
        view.setupInitialState()
    }
    
    func viewDidAppear() {
        interactor.trackView()
    }
}

extension MyPagePresenter: MyPageViewOutput {
    
    func numberOfSections() -> Int {
        return sections.count
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        return sections[section].rows.count
    }
    
    func sectionAt(_ section: Int) -> Section {
        return sections[section]
    }
    
    func rowAt(_ indexPath: IndexPath) -> Row {
        return sections[indexPath.section].rows[indexPath.row]
    }
}

extension MyPagePresenter: MyPageInteractorOutput {
    
    func signOutSuccess() {
        router.showSignIn(fromSignOut: true)
    }
    
    func signOutFailure(_ error: Error) {
        // TODO: エラー処理
    }
}

extension MyPagePresenter {
    
    private func createSections() -> [Section] {
        var sections = [Section]()
        sections.append(Section { (section) in
            section.title = "アカウント設定"
            
            var rows = [Row]()
            if let user = Auth.auth().currentUser, !user.isAnonymous {
                rows.append(Row { (row) in
                    row.reuseIdentifier = R.reuseIdentifier.myPageSubtitleCell.identifier
                    row.accessoryType = .disclosureIndicator
                    row.title = "メールアドレスを変更"
                    row.subtitle = user.email
                    row.didSelect = { (tableView, indexPath) in
                        
                    }
                })
                rows.append(Row { (row) in
                    row.reuseIdentifier = R.reuseIdentifier.myPageBasicCell.identifier
                    row.accessoryType = .disclosureIndicator
                    row.title = "パスワードを変更"
                    row.didSelect = { (tableView, indexPath) in
                        
                    }
                })
            } else {
                rows.append(Row { (row) in
                    row.reuseIdentifier = R.reuseIdentifier.myPageBasicCell.identifier
                    row.accessoryType = .disclosureIndicator
                    row.title = "サインイン"
                    row.didSelect = { [weak self] (tableView, indexPath) in
                        self?.router.showSignIn(fromSignOut: false)
                    }
                })
            }
            
            rows.append(Row { (row) in
                row.reuseIdentifier = R.reuseIdentifier.myPageBasicCell.identifier
                row.accessoryType = .disclosureIndicator
                row.title = "プロフィール設定"
                row.didSelect = { [weak self] (tableView, indexPath) in
                    self?.router.showProfile()
                }
            })
            
            rows.append(Row { (row) in
                row.reuseIdentifier = R.reuseIdentifier.myPageBasicCell.identifier
                row.accessoryType = .disclosureIndicator
                row.title = "通知設定"
                row.didSelect = { [weak self] (tableView, indexPath) in
                    self?.router.showSettingNotification()
                }
            })
            
            section.rows = rows
        })
        
        sections.append(Section { (section) in
            section.title = "このアプリについて"
            
            section.rows = [
                Row { (row) in
                    row.reuseIdentifier = R.reuseIdentifier.myPageRightDetailCell.identifier
                    row.selectionStyle = .none
                    row.title = "バージョン"
                    
                    let version = (Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String) ?? "-"
                    row.subtitle = version
                }
            ]
        })
        
        if let user = Auth.auth().currentUser {
            sections.append(Section { (section) in
                section.rows = [
                    Row { (row) in
                        row.reuseIdentifier = R.reuseIdentifier.myPageBasicCell.identifier
                        row.title = user.isAnonymous ? "リセット" : "サインアウト"
                        row.didSelect = { [weak self] (tableView, indexPath) in
                            self?.interactor.signOut()
                        }
                    }
                ]
            })
        }
        
        return sections
    }
}
