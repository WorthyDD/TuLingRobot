//
//  ViewController.m
//  图灵机器人
//
//  Created by 武淅 段 on 16/5/19.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
}

- (void)keyboardWillShow : (NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到鍵盤的高度
    NSLog(@"\n\n show size %@\n\n", NSStringFromCGSize(kbSize));
    self.view.center = CGPointMake(self.view.center.x, [UIScreen mainScreen].bounds.size.height/2-kbSize.height);
}
- (void)keyboardShow : (NSNotification *)notification
{
    
}
- (void)keyboardWillHide : (NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到鍵盤的高度
    NSLog(@"\n\n hide size %@\n\n", NSStringFromCGSize(kbSize));
    self.view.center = CGPointMake(self.view.center.x, [UIScreen mainScreen].bounds.size.height/2);
}
- (void)keyboardHide : (NSNotification *)notification
{
    
}


- (IBAction)didTapSendButton:(id)sender {
    NSString *text = _textfield.text;
    [_questionLabel setText:text];
    _textfield.text = @"";
    __weak typeof(self) weakSelf = self;
    [[ConstantManager shareManager]getAnswer:text userID:@"1234561" completion:^(id result, NSError *err) {
        if(result){
            NSLog(@"\n\nsuccess-%@\n\n",result);
            NSString *showText = [result objectForKey:@"text"];
            [weakSelf.answerLabel setText:showText];
        }
        if(err){
            NSLog(@"\n\nerror-%@\n\n",err);
        }
    }];

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
