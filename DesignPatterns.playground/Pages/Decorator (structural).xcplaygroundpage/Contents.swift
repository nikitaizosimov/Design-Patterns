import Foundation
import XCTest

/*:
 # Decorator
 https://refactoring.guru/ru/design-patterns/decorator/swift/example
 
 Декоратор — это структурный паттерн, который позволяет добавлять объектам новые поведения на лету, помещая их в объекты-обёртки.

 Декоратор позволяет оборачивать объекты бесчисленное количество раз благодаря тому, что и обёртки, и реальные оборачиваемые объекты имеют общий интерфейс.
 
 Паттерн можно часто встретить в Swift-коде, особенно в коде, работающем с потоками данных.

 Декоратор можно распознать по создающим методам, которые принимают в параметрах объекты того же абстрактного типа или интерфейса, что и текущий класс.
 */

protocol Car {
    
    func cost() -> Int
    func topSpeed() -> Int
    func equipmentMachine() -> String
}

final class ToyotaPrius: Car {
    func cost() -> Int {
        return 25_000
    }
    
    func topSpeed() -> Int {
        return 210
    }
    
    func equipmentMachine() -> String {
        return ""
    }
}

class CarDecorator: Car {
    
    private let car: Car
    
    init(car: Car) {
        self.car = car
    }
    
    func cost() -> Int {
        car.cost()
    }
    
    func topSpeed() -> Int {
        car.topSpeed()
    }
    
    func equipmentMachine() -> String {
        car.equipmentMachine()
    }
}

class AirCondition: CarDecorator {
    
    override func cost() -> Int {
        super.cost() + 2_000
    }
    
    override func equipmentMachine() -> String {
        super.equipmentMachine() + " Air Condition /"
    }
}

class Sport: CarDecorator {
    
    override func cost() -> Int {
        super.cost() + 3_000
    }
    
    override func topSpeed() -> Int {
        super.topSpeed() + 30
    }
    
    override func equipmentMachine() -> String {
        super.equipmentMachine() + " Sport /"
    }
}

class BlackEdition: CarDecorator {
    
    override func equipmentMachine() -> String {
        super.equipmentMachine() + " BlackEdition /"
    }
}

final class Tests: XCTestCase {
    
    func test0() {
        let baseToyota = ToyotaPrius()
        
        XCTAssertEqual(baseToyota.cost(), 25_000)
        XCTAssertEqual(baseToyota.topSpeed(), 210)
        XCTAssertEqual(baseToyota.equipmentMachine(), "")
    }
    
    func test1() {
        let fullEquipmentToyota = BlackEdition(car: Sport(car: AirCondition(car: ToyotaPrius())))
        
        XCTAssertEqual(fullEquipmentToyota.cost(), 30000)
        XCTAssertEqual(fullEquipmentToyota.topSpeed(), 240)
        XCTAssertEqual(fullEquipmentToyota.equipmentMachine(), " Air Condition / Sport / BlackEdition /")
    }
    
    func test2() {
        let comfortToyota = AirCondition(car: ToyotaPrius())
        
        XCTAssertEqual(comfortToyota.cost(), 27000)
        XCTAssertEqual(comfortToyota.topSpeed(), 210)
        XCTAssertEqual(comfortToyota.equipmentMachine(), " Air Condition /")
    }
}

Tests.defaultTestSuite.run()
