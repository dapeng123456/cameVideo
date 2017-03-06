//
//  VCMyViewController.swift
//  SYPCameVideo
//
//  Created by dapeng on 2017/2/24.
//  Copyright © 2017年 SYP. All rights reserved.
//

import UIKit

class VCMyViewController: VCBaseViewController ,UITableViewDelegate ,UITableViewDataSource {
    var listData = NSMutableArray()
    var tableView  = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let filePath = Bundle.main.path(forResource: "VCMine.plist", ofType:nil )
        // fliePath 不能为空  变空 就cash
        listData = NSMutableArray.init(contentsOfFile: filePath!)!
        print(listData)
        self .addTableView()
        // Do any additional setup after loading the view.
    }
    
    func addTableView() {
        tableView.frame = VCCGRect(x: 0, y: 0, width: SWIDTH, height: SHEIGHT)
        view .addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
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
        return 30
    }
    
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 60
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
        cell?.textLabel?.text = "扫一扫"
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
