//
//  ReportViewController.swift
//  Capstone_SSS
//
//  Created by Kang on 2022/03/27.
//

import UIKit

class ReportViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let report = ["인명보호장구(안전모) 미착용", "초과탑승 금지", "위험한 전동킥보드 운전", "야광띠 등의 발광장치 미착용(야간)", "기타"]
    var check = [false, false, false, false, false]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return report.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ReportTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ReportTableViewCell
        
        let text: String = self.report[indexPath.row]
        cell.reportText.text = text
        
        if check[indexPath.row] == true {
            cell.checkImage.image = UIImage(systemName: "circle.circle")
        } else {
            cell.checkImage.image = UIImage(systemName: "circle")
        }
        
        return cell
    }
    
    //check기능
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        check = [false, false, false, false, false]
        if check[indexPath.row] == false {
            check[indexPath.row] = true
        } else {
            check[indexPath.row] = false
        }
        tableView.reloadData()
        print(check)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
