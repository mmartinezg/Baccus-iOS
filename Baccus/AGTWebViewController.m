//
//  AGTWebViewController.m
//  Baccus
//
//  Created by Manuel Martinez Gomez on 18/6/16.
//  Copyright © 2016 mmartinezg. All rights reserved.
//

#import "AGTWebViewController.h"
#import "AGTWineryTableViewController.h"

@interface AGTWebViewController ()

@end

@implementation AGTWebViewController

- (id)initWithModel:(AGTWineModel *)aModel
{
    if (self = [super initWithNibName:nil bundle:nil]) {
        _model = aModel;
        self.title = @"Web";
    }
    
    return self;
}


#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.5
                                                                        green:0
                                                                         blue:0.13
                                                                        alpha:1];
    
    // Alta en notificaciones
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(modelDidChange:)
                                                 name:DID_SELECT_WINE_NOTIFICATION_NAME
                                               object:nil];
    
    [self syncViewToModel];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Baja en notificaciones
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark -  Notifications

- (void)modelDidChange:(NSNotification *)aNotification
{
    AGTWineModel *newWine = [aNotification.userInfo objectForKey:WINE_KEY];
    self.model = newWine;
    
    [self syncViewToModel];
}

#pragma mark -  Memory Management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.activityView setHidden:NO];
    [self.activityView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityView stopAnimating];
    [self.activityView setHidden:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.activityView stopAnimating];
    [self.activityView setHidden:YES];
    
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Error"
                                  message:[error localizedDescription]
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             //Do some thing here
                             [self dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    [alert addAction:ok]; // add action to uialertcontroller
    
    
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark - Utils

- (void)syncViewToModel
{
    self.title = self.model.wineCompanyName;
    self.browser.delegate = self;
    [self.browser loadRequest:[NSURLRequest requestWithURL:self.model.wineCompanyWeb]];
}

@end