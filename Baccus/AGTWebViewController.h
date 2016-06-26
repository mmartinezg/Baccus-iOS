//
//  AGTWebViewController.h
//  Baccus
//
//  Created by Manuel Martinez Gomez on 18/6/16.
//  Copyright © 2016 mmartinezg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGTWineModel.h"

@interface AGTWebViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) AGTWineModel *model;
@property (weak, nonatomic) IBOutlet UIWebView *browser;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;

-(id) initWithModel: (AGTWineModel *) aModel;

@end
