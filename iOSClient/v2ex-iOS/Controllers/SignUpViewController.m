//
//  SignUpViewController.m
//  PostBar
//
//  Created by zuohaitao on 16/3/24.
//  Copyright © 2016年 Singro. All rights reserved.
//

#import "SignUpViewController.h"

static CGFloat const kContainViewYNormal = 100.0;
static CGFloat const kContainViewYEditing = 55.0;

@interface SignUpViewController ()

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) UIButton    *closeButton;

@property (nonatomic, strong) UIView      *containView;

@property (nonatomic, strong) UILabel     *logoLabel;
@property (nonatomic, strong) UILabel     *descriptionLabel;

@property (nonatomic, strong) UITextField *usernameField;

@property (nonatomic, strong) UITextField *email;

@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) UITextField *repeat;

@property (nonatomic, strong) UIButton *signUp;

@property (nonatomic, assign) BOOL isKeyboardShowing;
@property (nonatomic, strong) NSTimer *signUpTimer;
@property (nonatomic, assign) BOOL signingUp;


@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)loadView {
    [super loadView];
    
    [self configureViews];
    [self configureContainerView];
    
}

#pragma mark - Layout

- (void)viewWillLayoutSubviews {
    
    self.backgroundImageView.frame = self.view.frame;
    self.closeButton.frame = (CGRect){10, 20, 44, 44};
    
    self.containView.frame = (CGRect){0, kContainViewYNormal, kScreenWidth, 600};
    self.logoLabel.center = (CGPoint){kScreenWidth/2, 40};
    self.descriptionLabel.frame = (CGRect){20, 50, kScreenWidth - 20,70};
    self.usernameField.frame = (CGRect){60, 110, kScreenWidth - 120, 30};
    self.email.frame = (CGRect){60, 150, kScreenWidth - 120, 30};
    self.passwordField.frame = (CGRect){60, 190, kScreenWidth - 120, 30};
    self.repeat.frame = (CGRect){60, 230, kScreenWidth - 120, 30};
    self.signUp.center = (CGPoint){kScreenWidth/2, 290};
    
}

#pragma mark - Configure Views

- (void)configureViews {
    
    self.backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default-568_blurred"]];
    self.backgroundImageView.userInteractionEnabled = YES;
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.backgroundImageView];
    
    self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [self.closeButton setTintColor:[UIColor whiteColor]];
    self.closeButton.alpha = 0.5;
    [self.view addSubview:self.closeButton];
    
    self.containView = [[UIView alloc] init];
    [self.view addSubview:self.containView];
    
    self.logoLabel = [[UILabel alloc] init];
    self.logoLabel.text = @"CodePongo";
    self.logoLabel.font = [UIFont fontWithName:@"Kailasa" size:36];
    self.logoLabel.textColor = kFontColorBlackDark;
    [self.logoLabel sizeToFit];
    [self.containView addSubview:self.logoLabel];
    
    self.descriptionLabel = [[UILabel alloc] init];
    //    self.descriptionLabel.text = @"A community of start-ups, designers, developers and creative people.";
    self.descriptionLabel.text = @"电子公告板";
    self.descriptionLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:18];
    self.descriptionLabel.textColor = kFontColorBlackLight;
    self.descriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.descriptionLabel.numberOfLines = 0;
    self.descriptionLabel.textAlignment = NSTextAlignmentCenter;
    [self.containView addSubview:self.descriptionLabel];
    
    
    
    // Handles
    @weakify(self);
    [self.closeButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        [self dismissViewControllerAnimated:YES completion:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:kShowLoginVCNotification object:nil];
        }];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.containView bk_whenTapped:^{
        @strongify(self);
        [self hideKeyboard];
    }];
    
    [self.backgroundImageView bk_whenTapped:^{
        @strongify(self);
        [self hideKeyboard];
        
    }];
    
}

/* 这个方法不止是设置textfield，还有LoginButton，因此这个方法名不合适 */
- (void)configureContainerView {
    //- (void)configureTextField {
    
    self.usernameField = [[UITextField alloc] init];
    self.usernameField.textAlignment = NSTextAlignmentCenter;
    self.usernameField.textColor = kFontColorBlackDark;
    self.usernameField.font = [UIFont systemFontOfSize:18];
    self.usernameField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"用户名"
                                                                               attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:0.836 alpha:1.000],
                                                                                            NSFontAttributeName:[UIFont italicSystemFontOfSize:18]}];
    self.usernameField.keyboardType = UIKeyboardTypeEmailAddress;
    self.usernameField.returnKeyType = UIReturnKeyNext;
    self.usernameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.usernameField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.usernameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.usernameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.usernameField.rightViewMode = UITextFieldViewModeWhileEditing;

    [self.containView addSubview:self.usernameField];
    
    
    
    self.email = [[UITextField alloc] init];
    self.email.textAlignment = NSTextAlignmentCenter;
    self.email.textColor = kFontColorBlackDark;
    self.email.font = [UIFont systemFontOfSize:18];
    self.email.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"电子邮件"
                                                                               attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:0.836 alpha:1.000],
                                                                                            NSFontAttributeName:[UIFont italicSystemFontOfSize:18]}];
    self.email.keyboardType = UIKeyboardTypeEmailAddress;
    self.email.returnKeyType = UIReturnKeyNext;
    self.email.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.email.autocorrectionType = UITextAutocorrectionTypeNo;
    self.email.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.email.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.email.rightViewMode = UITextFieldViewModeWhileEditing;

    [self.containView addSubview:self.email];
    
    
    self.passwordField.keyboardType = UIReturnKeyNext;
    self.passwordField = [[UITextField alloc] init];
    self.passwordField.textAlignment = NSTextAlignmentCenter;
    self.passwordField.textColor = kFontColorBlackDark;
    self.passwordField.font = [UIFont systemFontOfSize:18];
    self.passwordField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入密码"        attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:0.836 alpha:1.000],
                                                                                                                    NSFontAttributeName:[UIFont italicSystemFontOfSize:18]}];
    self.passwordField.secureTextEntry = YES;
    self.passwordField.keyboardType = UIKeyboardTypeASCIICapable;
    self.passwordField.returnKeyType = UIReturnKeyGo;
    self.passwordField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.passwordField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.passwordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordField.rightViewMode = UITextFieldViewModeWhileEditing;
    [self.containView addSubview:self.passwordField];

    
    self.repeat = [[UITextField alloc] init];
    self.repeat.textAlignment = NSTextAlignmentCenter;
    self.repeat.textColor = kFontColorBlackDark;
    self.repeat.font = [UIFont systemFontOfSize:18];
    self.repeat.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"重复密码"        attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:0.836 alpha:1.000],
                                                                                                                    NSFontAttributeName:[UIFont italicSystemFontOfSize:18]}];
    self.repeat.secureTextEntry = YES;
    self.repeat.keyboardType = UIKeyboardTypeASCIICapable;
    self.repeat.returnKeyType = UIReturnKeyGo;
    self.repeat.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.repeat.autocorrectionType = UITextAutocorrectionTypeNo;
    self.repeat.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.repeat.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.repeat.rightViewMode = UITextFieldViewModeWhileEditing;
    [self.containView addSubview:self.repeat];
    
    self.signUp = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.signUp setTitle:@"注册" forState:UIControlStateNormal];
    [self.signUp setTitleColor:[UIColor colorWithWhite:0.000 alpha:0.30] forState:UIControlStateNormal];
    [self.signUp setTitleColor:[UIColor colorWithWhite:0.000 alpha:0.060] forState:UIControlStateHighlighted];
    self.signUp.size = CGSizeMake(180, 44);
    [self.signUp setBackgroundImage:[V2Helper getImageWithColor:[UIColor colorWithWhite:1.000 alpha:0.00] size:self.signUp.size] forState:UIControlStateNormal];
    [self.signUp setBackgroundImage:[V2Helper getImageWithColor:[UIColor colorWithWhite:1.000 alpha:0.00] size:self.signUp.size] forState:UIControlStateHighlighted];
    
    [self.signUp setBackgroundImage:[V2Helper getImageWithColor:[UIColor colorWithWhite:0.000 alpha:0.30] size:self.signUp.size] forState:UIControlStateNormal];
    [self.signUp setBackgroundImage:[V2Helper getImageWithColor:[UIColor colorWithWhite:0.000 alpha:0.060] size:self.signUp.size] forState:UIControlStateHighlighted];
    self.signUp.layer.borderColor = [UIColor colorWithWhite:0.000 alpha:0.10].CGColor;
    self.signUp.layer.borderWidth = 0.5;
    
    [self.containView addSubview:self.signUp];
    
    
    
    // Handles
    @weakify(self);
    [self.usernameField setBk_shouldBeginEditingBlock:^BOOL(UITextField *textField) {
        @strongify(self);
        
        [self showKeyboard];
        
        return YES;
    }];
    
    [self.usernameField setBk_shouldReturnBlock:^BOOL(UITextField *textField) {
        @strongify(self);
        
        [self.email becomeFirstResponder];
        
        return YES;
    }];
    
    [self.email setBk_shouldBeginEditingBlock:^BOOL(UITextField *textField) {
        @strongify(self);
        
        [self showKeyboard];
        
        return YES;
    }];
    
    [self.email setBk_shouldReturnBlock:^BOOL(UITextField *textField) {
        @strongify(self);
        
        [self.passwordField becomeFirstResponder];
        
        return YES;
    }];
    
    [self.passwordField setBk_shouldBeginEditingBlock:^BOOL(UITextField *textField) {
        @strongify(self);
        
        [self showKeyboard];
        
        return YES;
    }];
    
    [self.passwordField setBk_shouldReturnBlock:^BOOL(UITextField *textField) {
        @strongify(self);
        
        [self.repeat becomeFirstResponder];
        
        return YES;
    }];
    
    [self.repeat setBk_shouldBeginEditingBlock:^BOOL(UITextField *textField) {
        @strongify(self);
        
        [self showKeyboard];
        
        return YES;
    }];
    
    [self.repeat setBk_shouldReturnBlock:^BOOL(UITextField *textField) {
        @strongify(self);
        
        [self doSignUp];
        
        return YES;
    }];
    
    [self.signUp bk_addEventHandler:^(id sender) {
        @strongify(self);
        
        [self doSignUp];
        
    } forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - Private Methods

- (void)willSignUp {
    
    self.signingUp = YES;
    self.usernameField.enabled = NO;
    self.email.enabled = NO;
    self.passwordField.enabled = NO;
    self.repeat.enabled = NO;
    static NSUInteger dotCount = 0;
    dotCount = 1;
    [self.signUp setTitle:@"注册." forState:UIControlStateNormal];
    
    @weakify(self);
    self.signUpTimer = [NSTimer bk_scheduledTimerWithTimeInterval:0.5 block:^(NSTimer *timer) {
        @strongify(self);
        
        if (dotCount > 3) {
            dotCount = 0;
        }
        NSString *signUpString = @"注册";
        for (int i = 0; i < dotCount; i ++) {
            signUpString = [signUpString stringByAppendingString:@"."];
        }
        dotCount ++;
        
        [self.signUp setTitle:signUpString forState:UIControlStateNormal];
        
    } repeats:YES];
    
}

- (void)didSignUp {
    
    self.signingUp = YES;
    self.usernameField.enabled = NO;
    self.email.enabled = NO;
    self.passwordField.enabled = NO;
    self.repeat.enabled = NO;
    
    [self.signUp setTitle:@"注册" forState:UIControlStateNormal];
    
    self.signingUp = NO;
    
    [self.signUpTimer invalidate];
    self.signUpTimer = nil;
    
}

- (void)doSignUp {
    
    if (!self.signingUp) {
        
        if (self.usernameField.text.length && self.passwordField.text.length) {
            if ([self isValidEmail:self.usernameField.text]) {
                //输入邮箱登录 会导致获取profile 信息失败的bug
                [SVProgressHUD showErrorWithStatus:@"请输入用户名，而非注册邮箱"];
                return;
            }
            if (![self.passwordField.text isEqualToString:self.repeat.text]) {
                [SVProgressHUD showErrorWithStatus:@"两次输入的密码不一致"];
            }
            [self hideKeyboard];
            [self willSignUp];


            [[V2DataManager manager] UserRegisterWithEMail:self.email.text username:self.usernameField.text password:self.passwordField.text success:^(NSString *message) {
/*
                [[V2DataManager manager] getMemberProfileWithUserId:nil username:self.usernameField.text success:^(V2MemberModel *member) {
                    
                    V2UserModel *user = [[V2UserModel alloc] init];
                    
                    user.member = member;
                    user.name = member.memberName;
                    
                    [V2DataManager manager].user = user;
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:nil];
                    
                    [self didSignUp];
                    
                    [self dismissViewControllerAnimated:YES completion:nil];
                    
                } failure:^(NSError *error) {
                    
                    [self didSignUp];
                    
                }];
                
                
               */
            } failure:^(NSError *error) {
                
                NSString *reasonString;
                
                if (error.code < 700) {
                    reasonString = @"请检查网络状态";
                } else {
                    reasonString = @"请检查用户名或密码";
                }
                UIAlertView *alertView = [[UIAlertView alloc] bk_initWithTitle:@"登录失败" message:reasonString];
                [alertView bk_setCancelButtonWithTitle:@"确定" handler:^{
                    [self didSignUp];
                }];
                
                [alertView show];
                
            }];
            
        }
        
    }
    
}

- (void)showKeyboard {
    
    if (self.isKeyboardShowing) {
        ;
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            self.containView.y      = kContainViewYEditing;
            self.descriptionLabel.y -= 5;
            self.usernameField.y    -= 10;
            self.email.y -= 12;
            self.passwordField.y    -= 14;
            self.repeat.y -= 16;
            self.signUp.y -= 18;
        }];
        self.isKeyboardShowing = YES;
    }
    
}

- (void)hideKeyboard {
    
    if (self.isKeyboardShowing) {
        self.isKeyboardShowing = NO;
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
        [UIView animateWithDuration:0.3 animations:^{
            self.containView.y      = kContainViewYNormal;
            self.descriptionLabel.y += 5;
            self.usernameField.y    += 10;
            self.email.y += 12;
            self.passwordField.y    += 14;
            self.repeat.y += 16;
            self.signUp.y           += 18;
            
        } completion:^(BOOL finished) {
        }];
    }
    
}

- (BOOL)isValidEmail:(NSString *)email{
    if (email == nil) {
        return NO;
    }
    NSString *phoneRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:email];
}


@end
