//
//  TTADataListCellTableViewCell.m
//  TelstraTestApp
//
//  Created by Prasanth Raj S on 17/10/15.
//  Copyright (c) 2015 Cognizant Technologies Solutions Pvt Ltd. All rights reserved.
//

#import "TTADataListViewCell.h"
#import "TTAConstants.h"

@implementation TTADataListViewCell
@synthesize itemDescription;
@synthesize itemHeading;
@synthesize itemIconImageView;
// Initializer
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        itemHeading = [[UILabel alloc]initWithFrame:CGRectZero];
        itemHeading.lineBreakMode = NSLineBreakByWordWrapping;
        itemHeading.numberOfLines = 0;
        itemHeading.translatesAutoresizingMaskIntoConstraints = NO;
        itemHeading.font = [UIFont fontWithName:(NSString*)kHeadingLabelFont size:kHeadingLabelFontSize];
        itemHeading.textAlignment = NSTextAlignmentJustified;
        itemHeading.textColor = [TTADataListViewCell UIColorFromHex:kHeadingTextColor alphaParam:kHeadingTextAlpha];
        [self.contentView addSubview:itemHeading];
        
        itemDescription = [[UILabel alloc]initWithFrame:CGRectZero];
        itemDescription.lineBreakMode = NSLineBreakByWordWrapping;
        itemDescription.numberOfLines = 0;
        itemDescription.translatesAutoresizingMaskIntoConstraints = NO;
        itemDescription.font = [UIFont fontWithName:(NSString*)kDescriptionLabelFont size:kDescriptionLabelFontSize];
        itemDescription.textAlignment = NSTextAlignmentJustified;
        [self.contentView addSubview:itemDescription];
        
        itemIconImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:itemIconImageView];
    }
    
    return self;
}

- (void)layoutSubviews
{
    
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[TTADataListViewCell UIColorFromHex:kContentViewBackgroundColorTop alphaParam:kContentViewAlpha] CGColor], (id)[[TTADataListViewCell UIColorFromHex:kContentViewBackgroundColorBottom alphaParam:kContentViewAlpha] CGColor], nil];
    
    [self setBackgroundView:[[UIView alloc] init]];
    [self.backgroundView.layer insertSublayer:gradient atIndex:0];
    
    [super layoutSubviews];
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    [itemDescription setPreferredMaxLayoutWidth:self.contentView.frame.size.width-kCellImageVIewWidth-40 ];
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// Function     : showActivityIndicator
// Purpose      : To show activity indicator.
// Parameters   : None
// Return type  : Void
// Comments     : None
///////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) showActivityIndicator {
    self.iconLoadingActivityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:itemIconImageView.frame];
    self.iconLoadingActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [itemIconImageView addSubview:self.iconLoadingActivityIndicator];
    self.iconLoadingActivityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    // Adding constraints
    [itemIconImageView addConstraint:[NSLayoutConstraint constraintWithItem:self.iconLoadingActivityIndicator
                                                                 attribute:NSLayoutAttributeTrailing
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:itemIconImageView
                                                                 attribute:NSLayoutAttributeTrailing
                                                                multiplier:1.0
                                                                  constant:0.0]];
    [itemIconImageView addConstraint:[NSLayoutConstraint constraintWithItem:self.iconLoadingActivityIndicator
                                                                       attribute:NSLayoutAttributeLeading
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:itemIconImageView
                                                                       attribute:NSLayoutAttributeLeading
                                                                      multiplier:1.0
                                                                        constant:0.0]];
    
    [itemIconImageView addConstraint:[NSLayoutConstraint constraintWithItem:self.iconLoadingActivityIndicator
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:itemIconImageView
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1.0
                                                                        constant:0.0]];
    [itemIconImageView addConstraint:[NSLayoutConstraint constraintWithItem:self.iconLoadingActivityIndicator
                                                                       attribute:NSLayoutAttributeBottom
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:itemIconImageView
                                                                       attribute:NSLayoutAttributeBottom
                                                                      multiplier:1.0
                                                                        constant:0.0]];
    [self.iconLoadingActivityIndicator startAnimating];
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// Function     : hideActivityIndicator
// Purpose      : To hide activity indicator.
// Parameters   : None
// Return type  : Void
// Comments     : None
///////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) hideActivityIndicator {
    [self.iconLoadingActivityIndicator stopAnimating];
    [self.iconLoadingActivityIndicator removeFromSuperview];
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// Function     : addImageToIconImageView
// Purpose      : To add image to to the itemIconImageView property
// Parameters   : iImage
// Return type  : Void
// Comments     : This method adds round corner style to the itemIconImageView in the cell
///////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) addImageToIconImageView :(UIImage *)iImage {
    [itemIconImageView setImage:iImage];
    [itemIconImageView.layer setCornerRadius:kCornerRadiusForImageView];
    [itemIconImageView.layer setBorderWidth:kBorderWidth];
    [itemIconImageView.layer setBorderColor:[UIColor darkTextColor].CGColor];
    itemIconImageView.contentMode   = UIViewContentModeScaleAspectFill;
    itemIconImageView.clipsToBounds = YES;
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// Function     : UIColorFromHex
// Purpose      : To convert hex color value to UIColor object
// Parameters   : rgbValue, alpha
// Return type  : Void
// Comments     : None
///////////////////////////////////////////////////////////////////////////////////////////////////////////
+ (UIColor *) UIColorFromHex:(int32_t)rgbValue alphaParam:(double)alpha {
    CGFloat red = (CGFloat)((rgbValue & 0xFF0000) >> 16)/256.0;
    CGFloat green = (CGFloat)((rgbValue & 0xFF00) >> 8)/256.0;
    CGFloat blue = (CGFloat)(rgbValue & 0xFF)/256.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}
 
@end
