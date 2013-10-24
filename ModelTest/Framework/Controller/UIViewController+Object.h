//
//  ViewController+Object.h
//  ModelTest
//
//  Created by Oli Griffiths on 22/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Object)

-(id)initWithConfig:(ObjectConfig*)config;

-(void)construct:(ObjectConfig*)config;

-(void)initialize:(ObjectConfig*)config;

-(ObjectConfig*)config;

-(NSArray*)actions;


@end
