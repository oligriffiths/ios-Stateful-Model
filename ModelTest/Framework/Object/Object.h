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

-(id)initWithConfig:(ObjectConfig*)config;
-(ObjectConfig*)config;

-(void)construct:(ObjectConfig*)config;
-(void)initialize:(ObjectConfig*)config;

@end


@interface Object : NSObject <ObjectInterface>

@property (readonly) ObjectConfig *config;

@end
