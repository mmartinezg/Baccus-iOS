//
//  AGTWineryTableViewController.m
//  Baccus
//
//  Created by Manuel Martinez Gomez on 25/6/16.
//  Copyright © 2016 mmartinezg. All rights reserved.
//

#import "AGTWineryTableViewController.h"
#import "AGTWineViewController.h"

@interface AGTWineryTableViewController ()

@end

@implementation AGTWineryTableViewController

#pragma mark -  Init

- (id)initWithModel:(AGTWineryModel *)aModel
              style:(UITableViewStyle)aStyle
{
    if (self = [super initWithStyle:aStyle]) {
        _model = aModel;
        self.title = @"Baccus";
    }
    
    return self;
}


#pragma mark -  View Lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.5
                                                                        green:0
                                                                         blue:0.13
                                                                        alpha:1];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 0;
    
    if (section == RED_WINE_SECTION) {
        count = [self.model redWineCount];
    }
    else if (section == WHITE_WINE_SECTION) {
        count = [self.model whiteWineCount];
    }
    else {
        count = [self.model otherWineCount];
    }
    
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"WineCell";
    
    // Averiguamos de qué vino se trata
    AGTWineModel *wine = [self wineForIndexPath:indexPath];
    // Creamos una celda
    UITableViewCell *wineCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (wineCell == nil) {
        // La creamos de cero
        wineCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                          reuseIdentifier:CellIdentifier];
    }
    
    // Sincronizamos modelo con vista (celda)
    wineCell.imageView.image = wine.photo;
    wineCell.textLabel.text = wine.name;
    wineCell.detailTextLabel.text = wine.wineCompanyName;
    
    return wineCell;
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName = nil;
    
    if (section == RED_WINE_SECTION) {
        sectionName = @"Tinto";
    }
    else if (section == WHITE_WINE_SECTION){
        sectionName = @"Blanco";
    }
    else{
        sectionName = @"Otros";
    }
    
    return sectionName;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Escogemos el vino seleccionado
    AGTWineModel *wine = [self wineForIndexPath:indexPath];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){//Ipad
        // Avisar al delegado
        [self.delegate wineryTableViewController:self didSelectWine:wine];
        
        // Enviar notificación
        NSNotification *n = [NSNotification notificationWithName:DID_SELECT_WINE_NOTIFICATION_NAME
                                                          object:self
                                                        userInfo:@{WINE_KEY: wine}];
        [[NSNotificationCenter defaultCenter] postNotification:n];
        
        // Guardar el último vino seleccionado
        [self saveLastSelectedWineAtSection:indexPath.section
                                        row:indexPath.row];
    }else{//Iphone
        AGTWineViewController * wineVC = [[AGTWineViewController alloc] initWithModel: wine];
        [self.navigationController pushViewController:wineVC animated:YES];
    }
}


#pragma mark -  Utils

- (AGTWineModel *)wineForIndexPath:(NSIndexPath *)indexPath
{
    // Averiguamos de qué vino se trata
    AGTWineModel *wine = nil;
    
    if (indexPath.section == RED_WINE_SECTION) {
        wine = [self.model redWineAtIndex:indexPath.row];
    }
    else if (indexPath.section == WHITE_WINE_SECTION) {
        wine = [self.model whiteWineAtIndex:indexPath.row];
    }
    else {
        wine = [self.model otherWineAtIndex:indexPath.row];
    }
    
    return wine;
}

#pragma mark -  NSUserDefaults

- (NSDictionary *)setDefaults
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // Por defecto, mostraremos el primero de los tintos
    NSDictionary *defaultWineCoords = @{SECTION_KEY : @(RED_WINE_SECTION), ROW_KEY : @0};
    
    // lo asignamos
    [defaults setObject:defaultWineCoords
                 forKey:LAST_WINE_KEY];
    // guardamos por si las moscas
    [defaults synchronize];
    
    return defaultWineCoords;
    
}

- (void)saveLastSelectedWineAtSection:(NSUInteger)section row:(NSUInteger)row
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@{SECTION_KEY : @(section),
                          ROW_KEY     : @(row)}
                 forKey:LAST_WINE_KEY];
    
    [defaults synchronize]; // Por si acaso, que Murphy acecha.
}

- (AGTWineModel *)lastSelectedWine
{
    NSIndexPath *indexPath = nil;
    NSDictionary *coords = nil;
    
    coords = [[NSUserDefaults standardUserDefaults] objectForKey:LAST_WINE_KEY];
    
    if (coords == nil) {
        // No hay nada bajo la clave LAST_WINE_KEY.
        // Esto quiere decir que es la primera vez que se llama a la App
        // Ponemos un valor por defecto: el primero de los tintos
        coords = [self setDefaults];
    }else{
        // Ya hay algo, es decir, en algún momento se guardó.
        // No hay nada en especial que hacer.
    }
    
    // Transformamos esas coordenadas en un indexpath
    indexPath = [NSIndexPath indexPathForRow:[[coords objectForKey: ROW_KEY] integerValue]
                                   inSection:[[coords objectForKey: SECTION_KEY] integerValue]];
    
    // devolvemos el vino en cuestión
    return [self wineForIndexPath:indexPath];
}

#pragma mark -  AGTWineryTableViewControllerDelegate
- (void)wineryTableViewController:(AGTWineryTableViewController *)aWineryVC
                    didSelectWine:(AGTWineModel *)aWine{
    //Crear el controlador
    AGTWineViewController * wineVC = [[AGTWineViewController alloc] initWithModel: aWine];
    
    //Hacer un push
    [self.navigationController pushViewController: wineVC
                                         animated:YES];
}

@end