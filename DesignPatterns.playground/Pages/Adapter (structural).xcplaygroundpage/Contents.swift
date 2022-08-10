import Foundation
import XCTest

/*:
 # Adapter
 https://refactoring.guru/ru/design-patterns/adapter/swift/example
 
 Адаптер — это структурный паттерн, который позволяет подружить несовместимые объекты.
 
 Паттерн можно часто встретить в Swift-коде, особенно там, где требуется конвертация разных типов данных или совместная работа классов с разными интерфейсами.
 
 Чаще всего используется для third patry зависимостей и сложных типов данных, где extension будет неуместным.
 */

enum Fraht {
    
    static let customsPowerHorse = 3_000
    static let sosSystem = 40_000
    static let scrapСollection = 35_000
}

protocol CarCost {
    
    func calculateCarCost() -> Int
}

struct DomesticCar: CarCost {
    
    let price: Int
    
    func calculateCarCost() -> Int {
        return price
    }
}

struct JapanCar {
    
    let price: Int
    let powerHorse: Int
    let dealerFee: Int
    let fixHeadlightsFromRhdToLhd: Int
    let deliveryCost: Int
    
    var rawCost: Int {
        var summury = 0
        
        summury += powerHorse * Fraht.customsPowerHorse
        summury += dealerFee + fixHeadlightsFromRhdToLhd
        summury += Fraht.sosSystem + Fraht.scrapСollection
        summury += price + deliveryCost
        
        return summury
    }
}

class JapanCarCarCostAdapater: CarCost {
    
    static let forceMajeure = 80_000
    
    let japanCar: JapanCar
    
    init(japanCar: JapanCar) {
        self.japanCar = japanCar
    }
    func calculateCarCost() -> Int {
        return japanCar.rawCost + Self.forceMajeure
    }
}

final class Tests: XCTestCase {

    lazy var ladaNiva: CarCost = { DomesticCar(price: 1_000_000) }()
    
    lazy var toyotaCamry: JapanCar = {
        JapanCar(price: 500_000,
                 powerHorse: 150,
                 dealerFee: 20_000,
                 fixHeadlightsFromRhdToLhd: 30_000,
                 deliveryCost: 50_000)
    }()
    
    lazy var toyotaCamryAdapter: JapanCarCarCostAdapater = { JapanCarCarCostAdapater(japanCar: toyotaCamry) }()

    func test0() {
        let value = ladaNiva.calculateCarCost()
        XCTAssertEqual(value, 1000000)
    }
    
    func test1() {
        let value = toyotaCamryAdapter.calculateCarCost()
        XCTAssertEqual(value, 1205000)
    }
}

Tests.defaultTestSuite.run()
