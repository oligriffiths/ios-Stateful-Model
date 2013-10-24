//
//  ArticleViewController.h
//  ModelTest
//
//  Created by Oli Griffiths on 23/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "ViewControllerModel.h"

@interface ArticleViewController : ViewControllerModel

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *summaryTextView;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

- (IBAction)savePushed:(id)sender;

@end
