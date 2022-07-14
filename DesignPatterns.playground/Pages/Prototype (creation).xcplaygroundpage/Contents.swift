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

//class Singleton {
//
//    static var shared = Singleton()
//
//    private var colors = [String]()
//
//    private init() {}
//
//    func writeToDB(colors: [String]) { self.colors = colors }
//
//    func readFromDB() -> [String] { colors }
//}

//class PrototypeRealWorld: XCTestCase {
//
//    func testPrototypeRealWorld() {
//
//        let author = Author(id: 10, username: "Ivan_83")
//        let page = Page(title: "My First Page", contents: "Hello world!", author: author)
//
//        page.add(comment: Comment(message: "Keep it up!"))
//
//        /// Since NSCopying returns Any, the copied object should be unwrapped.
//        guard let anotherPage = page.copy() as? Page else {
//            XCTFail("Page was not copied")
//            return
//        }
//
//        /// Comments should be empty as it is a new page.
//        XCTAssert(anotherPage.comments.isEmpty)
//
//        /// Note that the author is now referencing two objects.
//        XCTAssert(author.pagesCount == 2)
//
//        print("Original title: " + page.title)
//        print("Copied title: " + anotherPage.title)
//        print("Count of pages: " + String(author.pagesCount))
//    }
//}

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
    
//    func makeClientCode() -> (nick: Singleton, mike: Singleton) {
//        let nickInstance = Singleton.shared
//        let mikeInstance = Singleton.shared
//
//        nickInstance.writeToDB(colors: ["red", "white"])
//        mikeInstance.writeToDB(colors: ["green", "black"])
//
//        return (nick: nickInstance, mike: mikeInstance)
//    }
    
    func test0() {
        let user = User(id: 10, name: "Ivan_83")
        let document = Document(title: "Credit", contents: "Hello world!", user: user)

        document.add(comment: Comment(message: "Keep it up!"))

        guard let copyDocument = document.copy() as? Document else {
            XCTFail("Page was not copied")
            return
        }
        
        XCTAssert(copyDocument.comments.isEmpty)
        
        XCTAssert(user.documentsCount == 2)

        print("Original title: " + document.title)
        print("Copied title: " + user.name)
        print("Count of pages: " + String(user.documentsCount))
    }
}

Tests.defaultTestSuite.run()
