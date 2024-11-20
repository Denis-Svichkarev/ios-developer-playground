//
//  StrategyExample.swift
//  SampleProject Swift
//
//  Created by Denis Svichkarev on 15/11/24.
//

protocol PaymentStrategy {
    func pay(amount: Double)
}

class CreditCardPayment: PaymentStrategy {
    func pay(amount: Double) {
        print("Paying \(amount) using Credit Card")
    }
}

class PayPalPayment: PaymentStrategy {
    func pay(amount: Double) {
        print("Paying \(amount) using PayPal")
    }
}

class BitcoinPayment: PaymentStrategy {
    func pay(amount: Double) {
        print("Paying \(amount) using Bitcoin")
    }
}

class ShoppingCart {
    private var items: [String] = []
    private var paymentStrategy: PaymentStrategy?
    
    func addItem(_ item: String) {
        items.append(item)
    }
    
    func setPaymentStrategy(_ strategy: PaymentStrategy) {
        self.paymentStrategy = strategy
    }
    
    func checkout() {
        let total = Double(items.count) * 10.0
        paymentStrategy?.pay(amount: total) ?? print("No payment strategy set")
    }
}
