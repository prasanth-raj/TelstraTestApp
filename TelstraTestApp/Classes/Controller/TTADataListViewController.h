//
//  TTADataListViewController.h
//  TelstraTestApp
//
//  Created by Prasanth Raj S on 17/10/15.
//  Copyright (c) 2015 Cognizant Technologies Solutions Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTADataListItemManager.h"

@interface TTADataListViewController : UITableViewController

@property (nonatomic,strong) NSMutableArray *heightArray;
@property (nonatomic, strong) UIActivityIndicatorView *dataLoadingActivityIndicator;

@end
