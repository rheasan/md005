//
//  CreditViewController.swift
//  md005
//
//  Created by Shreyas Prakash Chavan on 28/06/24.
//

import Foundation
import UIKit

class CreditViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        currentBalance.text = "Current balance: " + String(GlobalTransactionsHelper.getBalance())
    }
        
    override func viewDidDisappear(_ animated: Bool) {
        currentBalance.text = "Current balance: " + String(GlobalTransactionsHelper.getBalance())
        creditErrorLabel.text = ""
        transactionTitle.text = ""
        transactionAmount.text = ""
    }
    
    @IBOutlet weak var currentBalance: UILabel!
    @IBOutlet weak var transactionTitle: UITextField!
    
    @IBOutlet weak var creditErrorLabel: UILabel!

    
    @IBOutlet weak var transactionAmount: UITextField!
    
    @IBAction func commit(_ sender: UIButton) {
        guard let title = transactionTitle.text else {return}
        if(title.isEmpty){
            creditErrorLabel.text = "Please enter title for transaction"
            return
        }
        guard let amountText = transactionAmount.text else {return}
        if(amountText.isEmpty){
            creditErrorLabel.text = "Please enter amount for transaction"
            return
        }
        guard let amount = Int(amountText) else {
            creditErrorLabel.text = "Transaction amount should be a valid number"
            return
        }
        if(amount <= 0) {
            creditErrorLabel.text = "Cannot add negative amount"
            return
        }
        
        GlobalTransactionsHelper.addTransaction(amount: amount, title: title, type: TransactionType.Credit)
        

        self.tabBarController?.selectedIndex = 0
    }
    //    func commit(_ sender: UIButton) {
//        guard let title = transactionTitle.text else {return}
//        guard let amountText = transactionAmount.text else {return}
//        guard let amount = Int(amountText) else {return}
//        GlobalTransactionsHelper.addTransaction(amount: amount, title: title, type: TransactionType.Credit)
//        
//        self.tabBarController?.selectedIndex = 0
//    }
}
