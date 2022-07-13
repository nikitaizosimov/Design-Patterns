import Foundation
import XCTest

/*:
 # Singltone
 https://refactoring.guru/ru/design-patterns/singleton
 
 Одиночка — это порождающий паттерн проектирования, который гарантирует, что у класса есть только один экземпляр, и предоставляет к нему глобальную точку доступа.
 
 + Гарантирует наличие единственного экземпляра класса.
 + Предоставляет к нему глобальную точку доступа.
 + Реализует отложенную инициализацию объекта-одиночки.
 
 - Нарушает принцип единственной ответственности класса. Паттерн решает сразу две проблемы - инициализацию и вызов функции.
 - Маскирует плохой дизайн. Компоненты программы много знают друг о друге.
 - Проблемы мультипоточности.
 - Требует постоянного создания Mock-объектов при юнит-тестировании. Так как невозможно переопределить статик методы.
 */

class Singleton {
    
    static var shared = Singleton()
    
    private var colors = [String]()
    
    private init() {}
    
    func writeToDB(colors: [String]) { self.colors = colors }
    
    func readFromDB() -> [String] { colors }
}

//class Client {
//
//    static func someClientCode() {
//        let nickInstance = Singleton.shared
//        let mikeInstance = Singleton.shared
//
//        nickInstance.writeToDB(colors: ["red", "white"])
//        mikeInstance.writeToDB(colors: ["green", "black"])
//
//
////        let instance1 = Singleton.shared
////        let instance2 = Singleton.shared
////
////        if (instance1 === instance2) {
////            print("Singleton works, both variables contain the same instance.")
////        } else {
////            print("Singleton failed, variables contain different instances.")
////        }
//    }
//}

class Tests: XCTestCase {
    
    func makeClientCode() -> (nick: Singleton, mike: Singleton) {
        let nickInstance = Singleton.shared
        let mikeInstance = Singleton.shared
        
        nickInstance.writeToDB(colors: ["red", "white"])
        mikeInstance.writeToDB(colors: ["green", "black"])
        
        return (nick: nickInstance, mike: mikeInstance)
    }
    
    func test0() {
        let instance = makeClientCode()
        XCTAssertEqual(instance.nick === instance.mike, true)
    }
    
    func test1() {
        let instance = makeClientCode()
        XCTAssertEqual(instance.nick.readFromDB(), ["green", "black"])
        XCTAssertEqual(instance.mike.readFromDB(), ["green", "black"])
    }
}

Tests.defaultTestSuite.run()
