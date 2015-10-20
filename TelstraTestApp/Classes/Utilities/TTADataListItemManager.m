//
//  TTADataManager.m
//  TelstraTestApp
//
//  Created by Prasanth Raj S on 17/10/15.
//  Copyright (c) 2015 Cognizant Technologies Solutions Pvt Ltd. All rights reserved.
//

#import "TTADataListItemManager.h"
#import "TTADataListItem.h"
#import "TTAConstants.h"

@implementation TTADataListItemManager

// Singleton class initializer
+ (instancetype)sharedManager {
    static TTADataListItemManager *sharedDataItemManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDataItemManager = [[self alloc] init];
        sharedDataItemManager.dataItems = [[NSMutableArray alloc]init];
    });
    return sharedDataItemManager;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// Function     : retrieveAndAddDataFromRemoteWithCompletionHandler
// Purpose      : To retrieve data from server and add it to dataItems array
// Parameters   : handler block
// Return type  : void
// Comments     : This method creates TTADataListItem objects based on the response data received
///////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)retrieveAndAddDataFromRemoteServerURL:(NSString *)iURL WithCompletionHandler:(void (^)(BOOL status, const NSString *message))iHandler {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:iURL]];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[[NSOperationQueue alloc] init]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               NSError *jsonError;

       if (error == nil) {
           NSString *str = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
           NSData *dataToParse = [str dataUsingEncoding:NSUTF8StringEncoding];
           NSDictionary *parsedResponseDict =[NSJSONSerialization JSONObjectWithData:dataToParse options:NSJSONReadingAllowFragments|NSJSONReadingMutableContainers error:&jsonError];
           
           if(jsonError == nil) {
               
               // Remove data items only when fetching is success.
               [self.dataItems removeAllObjects];
               
               self.mainTitle = [TTADataListItemManager removeNSNULL:[parsedResponseDict valueForKey:(NSString *)kTitle]];
               NSArray *itemsArray = [parsedResponseDict valueForKey:(NSString *)kRows];
               NSString *heading;
               NSString *description;
               NSString *imageURL;
               for (NSDictionary *itemDict in itemsArray) {
                   heading = [TTADataListItemManager removeNSNULL:[itemDict valueForKey:(NSString *)kTitle]];
                   description = [TTADataListItemManager removeNSNULL:[itemDict valueForKey:(NSString *)kDescription]];
                   imageURL = [TTADataListItemManager removeNSNULL:[itemDict valueForKey:(NSString *)kImageHref]];
                   
                   //Ignore data item if all the three fields (heading, description , imageURL) are empty
                   if( ! ([heading isEqualToString:(NSString *)kEmptyString] && [description isEqualToString:(NSString *)kEmptyString] && [imageURL isEqualToString:(NSString *)kEmptyString] ) ) {
                       
                       TTADataListItem *dataListItem = [[TTADataListItem alloc]initWithHeading:heading withDescription:description withImageURL:imageURL andIsImageDownloaded:NO];
                       [self.dataItems addObject:dataListItem];
                   }
               }
               iHandler(YES,kSuccess);
           }else {
               iHandler(NO,kUnableToFormatData);
           }
       }else {
           iHandler(NO,kUnableToRetrieveData);
       }
   }];

}

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// Function     : removeNSNULL
// Purpose      : To remove null value in the response data.
// Parameters   : iItemToBeChecked
// Return type  : NSString
// Comments     : This method returns empty string if the parameter value is null
///////////////////////////////////////////////////////////////////////////////////////////////////////////
+ (NSString *) removeNSNULL:(NSString *)iItemToBeChecked {
    NSString *returnString = iItemToBeChecked;
    
    if ([iItemToBeChecked isKindOfClass:[NSNull class]]) {
        returnString = (NSString *)kEmptyString;
    }
    
    return returnString;
}

@end
