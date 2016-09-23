//
//  AlamofireJsonToObjectsTests.swift
//  AlamofireJsonToObjectsTests
//
//  Created by Edwin Vermeer on 6/21/15.
//  Copyright (c) 2015 evict. All rights reserved.
//

import XCTest
import Alamofire
import EVReflection

class WeatherResponse: EVObject {
    var location: String?
    var three_day_forecast: [Forecast] = [Forecast]()
}

class Forecast: EVObject {
    var day: String?
    var temperature: NSNumber?
    var conditions: String?
}


class AlamofireJsonToObjectsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        EVReflection.setBundleIdentifier(Forecast.self)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }


    func testResponseObject() {
        // This is an example of a functional test case.
        let URL: URLConvertible = "http://raw.githubusercontent.com/evermeer/AlamofireJsonToObjects/master/AlamofireJsonToObjectsTests/sample_json"
        let exp = expectation(description: "\(URL)")

        Alamofire.request(URL)
            .responseObject { (response: DataResponse<WeatherResponse>) in
            
            exp.fulfill()
            if let result = response.result.value {
                print("\(result.description)")
                XCTAssertNotNil(result.location, "Location should not be nil")
                XCTAssertNotNil(result.three_day_forecast, "ThreeDayForcast should not be nil")
                XCTAssertEqual(result.three_day_forecast.count, 3, "ThreeDayForcast should have 2 items.")
                for forecast in result.three_day_forecast {
                    XCTAssertNotNil(forecast.day, "day should not be nil")
                    XCTAssertNotNil(forecast.conditions, "conditions should not be nil")
                    XCTAssertNotNil(forecast.temperature, "temperature should not be nil")
                }
                
            } else {
                XCTAssert(true, "no result from service")
            }
            
                
        }

        waitForExpectations(timeout: 10) { error in
            XCTAssertNil(error, "\(error)")
        }
    }


    func testResponseObject2() {
        // This is an example of a functional test case.
        
        let exp = expectation(description: "router")
        
        Alamofire.request(Router.list1())
            .responseObject { (response: DataResponse<WeatherResponse>) in
                
            exp.fulfill()
                if let result = response.result.value {
                    XCTAssertNotNil(result.location, "Location should not be nil")
                    XCTAssertNotNil(result.three_day_forecast, "ThreeDayForcast should not be nil")
                    XCTAssertEqual(result.three_day_forecast.count, 3, "ThreeDayForcast should have 2 items.")
                    for forecast in result.three_day_forecast {
                        XCTAssertNotNil(forecast.day, "day should not be nil")
                        XCTAssertNotNil(forecast.conditions, "conditions should not be nil")
                        XCTAssertNotNil(forecast.temperature, "temperature should not be nil")
                    }
                } else {
                    XCTAssert(true, "Could not get result from service")
                }
        }
        
        waitForExpectations(timeout: 10) { error in
            XCTAssertNil(error, "\(error)")
        }
    }
    
    func testResponseObject3() {
        // This is an example of a functional test case.
        
        let URL: URLConvertible = "http://raw.githubusercontent.com/evermeer/AlamofireJsonToObjects/master/AlamofireJsonToObjectsTests/sample_json"
        let exp = expectation(description: "router")
        
        Alamofire.request(URL, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .responseObject { (response: DataResponse<WeatherResponse>) in
                
                exp.fulfill()
                if let result = response.result.value {
                    XCTAssertNotNil(result.location, "Location should not be nil")
                    XCTAssertNotNil(result.three_day_forecast, "ThreeDayForcast should not be nil")
                    XCTAssertEqual(result.three_day_forecast.count, 3, "ThreeDayForcast should have 2 items.")
                    for forecast in result.three_day_forecast {
                        XCTAssertNotNil(forecast.day, "day should not be nil")
                        XCTAssertNotNil(forecast.conditions, "conditions should not be nil")
                        XCTAssertNotNil(forecast.temperature, "temperature should not be nil")
                    }
                } else {
                    XCTAssert(true, "Could not get result from service")
                }
        }
        
        waitForExpectations(timeout: 10) { error in
            XCTAssertNil(error, "\(error)")
        }
    }
    
    func testArrayResponseObject() {
        // This is an example of a functional test case.
        let URL = "http://raw.githubusercontent.com/evermeer/AlamofireJsonToObjects/master/AlamofireJsonToObjectsTests/sample_array_json"
        let exp = expectation(description: "\(URL)")
        
        Alamofire.request(URL)
        .responseArray { (response: DataResponse<[Forecast]>) in
            exp.fulfill()

            if let result = response.result.value {
                for forecast in result {
                    XCTAssertNotNil(forecast.day, "day should not be nil")
                    XCTAssertNotNil(forecast.conditions, "conditions should not be nil")
                    XCTAssertNotNil(forecast.temperature, "temperature should not be nil")
                }
            } else {
                XCTAssert(true, "Service did not return a result")
            }
            
        }
        
        waitForExpectations(timeout: 10) { error in
            XCTAssertNil(error, "\(error)")
        }
    }


    func testArrayResponseObject2() {
        // This is an example of a functional test case.
        let URL = "http://raw.githubusercontent.com/evermeer/AlamofireJsonToObjects/master/AlamofireJsonToObjectsTests/sample_array_json"
        let exp = expectation(description: "\(URL)")
        
        Alamofire.request(URL)
            .responseArray { (response: DataResponse<[Forecast]>) in
            exp.fulfill()
            
            if let result = response.result.value {
                for forecast in result {
                    XCTAssertNotNil(forecast.day, "day should not be nil")
                    XCTAssertNotNil(forecast.conditions, "conditions should not be nil")
                    XCTAssertNotNil(forecast.temperature, "temperature should not be nil")
                }
            } else {
                XCTAssert(true, "service did not return a result")
            }
        
        }
        
        waitForExpectations(timeout: 10) { error in
            XCTAssertNil(error, "\(error)")
        }
    }
    
}


enum Router: URLRequestConvertible {
    case list1()
    case list2()
    
    static let baseURLString = "http://raw.githubusercontent.com/evermeer/AlamofireJsonToObjects/master/AlamofireJsonToObjectsTests/"
    static let perPage = 50
    
    // MARK: URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let result: (path: String, parameters: Parameters) = {
            switch self {
            case .list1:
                return ("sample_json", [:])
            case .list2:
                return ("sample_array_json", [:])
            }
        }()
        
        let url = try Router.baseURLString.asURL()
        let urlRequest = URLRequest(url: url.appendingPathComponent(result.path))
        
        return try URLEncoding.default.encode(urlRequest, with: result.parameters)
    }
}



