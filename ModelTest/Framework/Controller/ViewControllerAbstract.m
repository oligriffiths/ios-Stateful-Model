//
//  AbstractViewController.m
//  ModelTest
//
//  Created by Oli Griffiths on 22/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "ViewControllerAbstract.h"
#import "CommandContext.h"
#import <objc/runtime.h>

@implementation ViewControllerAbstract

-(id)execute:(NSString*)action withData:(NSDictionary*)data
{
    return [self execute:action withContext:[CommandContext config:@{@"data":data}]];
}

-(id)execute:(NSString*)action withContext:(CommandContext*)context
{
    action = [action lowercaseString];
    
    [context set:@"action" value:action];
    context.subject = self;
    
    //Do action map
    
    
    //Do command chain
    
    NSString *command = action;
    NSString *method = [NSString stringWithFormat: @"_action%@:", [action uppercaseFirst]];
    SEL selector = NSSelectorFromString(method);
    
    if([self respondsToSelector:selector]){
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        
        //Detect if the method has a return type of object, if so, set as the result in the context
        Method method = class_getInstanceMethod([self class], selector);
        char type[128];
        method_getReturnType(method, type, sizeof(type));
        
        if([[NSString stringWithFormat:@"%s" , type] isEqualToString:@"@"]){
            id result = [self performSelector:selector withObject:context];
            if(result != nil) [context set:@"result" value:result];
        }else{
            [self performSelector:selector withObject:context];
        }
        
#pragma clang diagnostic pop
        
    }else{
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"Can't execute '%@', method: '%@' does not exist", command, method] userInfo:nil];
    }
    
    return [context get:@"result"];
}


//Returns a method signature for the selector. For actions, this is converted into execute:withContext
- (NSMethodSignature*)methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature* signature = [super methodSignatureForSelector:selector];
    if ([self actionForSelector: selector]) {
        signature = [self methodSignatureForSelector:@selector(execute:withContext:)];
    }
    return signature;
}


//Retrusn the action as string from the supplied selector
-(NSString*)actionForSelector:(SEL)selector
{
    NSString *strSelector = NSStringFromSelector(selector);
    
    //Check if action exists, if so, strip the colon
    NSArray *components = [strSelector componentsSeparatedByString:@":"];
    NSArray *actions = [self actions];
    if(components.count == 2 && [actions containsObject:strSelector]){
        return [strSelector stringByReplacingOccurrencesOfString:@":" withString:@""];
    }
    
    return nil;
}


//Dynamic action invocation if the method being called exists as an action
- (void)forwardInvocation:(NSInvocation *)invocation
{
    NSString *action = [self actionForSelector:invocation.selector];
    
    //Ensure we have a matching action, else fall back to default
    if(action != nil){
        __unsafe_unretained id argument;
        [invocation getArgument:&argument atIndex:2];

        //Validate that we were provided data for the context
        CommandContext *context;
        if([argument isKindOfClass:[NSDictionary class]]){
            context = [CommandContext config:@{@"data":argument}];
        }else{
            context = [CommandContext config:@{@"data":@{}}];
        }
      
        invocation.selector = @selector(execute:withContext:);
        [invocation setArgument:&action atIndex:2];
        [invocation setArgument:&context atIndex:3];
        [invocation invoke];
        
    }else{
        [super forwardInvocation:invocation];
    }
}

//MIXINS
//- (id)forwardingTargetForSelector:(SEL)aSelector
//{
//    NSObject *object = [NSObject new];
//    
//    return object;
//    
//    return [super forwardingTargetForSelector:aSelector];
//}


@end
