//
//  FavoriteDetailsViewModel.swift
//  arteScopeTests
//
//  Created by tiago on 07/02/2026.
//

import XCTest
import CoreData

@testable import arteScope

final class FavoriteDetailsViewModelTest: XCTestCase {

    private(set) var art : Art?
    private(set) var context : NSManagedObjectContext?
    
    
    override func setUp() {
        context = MemoryCoreData.makeInMemoryContext()
        art = ArtMock.art(context: context!)
    }
    
    
    func testRemoveArtWithNilArt_UsingDummy_ShowsError(){
        let dummy = ArtPersistenceDummy()
        let stu = FavoriteDetailsViewModel(persistence: dummy)
        
        stu.art = nil
        
        let expectation = expectation(description: "Alert shown")
        
        stu.showAlert = { message in
            XCTAssertEqual(message, NSLocalizedString("errorRemovingFavorites", comment: ""))
            expectation.fulfill()
        }
        
        stu.removeArtToFavorites()
        waitForExpectations(timeout: 1)
        XCTAssertNil(stu.art)
    }
    
    func testRemoveArt_UsingFake_StoresArtInMemory() {
        let fake = ArtPersistenceFake()
        let stu = FavoriteDetailsViewModel(persistence: fake)
        
        stu.art = art
        
        let expectation = expectation(description: "Alert shown")
        
        stu.showSuccessAlert = { title, message in
            XCTAssertEqual(title, NSLocalizedString("success", comment: ""))
            XCTAssertEqual(message, NSLocalizedString("successRemovingFavorite", comment: ""))
            expectation.fulfill()
        }
        
        stu.removeArtToFavorites()
        waitForExpectations(timeout: 1)
        
        XCTAssertNotNil(stu.art)
        XCTAssertEqual(fake.artStorage.count, 1)
        XCTAssertTrue(fake.artStorage.contains(art ?? Art()))
    }
    
    func testRemoveArtSuccess_UsingStub_ShowsSuccessAlert() {
        let stub = ArtPersistenceStub()
        let stu = FavoriteDetailsViewModel(persistence: stub)
        
        stu.art = art
        
        let expectation = expectation(description: "Alert shown")
        
        stu.showSuccessAlert = { title, message in
            XCTAssertEqual(title, NSLocalizedString("success", comment: ""))
            XCTAssertEqual(message, NSLocalizedString("successRemovingFavorite", comment: ""))
            expectation.fulfill()
        }
        
        stu.removeArtToFavorites()
        waitForExpectations(timeout: 1)
        XCTAssertNotNil(stu.art)
        
    }
    
    func testRemoveArtFailure_UsingStub_ShowsErrorAlert() {
        let stub = ArtPersistenceStub()
        let stu = FavoriteDetailsViewModel(persistence: stub)
        
        stu.art = art
        
        let expectation = expectation(description: "Alert shown")
        
        stub.result = .failure(NSError(domain: "", code: -1))
        
        stu.showAlert = { message in
            XCTAssertEqual(message, NSLocalizedString("errorRemovingFavorites", comment: ""))
            expectation.fulfill()
        }
        
        stu.removeArtToFavorites()
        waitForExpectations(timeout: 1)
        XCTAssertNotNil(stu.art)
        
    }
    
    func testRemoveArt_CallsPersistenceWithCorrectArt() {
        let call = ArtPersistenceSpy()
        let stu = FavoriteDetailsViewModel(persistence: call)
        
        stu.art = art
        
        stu.removeArtToFavorites()
        
        XCTAssertTrue(call.removeArtCalled)
        XCTAssertEqual(call.receivedArtToRemove, art)
    }
    
    func testRemoveArt_WithNilArt_DoesNotCallPersistence() {
        
        let spy = ArtPersistenceSpy()
        let sut = FavoriteDetailsViewModel(persistence: spy)
        
        sut.removeArtToFavorites()
        
        XCTAssertFalse(spy.removeArtCalled)
        XCTAssertNil(spy.receivedArtToRemove)
    }

    func testRemoveArtSuccess_ShowsSuccessAlert() {
        let stub = ArtPersistenceSpy()
        let stu = FavoriteDetailsViewModel(persistence: stub)
        
        stu.art = art
        
        let expectation = expectation(description: "Alert shown")
        
        stu.showSuccessAlert = { title, message in
            XCTAssertEqual(title, NSLocalizedString("success", comment: ""))
            XCTAssertEqual(message, NSLocalizedString("successRemovingFavorite", comment: ""))
            expectation.fulfill()
        }
        
        stu.removeArtToFavorites()
        waitForExpectations(timeout: 1)
        XCTAssertNotNil(stu.art)
        XCTAssertTrue(stub.removeArtCalled)
        XCTAssertEqual(stub.receivedArtToRemove, art)
        
    }
}
