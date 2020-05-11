import UIKit

struct Order {
    
}

class OrderReport {
    var formatter: OrdersOutput
    var repository: Repository
    
    init(formatter: OrdersOutput, repository: Repository) {
        self.formatter = formatter
        self.repository = repository
    }
    
    func getOrderInfo(startDate: Date, endDate: Date) -> String {
        let orders = repository.getOrdersWithDate(startDate: startDate, endDate: endDate)
        
        return formatter.output(orders: orders)
    }
    
    func queryDBForOrders(startDate: Date, endDate: Date) -> [Order] {
        // retrieve orders from database
    }
}


protocol OrdersOutput {
    func output(orders: [Order]) -> String
}
x
class OrdersOutputFormatter: OrdersOutput {
    func output(orders: [Order]) -> String {
        
    }
}

protocol Repository {
    func getOrdersWithDate(startDate: Date, endDate: Date) -> [Order]
}

class CoreDataRepository: Repository {
    func getOrdersWithDate(startDate: Date, endDate: Date) -> [Order] {
        
    }
}







