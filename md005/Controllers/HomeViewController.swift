//
//  HomeViewController.swift
//  md005
//
//  Created by Shreyas Prakash Chavan on 28/06/24.
//

import Foundation
import UIKit

class HomeViewController : UIViewController, UITableViewDataSource, UISearchBarDelegate {
    var transactionData = GlobalTransactionsHelper.getAllTransactions()
    override func viewDidLoad() {
        super.viewDidLoad()
        currentBalance.text = "Current Balance: " + String(GlobalTransactionsHelper.getBalance())
        self.TransactionTableView.dataSource = self
    }
    override func viewDidAppear(_ animated: Bool) {
        self.transactionData = GlobalTransactionsHelper.getAllTransactions()
        self.TransactionTableView.reloadData()
        currentBalance.text = "Current Balance: " + String(GlobalTransactionsHelper.getBalance())
    }
    @IBOutlet weak var TransactionSearch: UISearchBar!
    @IBOutlet weak var TransactionTableView: UITableView!
    
    @IBOutlet weak var currentBalance: UILabel!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transactionDataCell", for: indexPath) as! TransactionDataCell
        let transaction = transactionData[indexPath.row]
        if(transaction.type == TransactionType.Credit){
            cell.transactionAmount.text = "+" + String(transaction.amount)
            cell.transactionAmount.textColor = .systemGreen
        }
        else {
            cell.transactionAmount.text = "-" + String(transaction.amount)
            cell.transactionAmount.textColor = .systemRed
        }
        
        cell.transactionTitle.text = transaction.title
        cell.transactionBalanceLeft.text = "Total balance: " + String(transaction.balance)
        
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText.isEmpty) {
            self.transactionData = GlobalTransactionsHelper.getAllTransactions()
            self.TransactionTableView.reloadData()
            return
        }
        // couldn't get Regex("/"+searchText+"/gi") to work so need to convert both to lowercase first
        self.transactionData = self.transactionData.filter { $0.title.lowercased().contains(searchText.lowercased())
        }
        self.TransactionTableView.reloadData()
    }
}
