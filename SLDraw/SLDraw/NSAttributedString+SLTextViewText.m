//
//  NSAttributedString+SLTextViewText.m
//  HeShi
//
//  Created by apple on 16/1/4.
//  Copyright © 2016年 Oyd. All rights reserved.
//

#import "NSAttributedString+SLTextViewText.h"

@implementation NSAttributedString (SLTextViewText)
- (NSString *)getPlainString {
    NSMutableString *plainString = [NSMutableString stringWithString:self.string];
    __block NSUInteger base = 0;
    
    [self enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, self.length)options:0 usingBlock:^(id value, NSRange range, BOOL *stop)
    {
          if (value && [value isKindOfClass:[NSTextAttachment class]])
          {
              [plainString replaceCharactersInRange:NSMakeRange(range.location + base, range.length)withString:@"www.baidu.com"];
              base += 12;
          }
    }];
    return plainString;
}

@end

