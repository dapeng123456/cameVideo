//
//  VCMyViewController.swift
//  SYPCameVideo
//
//  Created by dapeng on 2017/2/24.
//  Copyright © 2017年 SYP. All rights reserved.
//

import UIKit
import SnapKit
class VCMyViewController: VCBaseViewController ,UITableViewDelegate ,UITableViewDataSource {
    var listData = NSMutableArray()
    var tableView  = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我的"
        navigationItem.leftBarButtonItem = nil
        let filePath = Bundle.main.path(forResource: "VCMine.plist", ofType:nil )
        // fliePath 不能为空  变空 就cash
        listData = NSMutableArray.init(contentsOfFile: filePath!)!
        print(listData)
        self .addTableView()
        // Do any additional setup after loading the view.
    }
    
    func addTableView() {
        view .addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.view.snp.left)
            make.top.equalTo(self.view.snp.top)
            make.width.equalTo(self.view)
            make.height.equalTo(self.view)
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
       return listData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var array = NSArray()
        array = listData .object(at: section) as! NSArray
        return array.count
    }
    
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 60
    }
    
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let indentifier:String = "indentifer"
        var cell = tableView.dequeueReusableCell(withIdentifier: indentifier)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: indentifier)
            
        }
        var array = NSArray()
        array = listData.object(at: indexPath.section) as! NSArray
        var dict = NSDictionary()
        dict = array.object(at: indexPath.row) as! NSDictionary
        cell?.textLabel?.text = dict .object(forKey: "title") as! String?
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let scanViewController = VCMyScanViewController()
        navigationController?.pushViewController(scanViewController, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
