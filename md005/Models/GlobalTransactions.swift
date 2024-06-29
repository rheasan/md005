//
//  GlobalTransactions.swift
//  md005
//
//  Created by Shreyas Prakash Chavan on 28/06/24.
//

import Foundation

enum TransactionType {
    case Credit
    case Debit
}
struct Transaction {
    var type: TransactionType
    var amount: Int
    var balance: Int
    var title: String
}

private struct GlobalTransactions {
    static var accountBalance: Int = 0
    static var transactionHistory: [Transaction] = []
}

class GlobalTransactionsHelperClass {
    func getBalance() -> Int {
        return GlobalTransactions.accountBalance
    }
    func canSpend(amount: Int) -> Bool {
        return GlobalTransactions.accountBalance - amount >= 0
    }
    func getAllTransactions() -> [Transaction] {
        return GlobalTransactions.transactionHistory
    }
    func addTransaction(amount: Int, title: String, type: TransactionType){
        if(type == TransactionType.Credit) {
            GlobalTransactions.accountBalance += amount
        }
        else {
            GlobalTransactions.accountBalance -= amount
        }
        
        let transaction = Transaction.init(type: type, amount: amount, balance: GlobalTransactions.accountBalance, title: title)
        GlobalTransactions.transactionHistory.append(transaction)
    }
}
let GlobalTransactionsHelper = GlobalTransactionsHelperClass()
