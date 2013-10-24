//
//  Object.h
//  ModelTest
//
//  Created by Oli Griffiths on 07/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Object;
@protocol ObjectInterface <NSObject>

-(id)initWithConfig:(id<ObjectConfigInterface>)config;
-(id<ObjectConfigInterface>)config;

-(void)construct:(id<ObjectConfigInterface>)config;
-(void)initialize:(id<ObjectConfigInterface>)config;

@end


@interface Object : NSObject <ObjectInterface>

@property (readonly) id<ObjectConfigInterface> config;

@end
