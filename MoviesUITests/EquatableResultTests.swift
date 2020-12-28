//
//  EquatableResultTests.swift
//  MoviesUITests
//
//  Created by Abdelrahman Mohamed on 18.12.2020.
//

import Foundation
import XCTest

class EquatableResultTests: XCTestCase {

    struct Foo: Equatable { let id: Int }
    struct EquatableError: Equatable, Error { let message: String }

    func testSuccess() {
        let result: Result<Foo, EquatableError> = .success(Foo(id: 123))

        XCTAssertEqual(result, .success(Foo(id: 123)))
    }

    func testFailure() {
        let result: Result<Foo, EquatableError> = .failure(EquatableError(message: "abc"))

        XCTAssertEqual(result, .failure(EquatableError(message: "abc")))
    }
    
    func testResultSuccessGet() throws {
        let result = Result<Int, Error>.success(42)

        let value = try result.get()

        XCTAssertEqual(value, 42)
    }

    func testResultSuccessExampleGuard() {
        let result = Result<Int, Error>.success(42)

        guard case .success(let value) = result else {
            return XCTFail("Expected to be a success but got a failure with \(result)")
        }

        XCTAssertEqual(value, 42)
    }

    func testResultSuccessExampleSwitch() {
        let result = Result<Int, Error>.success(42)

        switch result {
        case .failure(let error):
            XCTFail("Expected to be a success but got a failure with \(error)")
        case .success(let value):
            XCTAssertEqual(value, 42)
        }
    }
    
    func testResultFailureExampleGuard() {
        let result = Result<Int, Error>.success(42)

        guard case .failure(let error) = result else {
            return XCTFail("Expected to be a failure but got a success with \(result)")
        }

        // Run your assertions on the expected value of error here
    }

    func testResultFailureExampleSwitch() {
        let result = Result<Int, Error>.success(42)

        switch result {
        case .success(let value):
            XCTFail("Expected to be a failure but got a success with \(value)")
        case .failure(let error): break
            // Run your assertions on the expected value of error here
        }
    }
    
//    func useExetensionFuncs() {
//
//        let result: Result<Int, TestError> = .success(42)
//
//        assert(result, isSuccessWith: 42)
//        assert(result, isFailureWith: TestError(message: "abc"))
//    }
    
    
}

extension XCTestCase {

    func assert<T, E>(
        _ result: Result<T, E>,
        isSuccessWith value: T
    ) where E: Error, T: Equatable {
        switch result {
        case .failure(let error):
            XCTFail("Expected to be a success but got a failure with \(error)")
        case .success(let resultValue):
            XCTAssertEqual(resultValue, value)
        }
    }

    func assert<T, E>(
        _ result: Result<T, E>,
        isFailureWith error: E
    ) where E: Equatable & Error {
        switch result {
        case .failure(let resultError):
            XCTAssertEqual(resultError, error)
        case .success(let value):
            XCTFail("Expected to be a failure but got a success with \(value)")
        }
    }
}

extension XCTestCase {

    func assert<T, E>(
        _ result: Result<T, E>,
        isSuccessWith value: T,
        message: (E) -> String = { "Expected to be a success but got a failure with \($0) "},
        file: StaticString = #filePath,
        line: UInt = #line
    ) where E: Error, T: Equatable {
        switch result {
        case .failure(let error):
            XCTFail(message(error), file: file, line: line)
        case .success(let resultValue):
            XCTAssertEqual(resultValue, value)
        }
    }

    func assert<T, E>(
        _ result: Result<T, E>,
        isFailureWith error: E,
        message: (T) -> String = { "Expected to be a failure but got a success with \($0) "},
        file: StaticString = #filePath,
        line: UInt = #line
    ) where E: Equatable & Error {
        switch result {
        case .failure(let resultError):
            XCTAssertEqual(resultError, error)
        case .success(let value):
            XCTFail(message(value), file: file, line: line)
        }
    }
}

