//
//  Speaking_Times_TablesUITests.swift
//  Speaking Times TablesUITests
//
//  Created by Julian Moorhouse on 20/01/2018.
//

import XCTest

class Speaking_Times_TablesUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        setupSnapshot(app)
        app.alerts.buttons["OK"].tap()

        snapshot("3Main")
        
        app.buttons["Learn"].tap()
        
        let chooseTimesTableButton = app.tables/*@START_MENU_TOKEN@*/.staticTexts["Choose Times Table"]/*[[".cells.staticTexts[\"Choose Times Table\"]",".staticTexts[\"Choose Times Table\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/

        chooseTimesTableButton.tap()

        snapshot("4Cho0se")

        app.buttons["6x"].tap()

        sleep(25);

        snapshot("2Learn")

        app.navigationBars["Learn"].buttons["Back"].tap()
     
        app.buttons["Test"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Choose Times Table"]/*[[".cells.staticTexts[\"Choose Times Table\"]",".staticTexts[\"Choose Times Table\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

        app.buttons["5x"].tap()
        
        let element = app.otherElements.containing(.navigationBar, identifier:"Test").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        sleep(2);
        element.children(matching: .textField).element.typeText("5")
        
        let toolbarDoneButtonButton = app.toolbars.buttons["Toolbar Done Button"]
        toolbarDoneButtonButton.tap()
        sleep(2);
        element.children(matching: .textField).element(boundBy: 1).typeText("10")
        toolbarDoneButtonButton.tap()
        sleep(2);
        element.children(matching: .textField).element(boundBy: 2).typeText("15")
        toolbarDoneButtonButton.tap()
        sleep(2);
        element.children(matching: .textField).element(boundBy: 3).typeText("20")
        toolbarDoneButtonButton.tap()
        sleep(2);

        snapshot("1Test")
        
        element.children(matching: .textField).element(boundBy: 4).typeText("25")
        toolbarDoneButtonButton.tap()
        sleep(2);
        element.children(matching: .textField).element(boundBy: 5).typeText("30")
        toolbarDoneButtonButton.tap()
        sleep(2);
        element.children(matching: .textField).element(boundBy: 6).typeText("35")
        toolbarDoneButtonButton.tap()
        sleep(2);
        element.children(matching: .textField).element(boundBy: 7).typeText("40")
        toolbarDoneButtonButton.tap()
        sleep(2);
        element.children(matching: .textField).element(boundBy: 8).typeText("45")
        toolbarDoneButtonButton.tap()
        sleep(2);
        element.children(matching: .textField).element(boundBy: 9).typeText("50")
        toolbarDoneButtonButton.tap()
        sleep(2);
        element.children(matching: .textField).element(boundBy: 10).typeText("55")
        toolbarDoneButtonButton.tap()
        sleep(2);
        element.children(matching: .textField).element(boundBy: 11).typeText("60")
        toolbarDoneButtonButton.tap()
        sleep(2);
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).tap()
        app.navigationBars["Test"].buttons["Finish"].tap()
        let textField = app.otherElements.containing(.navigationBar, identifier:"Results").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element
        textField.tap()
        toolbarDoneButtonButton.tap()
        textField.tap()
        textField.typeText("Paul")
        toolbarDoneButtonButton.tap()
        sleep(1);

        snapshot("0Results")
    }
    
}
