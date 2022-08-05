import Foundation
import XCTest

/*:
 # Adapter
 https://refactoring.guru/ru/design-patterns/adapter/swift/example
 
 Адаптер — это структурный паттерн, который позволяет подружить несовместимые объекты.
 
 Паттерн можно часто встретить в Swift-коде, особенно там, где требуется конвертация разных типов данных или совместная работа классов с разными интерфейсами.
 
 Чаще всего используется для third patry зависимостей и сложных типов данных, где extension будет нехватать.
 */

enum RussianFraht {
    
    static let customsСlearanceForPowerHorse = 3_000
    static let sosButton = 40_000
    static let scrapСollection = 35_000
}

protocol CarCost {
    
    func calculateCarCost() -> Int
}

struct DomesticCar {
    
    let price: Int
    
    func calculateCarCost() -> Int {
        return price
    }
}

extension DomesticCar: CarCost { }

struct JapanCar {
    
    let price: Int
    let powerHorse: Int
    let dealerFee: Int
    let fixHeadlightsFromRhdToLhd: Int
    let deliveryCost: Int
    
    var rawCost: Int {
        var summury = 0
        
        summury += powerHorse * RussianFraht.customsСlearanceForPowerHorse
        summury += dealerFee + fixHeadlightsFromRhdToLhd
        summury += RussianFraht.sosButton + RussianFraht.scrapСollection
        summury += price + deliveryCost
        
        return summury
    }
}

struct KoreanCar {
    
    let price: Int
    let powerHorse: Int
    let deliveryCost: Int
    
    var rawCost: Int {
        var summury = 0
        
        summury += powerHorse * RussianFraht.customsСlearanceForPowerHorse
        summury += RussianFraht.sosButton + RussianFraht.scrapСollection
        summury += price + deliveryCost
        
        return summury
    }
}

class JapanCarCarCostAdapater: CarCost {
    
    static let profit = 80_000
    
    let japanCar: JapanCar
    
    init(japanCar: JapanCar) {
        self.japanCar = japanCar
    }
    func calculateCarCost() -> Int {
        return japanCar.rawCost + Self.profit
    }
}

class KoreanCarCarCostAdapater: CarCost {
    
    static let profit = 120_000
    
    let koreanCar: KoreanCar
    
    init(koreanCar: KoreanCar) {
        self.koreanCar = koreanCar
    }
    func calculateCarCost() -> Int {
        return koreanCar.rawCost + Self.profit
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
    
    let kiaK5: KoreanCar = {
        KoreanCar(price: 500_500,
                  powerHorse: 150,
                  deliveryCost: 20_000)
    }()
    
    lazy var toyotaCamryAdapter: JapanCarCarCostAdapater = { JapanCarCarCostAdapater(japanCar: toyotaCamry) }()
    lazy var kiaK5Adapter: KoreanCarCarCostAdapater = { KoreanCarCarCostAdapater(koreanCar: kiaK5) }()

    func test0() {
        let value = ladaNiva.calculateCarCost()
        XCTAssertEqual(value, 1000000)
    }
    
    func test1() {
        let value = toyotaCamryAdapter.calculateCarCost()
        XCTAssertEqual(value, 1205000)
    }
    
    func test2() {
        let value = kiaK5Adapter.calculateCarCost()
        XCTAssertEqual(value, 1165500)
    }
}

Tests.defaultTestSuite.run()
