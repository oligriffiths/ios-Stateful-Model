//
//  ModelInterface.h
//  ModelTest
//
//  Created by Oli Griffiths on 08/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "ModelStateInterface.h"

@class ModelAbstract;

@protocol ModelInterface <NSObject>

@property (nonatomic, readonly, setter=none:) id<ModelStateInterface> state;
@property (nonatomic, readonly) id row;
@property (nonatomic, readonly) id rowset;
@property (nonatomic, readonly) NSInteger total;
@property (nonatomic, readonly) NSArray* sections;

-(ModelAbstract*)reset:(BOOL)toDefaults;

-(ModelAbstract*)setState:(NSDictionary*)values;

-(id)getState;

-(void)onStateChange:(NSString*)name;

-(id)row;

-(id)rowset;

-(NSInteger)total;


-(id)objectAtIndexPath:(NSIndexPath*)indexPath;

@end


@protocol ModelStateObserver <NSObject>

-(void)onModelStateChange:(NSString*)name;

@end

