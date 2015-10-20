//
//  TTADataItem.m
//  TelstraTestApp
//
//  Created by Prasanth Raj S on 17/10/15.
//  Copyright (c) 2015 Cognizant Technologies Solutions Pvt Ltd. All rights reserved.
//

#import "TTADataListItem.h"

@implementation TTADataListItem

- (instancetype) initWithHeading:(NSString *)iHeading withDescription:(NSString *)iDescription withImageURL:(NSString *)iImageURL andIsImageDownloaded:(BOOL)iImageDownloadedStatus; {
    
    TTADataListItem *dataListItem = [[TTADataListItem alloc]init];
    dataListItem.heading = iHeading;
    dataListItem.detailDescription = iDescription;
    dataListItem.iconImage = nil;
    dataListItem.imageURL = iImageURL;
    dataListItem.isImageDownloaded = iImageDownloadedStatus;
    
    return dataListItem;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// Function     : updateIconImage
// Purpose      : To update the iconImage with given UIImage
// Parameters   : iImage
// Return type  : void
// Comments     : None
///////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)updateIconImage:(UIImage *)iImage {
    self.iconImage = iImage;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// Function     : updateImageDownloadStatus
// Purpose      : To update the isImageDownload property with given BOOL parameter
// Parameters   : iImageDownloadStatus
// Return type  : void
// Comments     : This method is called with parameter value YES when the image is downloaded successfully
///////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)updateImageDownloadStatus:(BOOL )iImageDownloadStatus {
    self.isImageDownloaded = iImageDownloadStatus;
}

@end
