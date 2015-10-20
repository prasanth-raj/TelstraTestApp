//
//  TTADataManager.h
//  TelstraTestApp
//
//  Created by Prasanth Raj S on 17/10/15.
//  Copyright (c) 2015 Cognizant Technologies Solutions Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTADataListItemManager : NSObject

@property (nonatomic,strong) NSString *mainTitle;
@property (nonatomic,strong) NSMutableArray *dataItems;

// Singleton class initializer
+ (instancetype)sharedManager;

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// Function     : retrieveAndAddDataFromRemoteWithCompletionHandler
// Purpose      : To retrieve data from server and add it to dataItems array
// Parameters   : handler block
// Return type  : void
// Comments     : This method creates TTADataListItem objects based on the response data received
///////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)retrieveAndAddDataFromRemoteServerURL:(NSString *)iURL WithCompletionHandler:(void (^)(BOOL status, const NSString *message))iHandler;

@end
