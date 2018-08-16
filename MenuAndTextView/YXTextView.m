//
//  YXTextView.m
//  MenuAndTextView
//
//  Created by jyx on 2018/8/16.
//  Copyright © 2018年 jjyyxx. All rights reserved.
//

#import "YXTextView.h"

@implementation YXTextView


#pragma mark - 拦截传递，重写父类方法
- (UIResponder *)nextResponder
{
    if (self.myNextResponder)
    {
        return self.myNextResponder;
    }
    else
    {
        return super.nextResponder;
    }
    
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    //拦截menu菜单
    if (self.myNextResponder)
    {
        return NO;
    }
    else
    {
        return [super canPerformAction:action withSender:sender];
    }
    
}


@end
