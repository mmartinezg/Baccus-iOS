//
//  AGTWineViewController.m
//  Baccus
//
//  Created by Manuel Martinez Gomez on 4/6/16.
//  Copyright © 2016 mmartinezg. All rights reserved.
//

#import "AGTWineViewController.h"
#import "AGTWebViewController.h"


@implementation AGTWineViewController

- (id)initWithModel:(AGTWineModel *)aModel
{
    if (self = [super initWithNibName:nil bundle:nil]) {
        _model = aModel;
        self.title = aModel.name;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.5
                                                                        green:0
                                                                         blue:0.13
                                                                        alpha:1];
    
    if([[[UIDevice currentDevice] systemVersion] floatValue]>=7)
    {
        self.edgesForExtendedLayout =UIRectEdgeNone;
    }
    
    [self syncViewToModel];
}


#pragma mark - Actions

- (IBAction)displayWebpage:(id)sender
{
    AGTWebViewController *webVC = [[AGTWebViewController alloc] initWithModel:self.model];
    
    [self.navigationController pushViewController:webVC animated:YES];
}


#pragma mark - Utils

- (void)clearRatings
{
    for (UIImageView *each in self.ratingViews) {
        each.image = nil;
    }
}

- (void)displayRating:(int)aRatingValue
{
    [self clearRatings];
    
    UIImage *glass = [UIImage imageNamed:@"splitView_score_glass@2x.png"];
    
    for (int i = 0; i < aRatingValue; i++) {
        [[self.ratingViews objectAtIndex:i] setImage:glass];
    }
}

- (void)syncViewToModel
{
    self.nameLabel.text = self.model.name;
    self.typeLabel.text = self.model.type;
    self.originLabel.text = self.model.origin;
    self.wineryNameLabel.text = self.model.wineCompanyName;
    self.notesLabel.text = self.model.notes;
    [self.notesLabel setNumberOfLines:0];
    self.photoView.image = self.model.photo;
    self.grapesLabel.text = [self arrayToString:self.model.grapes];
    [self displayRating:self.model.rating];
    //self.webButton.enabled = (BOOL)self.model.wineCompanyWeb;
    if(self.model.wineCompanyWeb != nil){
        self.webButton.enabled = YES;
    }else{
       self.webButton.enabled = NO;
    }
    
}

- (NSString *)arrayToString:(NSArray *)anArray
{
    NSString *repr;
    
    if ([anArray count] == 1) {
        repr = [@"100% " stringByAppendingString: [anArray lastObject]];
    }
    else {
        repr = [[anArray componentsJoinedByString:@", "] stringByAppendingString:@"."];
    }
    
    return repr;
}


#pragma mark - UISplitViewControllerDelegate

-(void) splitViewController:(UISplitViewController *)svc

    willChangeToDisplayMode:(UISplitViewControllerDisplayMode)displayMode {
    
    if (displayMode == UISplitViewControllerDisplayModePrimaryHidden)
    {
        
        self.navigationItem.leftBarButtonItem = svc.displayModeButtonItem;
    }
    
    else
    {
        
        self.navigationItem.leftBarButtonItem = nil;
    }
    
}


#pragma mark -  AGTWineryTableViewControllerDelegate

- (void)wineryTableViewController:(AGTWineryTableViewController *)aWineryVC
                    didSelectWine:(AGTWineModel *)aWine
{
    self.model = aWine;
    self.title = aWine.name;
    [self syncViewToModel];
}

@end