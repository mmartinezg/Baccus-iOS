//
//  AGTWineryModel.m
//  Baccus
//
//  Created by Manuel Martinez Gomez on 25/6/16.
//  Copyright © 2016 mmartinezg. All rights reserved.
//

#import "AGTWineryModel.h"

@interface AGTWineryModel()

@property (strong, nonatomic) NSMutableArray *redWines;
@property (strong, nonatomic) NSMutableArray *whiteWines;
@property (strong, nonatomic) NSMutableArray *otherWines;

@end

@implementation AGTWineryModel

- (NSUInteger)redWineCount
{
    return [self.redWines count];
}

- (NSUInteger)whiteWineCount
{
    return [self.whiteWines count];
}

- (NSUInteger)otherWineCount
{
    return [self.otherWines count];
}


#pragma mark - Init
-(id)init{
    
    if (self = [super init]) {
        
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://static.keepcoding.io/baccus/wines.json"]];
        
        NSURLSession *session = [NSURLSession sharedSession];
        
        NSURLSessionDataTask * downloadWines = [session dataTaskWithRequest: request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if(error == nil){
                // No ha habido error
                NSArray * JSONObjects = [NSJSONSerialization JSONObjectWithData:data
                                                                        options:kNilOptions
                                                                          error:&error];
                
                if (JSONObjects != nil) {
                    // No ha habido error
                    for(NSDictionary *dict in JSONObjects){
                        AGTWineModel *wine = [[AGTWineModel alloc] initWithDictionary:dict];
                        
                        // Añadimos al tipo adecuado
                        if ([wine.type isEqualToString:RED_WINE_KEY]) {
                            if (!self.redWines) {
                                self.redWines = [NSMutableArray arrayWithObject:wine];
                            }
                            else {
                                [self.redWines addObject:wine];
                            }
                        }
                        else if ([wine.type isEqualToString:WHITE_WINE_KEY]) {
                            if (!self.whiteWines) {
                                self.whiteWines = [NSMutableArray arrayWithObject:wine];
                            }
                            else {
                                [self.whiteWines addObject:wine];
                            }                    }
                        else {
                            if (!self.otherWines) {
                                self.otherWines = [NSMutableArray arrayWithObject:wine]; //fix/11a
                            }
                            else {
                                [self.otherWines addObject:wine]; //fix/11a
                            }
                        }
                    }
                }else{
                    // Se ha producido un error al parsear el JSON
                    NSLog(@"Error al parsear JSON: %@", error.localizedDescription);
                }
            }else{
                // Error al descargar los datos del servidor
                NSLog(@"Error al descargar datos del servidor: %@", error.localizedDescription);
            }
            dispatch_semaphore_signal(sema);
        }];
        
        [downloadWines resume];
         dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }
    return self;
}



#pragma mark - Other

- (AGTWineModel *)redWineAtIndex:(NSUInteger)index
{
    return [self.redWines objectAtIndex:index];
}

- (AGTWineModel *)whiteWineAtIndex:(NSUInteger)index
{
    return [self.whiteWines objectAtIndex:index];
}

- (AGTWineModel *)otherWineAtIndex:(NSUInteger)index
{
    return [self.otherWines objectAtIndex:index];
}

@end