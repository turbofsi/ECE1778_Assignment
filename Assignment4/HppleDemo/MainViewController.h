//
//  MainViewController.h
//  A4Demo
//
//  Created by  吕欣韵 on 2015-01-18.
//  Copyright (c) 2015 UofT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFHpple.h"
#import "userDB.h"

@interface MainViewController : UIViewController<UIAlertViewDelegate>

@property (nonatomic, retain) NSArray *loadArray;
- (IBAction)loadAction:(UIButton *)sender;
- (IBAction)searchAction:(UIButton *)sender;
@property (strong, nonatomic) UIActivityIndicatorView *processIndicator;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;

@end
