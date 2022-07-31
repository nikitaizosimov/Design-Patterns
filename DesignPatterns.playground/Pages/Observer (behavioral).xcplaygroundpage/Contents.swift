import Foundation
import XCTest

/*:
 # Observer
 https://refactoring.guru/ru/design-patterns/observer/swift/example
 
 Наблюдатель — это поведенческий паттерн, который позволяет объектам оповещать другие объекты об изменениях своего состояния.
 
 Наблюдатель можно часто встретить в коде, особенно там, где применяется событийная модель отношений между компонентами. Наблюдатель позволяет отдельным компонентам реагировать на события, происходящие в других компонентах.
 */

protocol Observable {
    
    func add(observer: Observer)
    func remove(observer: Observer)
    func notifyObservers()
}

protocol Observer {
    
    var id: String { get set }
    func post(value: Int?)
}

final class NewsFeed: Observable {
    
    var newsCount: Int? {
        didSet {
            notifyObservers()
        }
    }
    
    private var observers = [Observer]()
    
    func add(observer: Observer) {
        observers.append(observer)
    }
    
    func remove(observer: Observer) {
        guard let observerIndex = observers.firstIndex(where: { $0.id == observer.id }) else { return }
        
        observers.remove(at: observerIndex)
    }
    
    func notifyObservers() {
        observers.forEach { $0.post(value: newsCount) }
    }
}

final class TelegramFeed: Observer {
    var id = "0"
    var newsCount: Int?

    func post(value: Int?) {
        newsCount = value
    }
}

final class YoutubeFeed: Observer {
    var id = "1"
    var newsCount: Int?

    func post(value: Int?) {
        newsCount = value
    }
}

final class Tests: XCTestCase {
    
    let newsFeedObservable = NewsFeed()
    let telegramFeedObserver = TelegramFeed()
    let youtubeFeedObserver = YoutubeFeed()
    
    override func setUp() {
        newsFeedObservable.add(observer: telegramFeedObserver)
        newsFeedObservable.add(observer: youtubeFeedObserver)
    }
    
    func test0() {
        newsFeedObservable.newsCount = 10
        
        XCTAssertTrue(telegramFeedObserver.newsCount == 10)
        XCTAssertTrue(youtubeFeedObserver.newsCount == 10)
    }
    
    func test1() {
        newsFeedObservable.newsCount = 10
        newsFeedObservable.remove(observer: telegramFeedObserver)
        newsFeedObservable.newsCount = 20
        
        XCTAssertTrue(telegramFeedObserver.newsCount == 10)
        XCTAssertTrue(youtubeFeedObserver.newsCount == 20)
    }
    
}

Tests.defaultTestSuite.run()
