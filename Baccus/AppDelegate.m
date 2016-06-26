//
//  AppDelegate.m
//  Baccus
//
//  Created by Manuel Martinez Gomez on 4/6/16.
//  Copyright © 2016 mmartinezg. All rights reserved.
//

#import "AppDelegate.h"
#import "AGTWineModel.h"
#import "AGTWineViewController.h"
#import "AGTWebViewController.h"
#import "AGTWineryModel.h"
#import "AGTWineryTableViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Creamos un modelo
    AGTWineryModel *model = [[AGTWineryModel alloc] init];
    
    //Configuramos controladores, combinadores y delegados segun el tipo de dispositivo
    UIViewController *rootVC = nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        // Pantalla grande
        rootVC = [self rootViewControllerForPadWithModel: model];
    }else{
        // Pantalla pequeña
        rootVC = [self rootViewControllerForPhoneWithModel: model];
    }
    
    /*// Controladores
    AGTWineryTableViewController *wineryVC = [[AGTWineryTableViewController alloc] initWithModel:model style:UITableViewStylePlain];
    AGTWineViewController *wineVC = [[AGTWineViewController alloc] initWithModel:[wineryVC lastSelectedWine]];
    
    // Combinadores
    UINavigationController *wineNav = [[UINavigationController alloc] initWithRootViewController:wineVC];
    UINavigationController *wineryNav = [[UINavigationController alloc] initWithRootViewController:wineryVC];
    
    UISplitViewController *splitVC = [[UISplitViewController alloc] init];
    splitVC.viewControllers = @[wineryNav, wineNav];
    
    
    // Delegados
    splitVC.delegate = wineVC;
    wineryVC.delegate = wineVC;*/
    
    // Lo asignamos como controlador raíz
    self.window.rootViewController = rootVC;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - Estableces los Controllers dependientes del hardware
-(UIViewController *) rootViewControllerForPadWithModel: (AGTWineryModel *) aModel{
    AGTWineryTableViewController *wineryVC = [[AGTWineryTableViewController alloc] initWithModel:aModel
                                                                                           style:UITableViewStylePlain];
    AGTWineViewController *wineVC = [[AGTWineViewController alloc] initWithModel:[wineryVC lastSelectedWine]];
    
    // Combinadores
    UINavigationController *wineNav = [[UINavigationController alloc] initWithRootViewController:wineVC];
    UINavigationController *wineryNav = [[UINavigationController alloc] initWithRootViewController:wineryVC];
    
    UISplitViewController *splitVC = [[UISplitViewController alloc] init];
    splitVC.viewControllers = @[wineryNav, wineNav];
    
    
    // Delegados
    splitVC.delegate = wineVC;
    wineryVC.delegate = wineVC;
    
    return splitVC;
}

-(UIViewController *) rootViewControllerForPhoneWithModel:(AGTWineryModel *)aModel{
    //Controladores
    AGTWineryTableViewController *wineryVC = [[AGTWineryTableViewController alloc] initWithModel:aModel
                                                                                           style:UITableViewStylePlain];
    
    //Combinador
    UINavigationController *wineryNav = [[UINavigationController alloc] initWithRootViewController:wineryVC];
    
    //Delegados
    wineryVC.delegate = wineryVC;
    
    return wineryNav;
}

@end
