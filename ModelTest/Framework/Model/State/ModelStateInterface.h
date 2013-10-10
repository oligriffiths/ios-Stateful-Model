//
//  ModelStateInterface.h
//  ModelTest
//
//  Created by Oli Griffiths on 08/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

@class ModelState;

@protocol ModelStateInterface <NSObject>

-(ModelState*)insert:(NSString*)name filter:(id)filter default:(id)fallback unique:(BOOL)unique;

-(ModelState*)insert:(NSString*)name filter:(id)filter default:(id)fallback unique:(BOOL)unique required:(NSArray*)required operator:(NSString*)operator;

-(id)get:(NSString*)name;

-(id)get:(NSString*)name default:(NSString*)fallback;

-(ModelState*)setValue:(NSString*)value forState:(NSString*)name;

-(BOOL)has:(NSString*)name;

-(ModelState*)remove:(NSString*)name;

-(ModelState*)reset;

-(ModelState*)reset:(BOOL)toDefaults;

-(ModelState*)setValues:(NSDictionary*)values;

-(NSDictionary*)values;

-(NSDictionary*)values:(BOOL)unique;

-(BOOL)isUnique;

-(BOOL)isEmpty;

-(BOOL)isEmpty: (NSArray*) excludes;

@end