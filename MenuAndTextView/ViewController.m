//
//  ViewController.m
//  MenuAndTextView
//
//  Created by jyx on 2018/8/16.
//  Copyright © 2018年 jjyyxx. All rights reserved.
//

#import "ViewController.h"
#import "YXTextView.h"

@interface ViewController ()

@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) YXTextView *myTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    
    nameLabel.frame = CGRectMake(10, 80, 150, 30);
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.font = [UIFont systemFontOfSize:18];
    nameLabel.text = @"测试测试测试测试menu";
    [nameLabel sizeToFit];
    
    nameLabel.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, 130);
    nameLabel.userInteractionEnabled = YES;
    [self.view addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UILongPressGestureRecognizer *labelLongPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongPress:)];
    labelLongPress.minimumPressDuration = 0.5f;
    [nameLabel addGestureRecognizer:labelLongPress];
    
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap)];
    [self.view addGestureRecognizer:tap];
    
    
    YXTextView *myTextView = [[YXTextView alloc] init];
    
    myTextView.frame = CGRectMake(20, CGRectGetMaxY(nameLabel.frame)+30, [UIScreen mainScreen].bounds.size.width-40, 60);
    
    myTextView.font = [UIFont systemFontOfSize:18];
    
    myTextView.layer.borderColor = [UIColor blackColor].CGColor;
    myTextView.layer.borderWidth = 0.5;
    myTextView.layer.cornerRadius = 5;
    myTextView.layer.masksToBounds = YES;

    myTextView.text = @"chose test";
    [self.view addSubview:myTextView];
    self.myTextView = myTextView;
    
    [myTextView becomeFirstResponder];
    
    //添加menu消息通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuControllerWillHide:) name:UIMenuControllerWillHideMenuNotification object:nil];

}

- (void)viewTap
{
    [self.myTextView resignFirstResponder];
}

- (void)menuControllerWillHide: (NSNotification *)notification
{
    //还原menu
    [[UIMenuController sharedMenuController] setMenuItems:@[]];
    self.myTextView.myNextResponder = nil;

}


- (void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        UIView *view = (UIView*)gestureRecognizer.view;
        
        if ([self.myTextView isFirstResponder])
        {
            //如果myTextView是第一响应，修改响应链
            self.myTextView.myNextResponder = view;
        }
        else
        {
            [self becomeFirstResponder];
        }
        
        NSMutableArray *menuItems = [[NSMutableArray alloc] init];
        UIMenuItem *itCopy = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(handleCopyItem)];
        [menuItems addObject:itCopy];

        UIMenuItem *deleteItem = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(handleDeleteItem)];
        [menuItems addObject:deleteItem];
        
        UIMenuItem *replyItem = [[UIMenuItem alloc] initWithTitle:@"收藏" action:@selector(handleColectItem)];
        [menuItems addObject:replyItem];

        [UIMenuController sharedMenuController].menuItems = menuItems;
        [[UIMenuController sharedMenuController] setTargetRect:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height) inView:view];
        [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];

    }
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if(action == @selector(handleCopyItem) || action == @selector(handleDeleteItem) || action == @selector(handleColectItem))
    {
        return YES;
    }
    return NO;
       
}

- (void)handleCopyItem
{
    [UIPasteboard generalPasteboard].string = self.nameLabel.text;
}

- (void)handleDeleteItem
{
    NSLog(@"--------  handleDeleteItem");
}

- (void)handleColectItem
{
    NSLog(@"--------  handleColectItem");
}


@end
