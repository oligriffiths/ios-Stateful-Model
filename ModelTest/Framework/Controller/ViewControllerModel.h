//
//  ViewControllerModel.h
//  ModelTest
//
//  Created by Oli Griffiths on 22/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "ViewControllerAbstract.h"

@protocol Modellable

@optional
-(NSArray*)browse:(NSDictionary*)data;
-(NSManagedObject*)read:(NSDictionary*)data;
-(NSManagedObject*)edit:(NSDictionary*)data;
-(NSManagedObject*)add:(NSDictionary*)data;
-(NSManagedObject*)delete:(NSDictionary*)data;

@end

@interface ViewControllerModel : ViewControllerAbstract <Modellable>

@property (nonatomic) id<ModelInterface> model;

-(NSManagedObject*)_actionAdd:(CommandContext*)context;

-(BOOL)_actionDelete:(CommandContext*)context;

@end
