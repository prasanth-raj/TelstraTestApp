//
//  TTAConstants.m
//  TelstraTestApp
//
//  Created by Prasanth Raj S on 17/10/15.
//  Copyright (c) 2015 Cognizant Technologies Solutions Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

// TTADataListViewCell - constants

static int const  kCellImageVIewWidth = 100;
static int const kCellImageVIewHeight = 100;
static int const kCellHeadingMinHeight = 20;
static CGFloat const kSpaceBetweenCellTopAndDescriptionLabelTop = 30;
static CGFloat const kHorizontalSpacing = 45;

static CGFloat const kHeadingTextAlpha = 1.0;
static CGFloat const kHeadingTextColor = 0xB1F0EE;

static  NSString const * kHeadingLabelFont = @"Helvetica";
static int const kHeadingLabelFontSize = 14;
static  NSString const * kDescriptionLabelFont = @"Helvetica";
static int const kDescriptionLabelFontSize = 12;

static CGFloat const kContentViewAlpha = 1.0;
static CGFloat const kContentViewBackgroundColorTop = 0x1585BB;
static CGFloat const kContentViewBackgroundColorBottom =0x5FD8F3;

//TTADataManager - Constants

static  NSString const * kServerURL = @"https://dl.dropboxusercontent.com/u/746330/facts.json";

// Keys in the response
static  NSString const * kTitle = @"title";
static  NSString const * kDescription = @"description";
static  NSString const * kImageHref = @"imageHref";
static  NSString const * kRows = @"rows";

// TableView Cell Identifier
static  NSString const * kTTADataListViewItemCellID = @"TTADataListViewItemCellID";

// Message Strings used in Handler blocks

static  NSString const * kSuccess = @"Success";
static  NSString const * kUnableToFormatData = @"Unable to format the Data";
static  NSString const * kUnableToRetrieveData = @"Unable to Retrieve the data from Server";

// Common Error string and button title
static  NSString const * kError = @"Error";
static  NSString const * kOk = @"Ok";
static  NSString const * kEmptyString = @"";

// Image names

static  NSString const * kImageNotFoundImage = @"ImageNotFound";
static  NSString const * kRefreshImage = @"refresh";

// ImageView layer constants

static CGFloat const kCornerRadiusForImageView = 15.0f;
static CGFloat const kBorderWidth = 1.5f;


