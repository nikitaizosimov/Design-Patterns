import UIKit
import XCTest

/*:
 # Factory Method (creation)
 https://refactoring.guru/ru/design-patterns/factory-method/swift/example
 
 **Фабричный метод — это порождающий паттерн проектирования, который используется для создания объектов без указания его точного класса.

 Фабричный метод задаёт метод, который следует использовать вместо инициализации создания объектов-продуктов.

 ### Применимость:
 Используется тогда, когда нужно создать объект во время выполнения программы.

 ### Признаки применения паттерна:
 Полиморфное создание объектов
 Использование слова `make` вначале создания
 */

protocol Vehicle: AnyObject {
    
    func drive()
}

class Car: Vehicle {
    
    func drive() {
        print("drive car")
    }
}

class Truck: Vehicle {
    
    func drive() {
        print("drive truck")
    }
}

class Bus: Vehicle {
    
    func drive() {
        print("drive bus")
    }
}

protocol VehicleFactory: AnyObject {
    
    func makeVehicle() -> Vehicle
}

final class CarFactory: VehicleFactory {
    
    func makeVehicle() -> Vehicle {
        return Car()
    }
}

final class TruckFactory: VehicleFactory {
    
    func makeVehicle() -> Vehicle {
        return Car()
    }
}

final class BusFactory: VehicleFactory {
    
    func makeVehicle() -> Vehicle {
        return Car()
    }
}

let carFactory = CarFactory()
let car = carFactory.makeVehicle()

let truckFactory = TruckFactory()
let truck = truckFactory.makeVehicle()

let busFactory = BusFactory()
let bus = busFactory.makeVehicle()

//class Tests: XCTestCase {
//
////    func makeClientCode() -> (nick: Singleton, mike: Singleton) {
////        let nickInstance = Singleton.shared
////        let mikeInstance = Singleton.shared
////
////        nickInstance.writeToDB(colors: ["red", "white"])
////        mikeInstance.writeToDB(colors: ["green", "black"])
////
////        return (nick: nickInstance, mike: mikeInstance)
////    }
//
//    func test0() {
//        let user = User(id: 10, name: "Ivan_83")
//        let document = Document(title: "Credit", contents: "Hello world!", user: user)
//
//        document.add(comment: Comment(message: "Keep it up!"))
//
//        guard let copyDocument = document.copy() as? Document else {
//            XCTFail("Page was not copied")
//            return
//        }
//
//        XCTAssert(copyDocument.comments.isEmpty)
//
//        XCTAssert(user.documentsCount == 2)
//
//        print("Original title: " + document.title)
//        print("Copied title: " + user.name)
//        print("Count of pages: " + String(user.documentsCount))
//    }
//}
//
//Tests.defaultTestSuite.run()
