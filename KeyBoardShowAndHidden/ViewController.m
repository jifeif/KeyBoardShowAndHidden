//
//  ViewController.m
//  KeyBoardShowAndHidden
//
//  Created by 吉飞飞 on 16/1/31.
//  Copyright © 2016年 吉飞飞. All rights reserved.
//

#import "ViewController.h"
#import "UIView+KeyBoardShowAndHidden.h"

@interface ViewController ()
@property (nonatomic, strong) UIView * aView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITextField * atextField = [[UITextField alloc] initWithFrame:CGRectMake(50, 5, self.view.bounds.size.width - 100, 30)];
    atextField.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.aView];
    [_aView addSubview:atextField];
    
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidden)];
    [self.view addGestureRecognizer:tap];
    [_aView showAccessoryViewAnimation];
    [_aView hiddenAccessoryViewAnimation];
}
#pragma mark --  getter
- (UIView *)aView{
    if (!_aView) {
        _aView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 40, self.view.bounds.size.width, 40)];
        _aView.backgroundColor = [UIColor blueColor];
    }
    return _aView;
}

#pragma mark --  notification    Method
- (void)keyBoardWillShow:(NSNotification *)noti{
    NSDictionary * dic = noti.userInfo;
    CGRect keyboardBounds = [dic[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval keyboardTime = [dic[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGFloat deleteY = keyboardBounds.size.height;
    [UIView animateWithDuration:keyboardTime delay:0 options:[dic[UIKeyboardAnimationCurveUserInfoKey] integerValue] << 16 animations:^{
        self.aView.transform = CGAffineTransformMakeTranslation(0, -deleteY);
    } completion:nil];
    
}

- (void)keyBoardWillHidden:(NSNotification *)noti{
    NSDictionary * dic = noti.userInfo;
    NSTimeInterval time = [dic[UIKeyboardAnimationCurveUserInfoKey] doubleValue];
    [UIView animateWithDuration:time delay:0 options: [dic[UIKeyboardAnimationCurveUserInfoKey] integerValue] << 16 animations:^{
        self.aView.transform = CGAffineTransformIdentity;
    } completion:nil];
    
}

- (void)hidden{
    [self.view endEditing:YES];
}


@end
