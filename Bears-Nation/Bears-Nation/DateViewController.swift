//
//  DateViewController.swift
//  Bears-Nation
//
//  Created by Nao Yanase on 12/9/20.
//  Copyright © 2020 WashU Athletics. All rights reserved.
//

import UIKit

class DateViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    var date: Date!
    
    @IBAction func onSelectButton(_ sender: Any) {
        callback?(datePicker.date)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker.date = date
        // Do any additional setup after loading the view.
    }
    
    var callback : ((Date) -> Void)?


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
