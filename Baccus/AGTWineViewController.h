//
//  AGTWineViewController.h
//  Baccus
//
//  Created by Manuel Martinez Gomez on 4/6/16.
//  Copyright © 2016 mmartinezg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGTWineModel.h"
#import "AGTWineryTableViewController.h"

@interface AGTWineViewController : UIViewController<UISplitViewControllerDelegate, AGTWineryTableViewControllerDelegate>

// Propiedades
@property (strong, nonatomic) AGTWineModel *model;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *wineryNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *originLabel;
@property (weak, nonatomic) IBOutlet UILabel *grapesLabel;
@property (weak, nonatomic) IBOutlet UILabel *notesLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *ratingViews;
@property (weak, nonatomic) IBOutlet UIButton *webButton;


- (id)initWithModel:(AGTWineModel *)aModel;

- (IBAction)displayWebpage:(id)sender;

@end
