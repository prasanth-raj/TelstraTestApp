//
//  TTADataListItemManagerTests.m
//  TelstraTestApp
//
//  Created by Muthukumar Haridos on 19/10/15.
//  Copyright (c) 2015 Cognizant Technologies Services Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "TTADataListItemManager.h"

@interface TTADataListItemManager (Test)

+ (NSString *) removeNSNULL:(NSString *)iItemToBeChecked;

@end

@interface TTADataListItemManagerTests : XCTestCase
@property (nonatomic) TTADataListItemManager *ttaDataListItemManager;
@end

@implementation TTADataListItemManagerTests

- (void)setUp {
    [super setUp];
    self.ttaDataListItemManager = [TTADataListItemManager sharedManager];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


// Testing Null values comming from server is properly handled or not
- (void) testRemoveNSNULL {
    
    NSString *str = @"{\"imageHref\":null}";    // Null Values comming from Server
    NSData *dataToParse = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *parsedResponseDict =[NSJSONSerialization JSONObjectWithData:dataToParse options:NSJSONReadingAllowFragments|NSJSONReadingMutableContainers error:nil];
    NSString *emptyString = [TTADataListItemManager removeNSNULL:[parsedResponseDict valueForKey:@"imageHref"]];
    
    NSString *expectedResultString = @"";
    XCTAssertEqualObjects(expectedResultString, emptyString, @"The Null string comming from server is not handled");
}


// Testing response from server url is properly handled or not
- (void)testRetrieveAndAddDataFromRemote {
    
    NSString *urlString =@"www.google.com";   // Giving a google server url
    BOOL expectedResult = NO;    // expected result is NO, because we are not going to get expected response.
    
    XCTestExpectation *completionExpectation = [self expectationWithDescription:@"Long method"];
    [[TTADataListItemManager sharedManager] retrieveAndAddDataFromRemoteServerURL:urlString WithCompletionHandler:^(BOOL status, NSString *message){
        XCTAssertEqual(expectedResult, status, @"Reponse from server is not checked properly");
        [completionExpectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}


@end
