//
//  TTADataItem.h
//  TelstraTestApp
//
//  Created by Prasanth Raj S on 17/10/15.
//  Copyright (c) 2015 Cognizant Technologies Solutions Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TTADataListItem : NSObject

@property (nonatomic, strong) NSString *heading;
@property (nonatomic, strong) NSString *detailDescription;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) UIImage *iconImage;
@property (nonatomic, assign) BOOL isImageDownloaded;

// Designated Initializer

- (instancetype) initWithHeading:(NSString *)iHeading withDescription:(NSString *)iDescription withImageURL:(NSString *)iImageURL  andIsImageDownloaded:(BOOL)iImageDownloadedStatus;

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// Function     : updateIconImage
// Purpose      : To update the iconImage with given UIImage
// Parameters   : iImage
// Return type  : void
// Comments     : None
///////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)updateIconImage:(UIImage *)iImage;

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// Function     : updateImageDownloadStatus
// Purpose      : To update the isImageDownload property with given BOOL parameter
// Parameters   : iImageDownloadStatus
// Return type  : void
// Comments     : This method is called with parameter value YES when the image is downloaded successfully
///////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)updateImageDownloadStatus:(BOOL)iImageDownloadStatus;

@end
