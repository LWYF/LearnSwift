//
//  LivesTableView.swift
//  SwiftDemo
//
//  Created by LEMO on 2017/6/15.
//  Copyright © 2017年 lyf. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import Result

class LivesTableView: UITableView {

    let cellId = "livesCellId"
    let (signal, obser) = Signal<Any, NoError>.pipe()

    public var models: [livesModel]?
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        loadView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadView() {
        self.dataSource = self
        self.delegate = self
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        //铺满分割线
        self.separatorInset = .zero
        //添加cell
        self.register(LiveCell.self, forCellReuseIdentifier: cellId)
    }
}

extension LivesTableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //??,类似于? :
        return models?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.selectionStyle = .none
//        let cellStr = models?[indexPath.row].title ?? ""
//        cell.textLabel?.text = cellStr
        return cell
    }
}

extension LivesTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //RAC，相当于代理方法的作用
//        obser.send(value: models?[indexPath.row].title ?? "")
    }
}
