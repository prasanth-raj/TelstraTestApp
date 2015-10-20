//
//  TTADataListCellTableViewCell.h
//  TelstraTestApp
//
//  Created by Prasanth Raj S on 17/10/15.
//  Copyright (c) 2015 Cognizant Technologies Solutions Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface TTADataListViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *itemIconImageView;
@property (nonatomic, strong) UILabel *itemDescription;
@property (nonatomic, strong) UILabel *itemHeading;
@property (nonatomic, strong) UIActivityIndicatorView *iconLoadingActivityIndicator;

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// Function     : showActivityIndicator
// Purpose      : To show activity indicator.
// Parameters   : None
// Return type  : Void
// Comments     : None
///////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) showActivityIndicator;

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// Function     : hideActivityIndicator
// Purpose      : To hide activity indicator.
// Parameters   : None
// Return type  : Void
// Comments     : None
///////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) hideActivityIndicator;

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// Function     : addImageToIconImageView
// Purpose      : To add image to to the itemIconImageView property
// Parameters   : iImage
// Return type  : Void
// Comments     : This method adds round corner style to the itemIconImageView in the cell
///////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) addImageToIconImageView :(UIImage *)iImage;

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// Function     : UIColorFromHex
// Purpose      : To convert hex color value to UIColor object
// Parameters   : rgbValue, alpha
// Return type  : Void
// Comments     : None
///////////////////////////////////////////////////////////////////////////////////////////////////////////
+ (UIColor *) UIColorFromHex:(int32_t)rgbValue alphaParam:(double)alpha;
@end
