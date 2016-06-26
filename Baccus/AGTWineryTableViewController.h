//
//  AGTWineryTableViewController.h
//  Baccus
//
//  Created by Manuel Martinez Gomez on 25/6/16.
//  Copyright © 2016 mmartinezg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGTWineryModel.h"
#import "AGTWineModel.h"

//Constantes
#define RED_WINE_SECTION 0
#define WHITE_WINE_SECTION 1
#define OTHER_WINE_SECTION 2

#define DID_SELECT_WINE_NOTIFICATION_NAME @"newWineSelected"
#define WINE_KEY @"wine"

#define SECTION_KEY @"section"
#define ROW_KEY @"row"
#define LAST_WINE_KEY @"lastWine"

//Esto es una declaracion rápida de clase. Sirve para indicarle al compilador que esto es una clase y no maree
@class AGTWineryTableViewController;

@protocol AGTWineryTableViewControllerDelegate <NSObject>

- (void)wineryTableViewController:(AGTWineryTableViewController *)aWineryVC
                    didSelectWine:(AGTWineModel *)aWine;

@end

@interface AGTWineryTableViewController : UITableViewController<AGTWineryTableViewControllerDelegate>

@property (strong, nonatomic) AGTWineryModel *model;
@property (weak, nonatomic) id<AGTWineryTableViewControllerDelegate> delegate;

// Designado
- (id)initWithModel:(AGTWineryModel *)aModel
              style:(UITableViewStyle)aStyle;

- (AGTWineModel *)lastSelectedWine;

@end