//
//  DebitViewController.swift
//  md005
//
//  Created by Shreyas Prakash Chavan on 28/06/24.
//

import Foundation
import UIKit

class DebitViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentBalance.text = "Current balance: " + String(GlobalTransactionsHelper.getBalance())
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        currentBalance.text = "Current balance: " + String(GlobalTransactionsHelper.getBalance())
        debitErrorLabel.text = ""
        transactionTitle.text = ""
        transactionAmount.text = ""
    }
    
    @IBOutlet weak var transactionTitle: UITextField!
    
    @IBOutlet weak var debitErrorLabel: UILabel!
    
    @IBOutlet weak var transactionAmount: UITextField!
    
    @IBOutlet weak var currentBalance: UILabel!
   
    
    @IBAction func commit(_ sender: UIButton) {
        
        guard let title = transactionTitle.text else {return}
        if(title.isEmpty){
            debitErrorLabel.text = "Please enter title for transaction"
            return
        }
        guard let amountText = transactionAmount.text else {return}
        if(amountText.isEmpty){
            debitErrorLabel.text = "Please enter amount for transaction"
            return
        }
        guard let amount = Int(amountText) else {
            debitErrorLabel.text = "Transaction amount should be a valid number"
            return
        }
        if(amount <= 0) {
            debitErrorLabel.text = "Cannot debit negative amount"
            return
        }
        if(!GlobalTransactionsHelper.canSpend(amount: amount)){
            debitErrorLabel.text = "Insufficient balance"
            return
        }
        
        GlobalTransactionsHelper.addTransaction(amount: amount, title: title, type: TransactionType.Debit)
        
        debitErrorLabel.text = ""

        self.tabBarController?.selectedIndex = 0
    }
    
}
