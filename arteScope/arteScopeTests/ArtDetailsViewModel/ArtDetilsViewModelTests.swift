//
//  ArtDetilsViewModelTests.swift
//  arteScope
//
//  Created by tiago on 05/02/2026.
//

import Foundation
import XCTest

@testable import arteScope

class ArtDetailsViewModelTests: XCTestCase {
    
    var sut: ArtDetilsViewModel!
    
    func testSaveArtWithNilArt_UsingDummy_ShowsError() {
        let dummy = ArtPersistenceDummy()
        sut = ArtDetilsViewModel(persistence: dummy)

        sut.art = nil

        let expectation = expectation(description: "Alert shown")

        sut.showAlert = { message in
            XCTAssertEqual(message, NSLocalizedString("errorFavoriteAdding", comment: ""))
            expectation.fulfill()
        }

        sut.saveArtToFavorites()
        waitForExpectations(timeout: 1)
        XCTAssertNil(sut.art)
    }
    
    func testSaveArt_UsingFake_StoresArtInMemory() {
        let fake = ArtPersistenceFake()
        sut = ArtDetilsViewModel(persistence: fake)

        let art = ArtTestData.sampleArt()
        sut.art = art

        let expectation = expectation(description: "Success alert")

        sut.showSuccessAlert = { _, _ in
            expectation.fulfill()
        }

        sut.saveArtToFavorites()
        waitForExpectations(timeout: 1)

        XCTAssertEqual(fake.storage.count, 1)
        XCTAssertEqual(fake.storage.first?.title, art.title)
    }

    func testSaveArtSuccess_UsingStub_ShowsSuccessAlert() {
        let stub = ArtPersistenceStub()
        stub.result = .success(())

        sut = ArtDetilsViewModel(persistence: stub)

        sut.art = ArtTestData.sampleArt()

        let expectation = expectation(description: "Success alert")

        sut.showSuccessAlert = { title, message in
            XCTAssertEqual(title, NSLocalizedString("success", comment: ""))
            XCTAssertEqual(message, NSLocalizedString("addedSuccessfully", comment: ""))
            expectation.fulfill()
        }

        sut.saveArtToFavorites()
        waitForExpectations(timeout: 1)
    }

    func testSaveArtFailure_UsingStub_ShowsErrorAlert() {
        let stub = ArtPersistenceStub()
        stub.result = .failure(NSError(domain: "", code: -1))

        sut = ArtDetilsViewModel(persistence: stub)
        sut.art = ArtTestData.sampleArt()

        let expectation = expectation(description: "Error alert")

        sut.showAlert = { message in
            XCTAssertEqual(message, NSLocalizedString("errorFavoriteAdding", comment: ""))
            expectation.fulfill()
        }

        sut.saveArtToFavorites()
        waitForExpectations(timeout: 1)
    }
    
    func testSaveArt_CallsPersistenceWithCorrectArt() {
        // Given
        let spy = ArtPersistenceSpy()
        let sut = ArtDetilsViewModel(persistence: spy)
        let art = ArtTestData.sampleArt()
        sut.art = art

        // When
        sut.saveArtToFavorites()

        // Then
        XCTAssertTrue(spy.saveArtCalled)
        XCTAssertNotNil(spy.receivedArt)
        XCTAssertEqual(spy.receivedArt?.title, art.title)
    }

    func testSaveArt_WithNilArt_DoesNotCallPersistence() {
        // Given
        let spy = ArtPersistenceSpy()
        let sut = ArtDetilsViewModel(persistence: spy)
        sut.art = nil

        // When
        sut.saveArtToFavorites()

        // Then
        XCTAssertFalse(spy.saveArtCalled)
        XCTAssertNil(spy.receivedArt)
    }

    func testSaveArtSuccess_ShowsSuccessAlert() {
        // Given
        let spy = ArtPersistenceSpy()
        let sut = ArtDetilsViewModel(persistence: spy)
        sut.art = ArtTestData.sampleArt()
        
        let expectation = expectation(description: "Success alert shown")

        var successAlertShown = false
        
        sut.showSuccessAlert = { title, message in
            XCTAssertEqual(title, NSLocalizedString("success", comment: ""))
            XCTAssertEqual(message, NSLocalizedString("addedSuccessfully", comment: ""))
            successAlertShown = true
            expectation.fulfill()
        }

        // When
        sut.saveArtToFavorites()

        // Then
        waitForExpectations(timeout: 1)
        XCTAssertTrue(successAlertShown)
        XCTAssertNotNil(spy.receivedArt)
        XCTAssertTrue(spy.saveArtCalled)
    }



}
