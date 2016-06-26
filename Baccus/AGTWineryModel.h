//
//  AGTWineryModel.h
//  Baccus
//
//  Created by Manuel Martinez Gomez on 25/6/16.
//  Copyright © 2016 mmartinezg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AGTWineModel.h"

#define RED_WINE_KEY    @"Tinto"
#define WHITE_WINE_KEY  @"Blanco"
#define OTHER_WINE_KEY  @"Rosado"

@interface AGTWineryModel : NSObject

@property (nonatomic, readonly) NSUInteger redWineCount;
@property (nonatomic, readonly) NSUInteger whiteWineCount;
@property (nonatomic, readonly) NSUInteger otherWineCount;

- (AGTWineModel *)redWineAtIndex:(NSUInteger)index;
- (AGTWineModel *)whiteWineAtIndex:(NSUInteger)index;
- (AGTWineModel *)otherWineAtIndex:(NSUInteger)index;

@end