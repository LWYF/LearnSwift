//
//  RACTableView.swift
//  SwiftDemo
//
//  Created by LEMO on 2017/6/13.
//  Copyright © 2017年 lyf. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import Result

class RACTableView: UITableView {
    
    let RACCellId = "RACCellId"
    
    let (signal, obser) = Signal<Any, NoError>.pipe()
    
    public var models: [RACModel]?
    
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
        //系统自带的cell
        self.register(UITableViewCell.self, forCellReuseIdentifier: RACCellId)
        //铺满分割线
        self.separatorInset = .zero
    }
    
}

extension RACTableView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //??,类似于? :
        return models?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RACCellId, for: indexPath)
        cell.selectionStyle = .none
        let cellStr = models?[indexPath.row].title ?? ""
        cell.textLabel?.text = cellStr
        return cell
    }
}

extension RACTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //RAC，相当于代理方法的作用
        obser.send(value: models?[indexPath.row].title ?? "")
    }
}
