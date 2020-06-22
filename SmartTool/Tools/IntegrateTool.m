//
//  IntegrateTool.m
//  SmartTool
//
//  Created by LY'S MacBook Air on 8/21/16.
//  Copyright © 2016 LY'S MacBook Air. All rights reserved.
//

#import "IntegrateTool.h"

@implementation IntegrateTool



#pragma subtitle format
+(BOOL)subtitleFormatFromFilePath:(NSString *)sourcePath toDestinationFilePath:(NSString *)destinationPath
{
    //读取
    NSMutableString *subtitleContent =[NSMutableString stringWithContentsOfFile:sourcePath encoding:NSUTF8StringEncoding error:nil];
    
    NSArray *array =[subtitleContent componentsSeparatedByString:@"-->"];
    
    //处理
    NSMutableString *newFormatterString =[NSMutableString string];
    for (int i=1;i<= array.count; i++) {
        if (i<array.count-1) {
            NSString *indexStr = [array objectAtIndex:i];
            
            NSInteger numberOfBit=1;
            //计算下标的长度用于删除长度，既求i是几位数
            NSInteger temp = i/10;
            while (temp) {
                temp=temp/10;
                numberOfBit++;
            }
            [newFormatterString appendString:[NSString stringWithFormat:@"%i:%@",i,[indexStr substringWithRange:NSMakeRange(13, indexStr.length-13-3-numberOfBit-12)]]];
        }
        else if(i==array.count-1)
        {
            NSString *lastStr =[array lastObject];
            [newFormatterString appendString:[NSString stringWithFormat:@"%i:%@",i,[lastStr substringWithRange:NSMakeRange(13, lastStr.length-13)]]];
        }
    }
    
    //创建文件
    if (![[NSFileManager defaultManager]fileExistsAtPath:destinationPath]) {
        [[NSFileManager defaultManager]createFileAtPath:destinationPath contents:nil attributes:nil];
    }
    
    //写入
    if ([[NSFileManager defaultManager]fileExistsAtPath:destinationPath]) {
       return  [newFormatterString writeToFile:destinationPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
    
    return NO;
}

/*
 从mkv文件中分离出.srt文件
 ### install mkvtoolnix:
 $ brew install mkvtoolnix
 
 ### list content of the mkv-file:
 $ mkvmerge -i mymoviefile.mkv
 
 ### what will give you:
 File 'mymoviefiel.mkv': container: Matroska
 Track ID 1: video (V_MPEG4/ISO/AVC)
 Track ID 2: audio (A_DTS)
 Track ID 3: subtitles (S_TEXT/UTF8)
 Track ID 4: subtitles (S_TEXT/UTF8)
 Chapters: 22 entries
 
 ### so the subtitle-tracks are number 3 and 4.
 ### extract all subtitle-tracks into a seperate srt-file / lang
 $ mkvextract tracks mymoviefile.mkv 3:sub3.srt 4:sub4.srt
 */



@end
