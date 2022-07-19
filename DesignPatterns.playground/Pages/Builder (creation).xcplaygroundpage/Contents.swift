import XCTest

/*:
 # Builder (creation)
 https://refactoring.guru/ru/design-patterns/builder
 
 **Строитель — это порождающий паттерн проектирования, который позволяет создавать объекты пошагово.**

 ### Применимость:

 ### Признаки применения паттерна:
 */

protocol ThemeProtocol: AnyObject {
    var backgroundColor: UIColor { get }
    var textColor: UIColor { get }
}

class Theme: ThemeProtocol {
    var backgroundColor: UIColor
    var textColor: UIColor
    
    init(backgroundColor: UIColor, textColor: UIColor) {
        self.backgroundColor = backgroundColor
        self.textColor = textColor
    }
}

protocol ThemeBuilderProtocol: AnyObject {
    func setBackground(color: UIColor)
    func setText(color: UIColor)
    
    func createTheme() -> ThemeProtocol?
}

class ThemeBuilder: ThemeBuilderProtocol {
    private var backgroundColor: UIColor?
    private var textColor: UIColor?
    
    func setBackground(color: UIColor) {
        self.backgroundColor = color
    }
    
    func setText(color: UIColor) {
        self.textColor = color
    }
    
    func createTheme() -> ThemeProtocol? {
        guard let backgroundColor = backgroundColor,
              let textColor = textColor else { return nil }
        
        return Theme(backgroundColor: backgroundColor,
                     textColor: textColor)
    }
}

class Tests: XCTestCase {
    
    let builder = ThemeBuilder()
    
    override func setUp() {
        builder.setText(color: .white)
        builder.setBackground(color: .black)
    }
    
    func test0() {
        XCTAssertNotNil(builder.createTheme)
    }
    
    func test1() {
        let theme = Theme(backgroundColor: .black, textColor: .white)
        let builderTheme = builder.createTheme()
        
        XCTAssertEqual(builderTheme?.backgroundColor, theme.backgroundColor)
        XCTAssertEqual(builderTheme?.textColor, theme.textColor)
    }
}

Tests.defaultTestSuite.run()
