//
//  ViewController+Object.m
//  ModelTest
//
//  Created by Oli Griffiths on 22/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "UIViewController+Object.h"
#import <objc/runtime.h>

@implementation UIViewController (Object)

+ (void)load {
    
    //Swizzle methods
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(init)), class_getInstanceMethod(self, @selector(customInit)));
    
    //Swizzle methods
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(initWithCoder:)), class_getInstanceMethod(self, @selector(customInitWithCoder:)));
}

- (id)customInit
{
    id result = [self customInit];
    
    [self construct:self.config];
    
    return result;
}

- (id)customInitWithCoder:(NSCoder*) aDecoder
{
    //Call standard methods
    id result = [self customInitWithCoder: aDecoder];
    
    [self construct:self.config];

    return result;
}

-(id)initWithConfig:(ObjectConfig *)config
{
    objc_setAssociatedObject(self, @"ObjectConfig", config, OBJC_ASSOCIATION_RETAIN);

    return [self init];
}

- (ObjectConfig*)config
{
	ObjectConfig *config = objc_getAssociatedObject(self, @"ObjectConfig");
    if(!config){
        config = [ObjectConfig new];
        objc_setAssociatedObject(self, @"ObjectConfig", config, OBJC_ASSOCIATION_RETAIN);
    }
    
    return config;
}

-(void)construct:(ObjectConfig*)config
{
    [self initialize:config];
    
    objc_setAssociatedObject(self, @"ObjectConfig", config, OBJC_ASSOCIATION_RETAIN);
}

-(void)initialize:(ObjectConfig*)config
{
    
}


-(NSArray*)actions
{
    NSArray *actions = objc_getAssociatedObject(self, @"ObjectActions");
    
    if(!actions){
        
        NSMutableArray *acts = [NSMutableArray new];
        
        for(NSString *method in [self methods]){
            
            if(method.length > 7 && [[method substringToIndex:7] isEqualToString:@"_action"]){
                [acts addObject:[[method substringFromIndex:7] lowercaseString]];
            }
        }
        
        actions = [NSArray arrayWithArray:acts];
        objc_setAssociatedObject(self, @"ObjectActions", actions, OBJC_ASSOCIATION_RETAIN);
    }
    
    return actions;
}


@end
