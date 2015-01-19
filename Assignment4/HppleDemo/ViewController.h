//
//  ViewController.h
//  HppleDemo
//
//  Created by Vytautas Galaunia on 11/25/14.
//
//

#import <UIKit/UIKit.h>
#import "TFHpple.h"
#import "userDB.h"

@interface ViewController : UIViewController<UIAlertViewDelegate>

@property (nonatomic, retain) NSArray *loadArray;

- (IBAction)loadAction:(UIButton *)sender;

@end

