//
//  ViewController.h
//  A2Demo0107
//
//  Created by  吕欣韵 on 2015-01-07.
//  Copyright (c) 2015 UofT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadViewController.h"

@interface ViewController : UIViewController<UIAlertViewDelegate, LoadViewDelegate>

@property (strong, nonatomic) NSMutableArray *currentArray;

- (IBAction)exitAction:(UIButton *)sender;
- (IBAction)storageAction:(UIButton *)sender;


-(IBAction)unwindToMainVC:(UIStoryboardSegue *)segue;

@end

