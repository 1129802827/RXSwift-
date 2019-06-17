//
//  ViewController.swift
//  studyRxswift
//
//  Created by zclee on 2019/2/28.
//  Copyright © 2019 zclee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct DataModel {
    let className: AnyObject?
    let name: String?
    
    init(className: AnyObject?, name: String?) {
        self.className = className
        self.name = name
    }
}

struct DataListModel {
    let data = Observable.just([
        DataModel(className: PeopleViewController.init(),name: "tableview"),
        DataModel(className: ObservableViewController.init(), name: "Observable"),
        DataModel(className: SubscribeViewController.init(), name: "Subscribe"),
        DataModel(className: doOnViewController.init(), name: "doOn"),
        DataModel(className: DisposeViewController.init(), name: "Dispose"),
        DataModel(className: bindViewController.init(), name: "bindto"),
        DataModel(className: exViewController.init(), name: "extension"),
        DataModel(className: subjectsViewController.init(), name: "subject"),
        DataModel(className: TransformingViewController.init(), name: "TransformingViewController")
        ])
}

class ViewController: UIViewController {
    
    @IBOutlet weak var mytable: UITableView!
    
    let disposeBag = DisposeBag()
    
    let dataList = DataListModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        mytable.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        dataList.data
            .bind(to: mytable.rx.items(cellIdentifier:"myCell")) { _, model, cell in
                cell.textLabel?.text = model.name
            }.disposed(by: disposeBag)
        
        mytable.rx.modelSelected(DataModel.self).subscribe({ event in
//            self.present(event.element!.className as! UIViewController, animated: true, completion: {
//            })
            self.navigationController?.pushViewController(event.element!.className as! UIViewController, animated: true)
        }).disposed(by: disposeBag)
        
    }
    
    // Do any additional setup after loading the view, typically from a nib.
}

