//
//  userDB.m
//  HppleDemo
//
//  Created by  吕欣韵 on 2015-01-18.
//
//

#import "userDB.h"

@implementation userDB

- (void)creatDataBase{
    sqlite3 *sqlite = nil;
    NSString *filePath = [NSHomeDirectory() stringByAppendingString:@"/Documents/data.sqlite"];
    
    int result = sqlite3_open([filePath UTF8String], &sqlite);
    
    if (result != SQLITE_OK) {
        NSLog(@"Fail to init db");
        return;
    }
    
    NSString *sql = @"CREATE TABLE IF NOT EXISTS User (username TEXT primary key)";
    
    char *error;
    
    result = sqlite3_exec(sqlite, [sql UTF8String], NULL, NULL, &error);
    
    if (result != SQLITE_OK) {
        NSLog(@"FAIL TO INIT");
        return;
    }
    
    sqlite3_close(sqlite);
}

- (void)inserToDataBase: (NSString *)str{
    sqlite3 *sqlite = nil;
    sqlite3_stmt *stmt = nil;
    
    NSString *filePath = [NSHomeDirectory() stringByAppendingString:@"/Documents/data.sqlite"];
    
    int result = sqlite3_open([filePath UTF8String], &sqlite);
    
    if (result != SQLITE_OK) {
        NSLog(@"Fail to init db");
        return;
    }
    
    NSString *sql = @"INSERT INTO User (username) VALUES (?)";
    
    sqlite3_prepare_v2(sqlite, [sql UTF8String], -1, &stmt, NULL);
    
    sqlite3_bind_text(stmt, 1, [str UTF8String], -1, NULL);
    
    result = sqlite3_step(stmt);
    if (result == SQLITE_ERROR || result == SQLITE_MISUSE) {
        NSLog(@"FAIL TO INSERT");
    }
    
}


@end
