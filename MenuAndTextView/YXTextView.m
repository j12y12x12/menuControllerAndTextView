//
//  YXTextView.m
//  MenuAndTextView
//
//  Created by jyx on 2018/8/16.
//  Copyright © 2018年 jjyyxx. All rights reserved.
//

#import "YXTextView.h"

@implementation YXTextView


- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (self.isShowMenu)
    {
        return NO;
    }
    else
    {
        return [super canPerformAction:action withSender:sender];
    }
}


@end
