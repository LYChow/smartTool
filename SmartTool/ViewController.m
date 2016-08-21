//
//  ViewController.m
//  SmartTool
//
//  Created by LY'S MacBook Air on 8/21/16.
//  Copyright © 2016 LY'S MacBook Air. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *folderPath =@"/Users/lysmacbookair/Desktop/shameless/season1";
    
    //规则1
//    NSString *sampleName =@"Shameless.US.S02E04";
//    
//    [self renameFileNameAtFolder:folderPath useRangeRule:NSMakeRange(0, sampleName.length)];
    
    
    
    //过滤指定字符串集合
    [self renameFileNameAtFolder:folderPath filterSpecificStrings:@[@"[迅雷下载Xunbo.Cc]",@"[1024高清]"]];
}

-(void)renameFileNameAtFolder:(NSString *)folderPath filterSpecificStrings:(NSArray *)filterStrs
{
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:folderPath])return;
    NSArray *files =[[NSFileManager defaultManager] contentsOfDirectoryAtPath:folderPath error:nil];
    
    for(NSString *filePath in files)
    {
        NSString *newFileName=filePath;
        
        for(NSString *specific in filterStrs)
        {
            if ([newFileName containsString:specific]) {
                newFileName =[filePath stringByReplacingOccurrencesOfString:specific withString:@""];
            }
        }
        
        [[NSFileManager defaultManager] moveItemAtPath:[folderPath stringByAppendingPathComponent:filePath] toPath:[folderPath stringByAppendingPathComponent:newFileName] error:nil];
    }
}


-(void)renameFileNameAtFolder:(NSString *)folderPath useRangeRule:(NSRange)range
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:folderPath])return;
    NSArray *files =[[NSFileManager defaultManager] contentsOfDirectoryAtPath:folderPath error:nil];
    for(NSString *filePath in files)
    {
        NSString *newFilePath =[filePath substringWithRange:range];
        [[NSFileManager defaultManager] moveItemAtPath:[folderPath stringByAppendingPathComponent:filePath] toPath:[folderPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mkv",newFilePath]] error:nil];
    }
    
}



@end
