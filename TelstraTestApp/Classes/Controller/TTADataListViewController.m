//
//  TTADataListViewController.m
//  TelstraTestApp
//
//  Created by Prasanth Raj S on 17/10/15.
//  Copyright (c) 2015 Cognizant Technologies Solutions Pvt Ltd. All rights reserved.
//

#import "TTADataListViewController.h"
#import "TTADataListViewCell.h"
#import "TTADataListItem.h"
#import "TTAConstants.h"

@interface TTADataListViewController ()

@end

@implementation TTADataListViewController

@synthesize heightArray ;
@synthesize dataLoadingActivityIndicator;

#pragma mark - View Controller's Life Cycle methods
// View Controller's Life Cycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    heightArray = [[NSMutableArray alloc]init];
    [self addRefreshButton];
    [self loadDataIntoTableView];
    UIEdgeInsets inset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.contentInset = inset;
    self.tableView.allowsSelection = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source and delegate Methods

// Table view Data Source and Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [TTADataListItemManager sharedManager].dataItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Create a reusable cell
    TTADataListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString*)kTTADataListViewItemCellID];
    if(!cell) {
        cell = [[TTADataListViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:(NSString*)kTTADataListViewItemCellID];
    }
    cell.itemIconImageView.image = nil;
    TTADataListItem *dataListItem = [[TTADataListItemManager sharedManager].dataItems objectAtIndex:indexPath.row];
    cell.itemDescription.text = dataListItem.detailDescription;
    cell.itemHeading.text = dataListItem.heading;
    NSString *imageNotFoundFile  = [[NSBundle mainBundle] pathForResource:(NSString*)kImageNotFoundImage ofType:@"jpg"];
    if (!dataListItem.isImageDownloaded) {  // checking image is already downloaded or not
        
        if (![dataListItem.imageURL isEqualToString:(NSString*)kEmptyString]) { // checking Image URL is empty or not
            [cell showActivityIndicator];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSError *error;
                UIImage *iconImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dataListItem.imageURL] options:0 error:&error]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [cell hideActivityIndicator];
            
                    if (error == nil) {
                        [cell addImageToIconImageView:iconImage];
                    }else {
                         [cell addImageToIconImageView:[UIImage imageNamed:(NSString*)imageNotFoundFile]];
                    }
                    [dataListItem updateIconImage: cell.itemIconImageView.image]; // update iconImage in the TTADataListItem
                    [dataListItem updateImageDownloadStatus:YES];
                });
            });
        }else {
            // When Image URL is empty
            [cell addImageToIconImageView:[UIImage imageNamed:(NSString*)imageNotFoundFile]];
        }
    } else {
        // Image had already been downloaded and now image is reading from TTADataListItem
        if (dataListItem.iconImage != nil)
            [cell addImageToIconImageView:dataListItem.iconImage];
    }
    [self addConstraintsToContent:cell];   // Adding constraints to the views in the content view
    cell.separatorInset = UIEdgeInsetsZero;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[heightArray objectAtIndex:indexPath.row] floatValue];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell   forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// Function     : addConstraintsToContent
// Purpose      : To add constraints to the views in the content view
// Parameters   : TTADataListViewCell
// Return type  : Void
// Comments     : This method is called in viewDidLoad and refreshButtonAction methods.
///////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) addConstraintsToContent:(TTADataListViewCell *)iCell {
    
    iCell.itemIconImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [iCell.contentView addSubview:iCell.itemIconImageView];
    // Adding constraints to itemIconImageView
    [iCell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:iCell.itemIconImageView
                                                                  attribute:NSLayoutAttributeTrailing
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:iCell.contentView
                                                                  attribute:NSLayoutAttributeTrailing
                                                                 multiplier:1.0
                                                                   constant:-15.0]];
    
    [iCell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:iCell.itemIconImageView
                                                                  attribute:NSLayoutAttributeWidth
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                 multiplier:1.0
                                                                   constant:kCellImageVIewWidth]];

    
    [iCell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:iCell.itemIconImageView
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                 multiplier:1.0
                                                                   constant:kCellImageVIewHeight]];
    
    [iCell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:iCell.itemIconImageView
                                                                  attribute:NSLayoutAttributeCenterY
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:iCell.contentView
                                                                  attribute:NSLayoutAttributeCenterY
                                                                 multiplier:1.0
                                                                   constant:0.0]];
    
    // Adding constraints to itemHeadingLabel
    
    iCell.itemHeading.translatesAutoresizingMaskIntoConstraints = NO;
    
    [iCell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:iCell.itemHeading
                                                                  attribute:NSLayoutAttributeLeading
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:iCell.contentView
                                                                  attribute:NSLayoutAttributeLeading
                                                                 multiplier:1.0
                                                                   constant:5.0]];
    
    [iCell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:iCell.itemHeading
                                                                  attribute:NSLayoutAttributeTrailing
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:iCell.itemIconImageView
                                                                  attribute:NSLayoutAttributeLeft
                                                                 multiplier:1.0
                                                                   constant:-20]];
    
    [iCell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:iCell.itemHeading
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:iCell.contentView
                                                                  attribute:NSLayoutAttributeTop
                                                                 multiplier:1.0
                                                                   constant:3.0]];
    
    [iCell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:iCell.itemHeading
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationLessThanOrEqual
                                                                  toItem:nil
                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                  multiplier:1.0
                                                                  constant:kCellHeadingMinHeight]];
    
    // // Adding constraints to itemDescriptionLabel
    
    iCell.itemDescription.translatesAutoresizingMaskIntoConstraints = NO;
    [iCell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:iCell.itemDescription
                                                                  attribute:NSLayoutAttributeLeading
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:iCell.contentView
                                                                  attribute:NSLayoutAttributeLeading
                                                                 multiplier:1.0
                                                                   constant:5.0]];
    
    [iCell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:iCell.itemDescription
                                                                  attribute:NSLayoutAttributeTrailing
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:iCell.itemIconImageView
                                                                  attribute:NSLayoutAttributeLeft
                                                                 multiplier:1.0
                                                                   constant:-20]];
    
    
    [iCell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:iCell.itemDescription
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:iCell.itemHeading
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1.0
                                                                   constant:5.0]];
    
    [iCell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:iCell.itemDescription
                                                                  attribute:NSLayoutAttributeBottom
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:iCell.contentView
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1.0
                                                                   constant:0.0]];
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// Function     : loadDataIntoTableView
// Purpose      : To loads retrieved data into tableview.
// Parameters   : None
// Return type  : Void
// Comments     : This method is called in viewDidLoad and refreshButtonAction methods.
///////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)loadDataIntoTableView {
    [self showActivityIndicator];
    [[TTADataListItemManager sharedManager] retrieveAndAddDataFromRemoteServerURL:(NSString *)kServerURL WithCompletionHandler:^(BOOL status, NSString *message){
        
        [self hideActivityIndicator];
        if (!status) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:(NSString*)kError message:message delegate:nil cancelButtonTitle:(NSString*)kOk otherButtonTitles:nil];
            [alert show];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setScreenTitle:[TTADataListItemManager sharedManager].mainTitle];
                [self findHeights];
                [self.tableView reloadData];
            });
        }
    }];
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// Function     : findHeights
// Purpose      : To estimate and stor height values of cells with respect to TTADataListItem.
// Parameters   : None
// Return type  : Void
// Comments     : Height values will be calculated for each TTADataListItem in the dataItems in the
//                TTADataListItemManager and stores in the heightArray property
///////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) findHeights {
    [heightArray removeAllObjects];
    TTADataListViewCell *cell = [[TTADataListViewCell alloc] init];
    CGFloat height = 0.0f;

    for (TTADataListItem *dataListItem in [TTADataListItemManager sharedManager].dataItems) {
        height = [self findSizeOfString:dataListItem.detailDescription andView:cell.itemDescription andWidth:cell.contentView.frame.size.width-kCellImageVIewWidth-kHorizontalSpacing].height;
        if (height < kCellImageVIewHeight)
            height = kCellImageVIewHeight;
        height += kSpaceBetweenCellTopAndDescriptionLabelTop;  //  adding space between cell content view top border and description label top
        [heightArray addObject:[NSNumber numberWithFloat:height]];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// Function     : findSizeOfString
// Purpose      : To estimate the height and width of the UIView(UILabel), with given string and given width.
// Parameters   : string, viewItem, width
// Return type  : Void
// Comments     : This method helps to find the cell height
///////////////////////////////////////////////////////////////////////////////////////////////////////////
- (CGSize)findSizeOfString:(NSString *)iString andView:(UIView *)iViewItem andWidth:(CGFloat)iWidth {
    UIFont *font = [UIFont fontWithName:(NSString*)kDescriptionLabelFont size:kDescriptionLabelFontSize];
    CGSize labelSize = [iString boundingRectWithSize:CGSizeMake(iWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName :font } context:nil].size;
    
    return labelSize;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// Function     : setScreenTitle
// Purpose      : To set title to the navigation bar.
// Parameters   : iTitle
// Return type  : Void
// Comments     : None
///////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) setScreenTitle:(NSString *) iTitle {
    [self.navigationItem setTitle:iTitle];
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// Function     : addRefreshButton
// Purpose      : To add refresh button to the navigation bar.
// Parameters   : None
// Return type  : Void
// Comments     : None
///////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) addRefreshButton {
    UIButton *btn = [[UIButton alloc]init];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:(NSString*)kRefreshImage ofType:@"png"];
    [btn setBackgroundImage:[UIImage imageNamed:filePath] forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, 100, 18, 17);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [btn addTarget:self action:@selector(refreshButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// Function     : refreshButtonAction
// Purpose      : To handle tap event on refreshButton
// Parameters   : None
// Return type  : Void
// Comments     : It calls loadDataIntoTableView methods to get data from server and refresh the tableview
///////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) refreshButtonAction:(id)sender {
    [self loadDataIntoTableView];
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// Function     : showActivityIndicator
// Purpose      : To show activity indicator.
// Parameters   : None
// Return type  : Void
// Comments     : None
///////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) showActivityIndicator {
    dataLoadingActivityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:self.view.frame];
    dataLoadingActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.view addSubview:dataLoadingActivityIndicator];
    dataLoadingActivityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    [dataLoadingActivityIndicator setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [self.view bringSubviewToFront:dataLoadingActivityIndicator];
    
    // Adding constraints
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:dataLoadingActivityIndicator
                                                                       attribute:NSLayoutAttributeTrailing
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.view
                                                                       attribute:NSLayoutAttributeTrailing
                                                                      multiplier:1.0
                                                                        constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:dataLoadingActivityIndicator
                                                                       attribute:NSLayoutAttributeLeading
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.view
                                                                       attribute:NSLayoutAttributeLeading
                                                                      multiplier:1.0
                                                                        constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:dataLoadingActivityIndicator
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.view
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1.0
                                                                        constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:dataLoadingActivityIndicator
                                                                       attribute:NSLayoutAttributeBottom
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.view
                                                                       attribute:NSLayoutAttributeBottom
                                                                      multiplier:1.0
                                                                        constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:dataLoadingActivityIndicator
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:dataLoadingActivityIndicator
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0.0]];
    [dataLoadingActivityIndicator startAnimating];
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// Function     : hideActivityIndicator
// Purpose      : To hide activity indicator.
// Parameters   : None
// Return type  : Void
// Comments     : None
///////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) hideActivityIndicator {
    [dataLoadingActivityIndicator stopAnimating];
    [dataLoadingActivityIndicator removeFromSuperview];
}

@end
