//
//  MainViewController.m
//  A4Demo
//
//  Created by  吕欣韵 on 2015-01-18.
//  Copyright (c) 2015 UofT. All rights reserved.
//

#import "MainViewController.h"
#import "DetailViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _processIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _processIndicator.hidden = YES;
    _processIndicator.center = self.view.center;
    [self.view addSubview:_processIndicator];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)loadAction:(UIButton *)sender {
    _processIndicator.hidden = NO;
    [_processIndicator startAnimating];
    [self performSelectorInBackground:@selector(loadToDataBase) withObject:nil];
}

- (IBAction)searchAction:(UIButton *)sender {
//    [self performSelectorInBackground:@selector(prepareForSegue:sender:) withObject:nil];
}

#pragma mark - multithread
- (void)loadToDataBase {
    
    NSString *urlString = @"http://www.eecg.utoronto.ca/~jayar/PeopleList";
    NSData *htmlData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:urlString]];
    
    CFStringRef gbkStr = CFStringCreateWithBytes(NULL, [htmlData bytes], [htmlData length], kCFStringEncodingGB_18030_2000, false);
    
    NSString *gbHtmlStr = (__bridge NSString *)gbkStr;
    NSString *utf8HtmlStr = [gbHtmlStr stringByReplacingOccurrencesOfString:@"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=gb2312\">" withString:@"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">"];
    
    NSData *htmlDataUTF8 = [utf8HtmlStr dataUsingEncoding:NSUTF8StringEncoding];
    
    
    
    TFHpple *xpathparser = [[TFHpple alloc] initWithHTMLData:htmlDataUTF8];
    
    NSArray *array = [xpathparser searchWithXPathQuery:@"//p"];
    TFHppleElement *element = array[0];
    NSString *tag = [element content];
    
    NSMutableArray *nameArray = [[NSMutableArray alloc] init];
    NSMutableArray *positionArray = [[NSMutableArray alloc] init];
    [positionArray addObject:@"0"];
    
    for (int i = 0; i < [tag length]; i++) {
        int index = [tag characterAtIndex:i];
        if (index == 10) {
            //            NSLog(@"enter position: %d", i);
            [positionArray addObject:[NSString stringWithFormat:@"%d", i]];
        }
    }
    
    //    NSLog(@"%@", positionArray);
    
    for (int j=0; j < [positionArray count] - 2; j++) {
        int s1 = [positionArray[j] intValue];
        int s2 = [positionArray[j+1] intValue];
        if (s1 == 0) {
            NSString *tempName = [tag substringWithRange:NSMakeRange(s1, s2-s1)];
            [nameArray addObject:tempName];
        } else{
            NSString *tempName = [tag substringWithRange:NSMakeRange(s1+1, s2-s1-1)];
            [nameArray addObject:tempName];
        }
    }
    
    [self performSelectorOnMainThread:@selector(finishAction:) withObject:nameArray waitUntilDone:YES];
    
    userDB *myDataBase = [[userDB alloc] init];
    [myDataBase creatDataBase];
    
    for (int i = 0; i < [nameArray count]; i++) {
        NSString *tempName = nameArray[i];
        [myDataBase inserToDataBase:tempName];
    }
    
    
    
}


- (void)finishAction:(NSMutableArray *)array {
    _loadArray = array;
    [_processIndicator stopAnimating];
    _processIndicator.hidden = YES;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mission complete" message:@"completed" delegate:self cancelButtonTitle:@"Confirm" otherButtonTitles: nil];
    [alert show];
    NSLog(@"%@", _loadArray);
    _searchBtn.enabled = YES;
}

//- (void)loadFromDataBase {
//    
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    
    
    
    
    
    if ([[segue identifier] isEqualToString:@"MainToDetail"]) {
        
        
        dispatch_queue_t queue = dispatch_queue_create("loadData", NULL);
        dispatch_async(queue, ^{
            NSMutableArray *array = [[NSMutableArray alloc] init];
            userDB *dataBase = [[userDB alloc] init];
            array = [dataBase loadArrayFromDataBase];
            

            DetailViewController *detailVC = [segue destinationViewController];
            detailVC.showArray = [[NSMutableArray alloc] initWithArray:array];

            
        });

        
        
       
        
    }
}

@end
