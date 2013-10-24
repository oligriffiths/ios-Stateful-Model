//
//  UIView+AutolayoutHidden.m
//  ModelTest
//
//  Created by Oli Griffiths on 24/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "UIView+AutolayoutHidden.h"
#import <objc/runtime.h>

@implementation UIView (AutolayoutHidden)

+(void)load
{
    //Swizzle methods
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(setHidden:)), class_getInstanceMethod(self, @selector(setHiddenCustom:)));
}

-(void)setHiddenCustom:(BOOL)hidden
{
    [self setHiddenCustom:hidden];
    
    NSMutableArray *constraints = objc_getAssociatedObject(self, @"ViewConstraints");
    
    //Store the constraints initially
    if(!constraints){
        NSMutableArray *constraints = [NSMutableArray new];
        
        for(NSLayoutConstraint *constraint in self.superview.constraints){
            if(constraint.firstItem == self || constraint.secondItem == self){
                [constraints addObject:@{@"constraint": constraint, @"value": [NSNumber numberWithFloat:constraint.constant]}];
            }
        }
        
        objc_setAssociatedObject(self, @"ViewConstraints", constraints, OBJC_ASSOCIATION_RETAIN);
    }
    
    if(hidden){
        for(NSLayoutConstraint *constraint in self.superview.constraints){
            if(constraint.firstItem == self || constraint.secondItem == self){
                constraint.constant = 0;
            }
        }
    }else{
        for(NSLayoutConstraint *constraint in self.superview.constraints){
            if(constraint.firstItem == self || constraint.secondItem == self){
                constraint.constant = 0;
                
                for(NSDictionary *tmp in constraints){
                    if([tmp[@"constraint"] isEqual:constraint]){
                        constraint.constant = [tmp[@"value"] floatValue];
                        break;
                    }
                }
            }
        }
    }
}

@end
