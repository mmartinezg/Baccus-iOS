//
//  AGTWineModel.h
//  Baccus
//
//  Created by Manuel Martinez Gomez on 4/6/16.
//  Copyright © 2016 mmartinezg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define NO_RATING -1 //Asi declaramos constantes

@interface AGTWineModel : NSObject

@property (copy, nonatomic) NSString *type;
@property (strong, nonatomic, readonly) UIImage *photo;
@property (strong, nonatomic) NSURL *photoURL;
@property (strong, nonatomic) NSURL *wineCompanyWeb;
@property (copy, nonatomic) NSString *notes;
@property (copy, nonatomic) NSString *origin;
@property (nonatomic) int rating; // 0 to 5
@property (strong, nonatomic) NSArray *grapes;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *wineCompanyName;

// Constructores (métodos de clase)
+ (id)wineWithName:(NSString *)aName
   wineCompanyName:(NSString *)aWineryName
              type:(NSString *)aType
            origin:(NSString *)anOrigin
            grapes:(NSArray *)arrayOfGrapes
    wineCompanyWeb:(NSURL *)aURL
             notes:(NSString *)aNotes
            rating:(int)aRating
          photoURL:(NSURL *)aPhotoURL;

+ (id)wineWithName:(NSString *)aName
   wineCompanyName:(NSString *)aWineryName
              type:(NSString *)aType
            origin:(NSString *)anOrigin;


// Inicializador designado
- (id)initWithName:(NSString *)aName
   wineCompanyName:(NSString *)aWineryName
              type:(NSString *)aType
            origin:(NSString *)anOrigin
            grapes:(NSArray *)arrayOfGrapes
    wineCompanyWeb:(NSURL *)aURL
             notes:(NSString *)aNotes
            rating:(int)aRating
          photoURL:(NSURL *)aPhotoURL;

// Inicializadores de conveniencia
- (id)initWithName:(NSString *)aName
   wineCompanyName:(NSString *)aWineryName
              type:(NSString *)aType
            origin:(NSString *)anOrigin;

// Inicializador a partir de diccionario JSON
-(id) initWithDictionary:(NSDictionary *)aDict;

@end