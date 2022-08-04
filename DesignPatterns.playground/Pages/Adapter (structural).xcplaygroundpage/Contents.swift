import Foundation
import XCTest

/*:
 # Adapter
 https://refactoring.guru/ru/design-patterns/adapter/swift/example
 
 Адаптер — это структурный паттерн, который позволяет подружить несовместимые объекты.
 
 Паттерн можно часто встретить в Swift-коде, особенно там, где требуется конвертация разных типов данных или совместная работа классов с разными интерфейсами.
 */



//final class Tests: XCTestCase {
//
//    let newsFeedObservable = NewsFeed()
//    let telegramFeedObserver = TelegramFeed()
//    let youtubeFeedObserver = YoutubeFeed()
//
//    override func setUp() {
//        newsFeedObservable.add(observer: telegramFeedObserver)
//        newsFeedObservable.add(observer: youtubeFeedObserver)
//    }
//
//    func test0() {
//        newsFeedObservable.newsCount = 10
//
//        XCTAssertTrue(telegramFeedObserver.newsCount == 10)
//        XCTAssertTrue(youtubeFeedObserver.newsCount == 10)
//    }
//
//    func test1() {
//        newsFeedObservable.newsCount = 10
//        newsFeedObservable.remove(observer: telegramFeedObserver)
//        newsFeedObservable.newsCount = 20
//
//        XCTAssertTrue(telegramFeedObserver.newsCount == 10)
//        XCTAssertTrue(youtubeFeedObserver.newsCount == 20)
//    }
//
//}
//
//Tests.defaultTestSuite.run()
