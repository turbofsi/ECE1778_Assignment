//
//  ViewController.h
//  A1demo1222
//
//  Created by  吕欣韵 on 2014-12-24.
//  Copyright (c) 2014 UofT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btn1Style;
@property (weak, nonatomic) IBOutlet UIButton *btn2Style;
@property (weak, nonatomic) IBOutlet UILabel *txtLabel;
@property (strong, nonatomic) IBOutlet UIImageView *picView;

- (IBAction)changeTxt:(UIButton *)sender;
- (IBAction)showPic:(UIButton *)sender;

- (IBAction)resetNumber:(UIBarButtonItem *)sender;

@end

