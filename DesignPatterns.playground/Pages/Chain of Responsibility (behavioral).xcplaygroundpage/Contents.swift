import Foundation
import XCTest

/*:
 # Chain of Responsibility
 https://refactoring.guru/design-patterns/chain-of-responsibility
 
 Цепочка обязанностей — это поведенческий паттерн проектирования, который позволяет передавать запросы последовательно по цепочке обработчиков. Каждый последующий обработчик решает, может ли он обработать запрос сам и стоит ли передавать запрос дальше по цепи.

 Избавляет от жёсткой привязки отправителя запроса к его получателю, позволяя выстраивать цепь из различных обработчиков динамически.
 
 GestureRecognize, который определяет на какой элемент нажал пользователь работает через hitTest, где опрашивая родителя вызывают последнего UIReponser.
 
 Пример основан на работе UITest'ов с mock запросами, модуль тестов может прокидывать статичные json или динамические, а так-же есть дефолтные. При обработке reqeust, мы вначале должны искать в динамических/статичных, а только потом обращаться к дефолтным и искать ответ.
 */

final class UITestResponder {
    
    typealias JSON = String
    
    var responses = [String: JSON]()
    var next: UITestResponder?
    
    func handle(request: String) -> JSON? {
        if let response = responses.first(where: { $0.key == request })?.value {
            return response
        } else if let next = next {
            return next.handle(request: request)
        } else {
            return nil
        }
    }
}

final class UITestContainer {
    
    var defaultTests: UITestResponder?
    var staticTests: UITestResponder?
    var dynamicTests: UITestResponder?
    
    var firstResponder: UITestResponder?
    
    func handle(request: String) -> UITestResponder.JSON? {
        return firstResponder?.handle(request: request)
    }
}

final class Tests: XCTestCase {
    
    lazy var containerTest: UITestContainer = {
        let container = UITestContainer()
        
        container.firstResponder = dynamicTests
        
        container.defaultTests = defaultTests
        container.staticTests = staticTests
        container.dynamicTests = dynamicTests
        
        return container
    }()
    
    lazy var defaultTests: UITestResponder = {
        let responder = UITestResponder()
        
        responder.responses = ["https://google/apply": "200",
                           "https://google/translate": "500" ]
        
        return responder
    }()
    
    lazy var staticTests: UITestResponder = {
        let responder = UITestResponder()
        
        responder.responses = ["https://google/apply": "300",
                           "https://google/wallet": "200" ]
        responder.next = defaultTests
        
        return responder
    }()
    
    lazy var dynamicTests: UITestResponder = {
        let responder = UITestResponder()
        
        responder.responses = ["https://google/wallet": "300",
                           "https://google/discount": "200" ]
        responder.next = staticTests
        
        return responder
    }()
    
    func test0() {
        XCTAssertEqual(containerTest.handle(request: "https://google/wallet"), "300")
        XCTAssertEqual(containerTest.handle(request: "https://google/discount"), "200")
        XCTAssertEqual(containerTest.handle(request: "https://google/apply"), "300")
        XCTAssertEqual(containerTest.handle(request: "https://google/translate"), "500")
    }
}

Tests.defaultTestSuite.run()
