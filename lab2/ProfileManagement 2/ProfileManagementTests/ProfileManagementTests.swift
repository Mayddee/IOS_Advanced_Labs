//
//  ProfileManagementTests.swift
//  ProfileManagementTests
//
//  Created by Амангелди Мадина on 21.02.2025.
//

import XCTest
@testable import ProfileManagement
 

final class ProfileManagementTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        let feedSystem = FeedSystem()
        
        if let feedData = feedSystem.loadJson() {
            print("✅ JSON Loaded Successfully!")
            print("📄 JSON Data: \(feedData.users)")
        } else {
            print("❌ Failed to Load Initial Data")
        }
        let post = Post(
            id: UUID(),
            authorId: UUID(),
            content: "Check out my latest post! #Swift",
            likes: 100,
            images: ["post1", "post2"]
        )

        let uiImages = post.getImages()
        print("Loaded images: \(uiImages.count)")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
