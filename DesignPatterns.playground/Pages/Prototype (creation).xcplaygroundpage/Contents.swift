import Foundation
import XCTest

/*:
 # Prototype (creation)
 https://refactoring.guru/ru/design-patterns/prototype/swift/example
 
 **Прототип — это порождающий паттерн, который позволяет копировать объекты любой сложности без привязки к их конкретным классам.**
 
 ### Применимость:
 Паттерн Прототип реализован в базовой библиотеке Swift посредством интерфейса NSCopying.

 ### Признаки применения паттерна:
 Прототип легко определяется в коде по наличию методов clone, copy и прочих.
 
 + Позволяет создать полную копию объекта, включая его private свойства.
 */

class User {
    
    private(set) var id: Int
    private(set) var name: String
    private(set) var documents = [Document]()
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    func add(document: Document) {
        documents.append(document)
    }
    
    var documentsCount: Int {
        return documents.count
    }
}

class Document: NSCopying {
    
    private(set) var title: String
    private(set) var contents: String
    private(set) var comments = [Comment]()
    
    private weak var user: User?
    
    init(title: String, contents: String, user: User?) {
        self.title = title
        self.contents = contents
        self.user = user
        user?.add(document: self)
    }
    
    func add(comment: Comment) {
        comments.append(comment)
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Document(title: "Copy of '" + title + "'", contents: contents, user: user)
    }
}

struct Comment {
    
    let date = Date()
    let message: String
}

class Tests: XCTestCase {
    
    lazy var user: User = {
        User(id: 10, name: "Ivan_83")
    }()
    
    lazy var document: Document = {
       Document(title: "Credit", contents: "Hello world!", user: user)
    }()
    
    func test0() {
        guard let copyDocument = document.copy() as? Document else {
            XCTFail("Page was not copied")
            return
        }
        
        XCTAssert(user.documentsCount == 2)
        XCTAssertEqual(document.contents, copyDocument.contents)
    }
    
    func test1() {
        let message = "Keep it up!"
        document.add(comment: Comment(message: message))
        
        guard let copyDocument = document.copy() as? Document else {
            XCTFail("Page was not copied")
            return
        }
        
        XCTAssert(copyDocument.comments.isEmpty)
        
        guard let comment = document.comments.first else {
            XCTFail("Comments empty")
            return
        }
        
        XCTAssert(comment.message == message)
    }
}

Tests.defaultTestSuite.run()
