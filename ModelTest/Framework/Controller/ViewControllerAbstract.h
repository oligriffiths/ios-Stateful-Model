//
//  AbstractViewController.h
//  ModelTest
//
//  Created by Oli Griffiths on 22/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Object.h"


@interface ViewControllerAbstract : UIViewController <ObjectInterface>

-(id)execute:(NSString*)action withData:(NSDictionary*)data;
-(id)execute:(NSString*)action withContext:(CommandContext*)context;

@end
