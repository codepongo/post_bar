//
//  SignUpViewController.m
//  PostBar
//
//  Created by zuohaitao on 16/3/24.
//  Copyright © 2016年 Singro. All rights reserved.
//

#import "SignUpViewController.h"

static CGFloat const kContainViewYNormal = 120.0;
//static CGFloat const kContainViewYEditing = 60.0;

@interface SignUpViewController ()

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) UIButton    *closeButton;

@property (nonatomic, strong) UIView      *containView;

@property (nonatomic, strong) UILabel     *logoLabel;
@property (nonatomic, strong) UILabel     *descriptionLabel;

@property (nonatomic, strong) UITextField *usernameField;

@property (nonatomic, strong) UITextField *email;

@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) UIButton    *loginButton;
@property (nonatomic, strong) UIButton *signUp;

@property (nonatomic, assign) BOOL isKeyboardShowing;
@property (nonatomic, strong) NSTimer *loginTimer;
@property (nonatomic, assign) BOOL isLogining;


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
    self.logoLabel.center = (CGPoint){kScreenWidth/2, 30};
    self.descriptionLabel.frame = (CGRect){20, 60, kScreenWidth - 20,70};
    self.usernameField.frame = (CGRect){60, 150, kScreenWidth - 120, 30};
    self.email.frame = (CGRect){60, 190, kScreenWidth - 120, 30};
    self.passwordField.frame = (CGRect){60, 230, kScreenWidth - 120, 30};
    self.loginButton.center = (CGPoint){kScreenWidth/2, 270};
    self.signUp.center = (CGPoint){kScreenWidth/2, 270+self.loginButton.size.height};
    
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
    self.containView.backgroundColor = [UIColor redColor];
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
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.containView bk_whenTapped:^{
        //@strongify(self);
        //[self hideKeyboard];
    }];
    
    [self.backgroundImageView bk_whenTapped:^{
        //@strongify(self);
        
        //[self hideKeyboard];
        
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
    
    self.passwordField = [[UITextField alloc] init];
    self.passwordField.textAlignment = NSTextAlignmentCenter;
    self.passwordField.textColor = kFontColorBlackDark;
    self.passwordField.font = [UIFont systemFontOfSize:18];
    self.passwordField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"密码"        attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:0.836 alpha:1.000],
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
    
    
    
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginButton setTitleColor:kFontColorBlackLight forState:UIControlStateHighlighted];
    self.loginButton.size = CGSizeMake(180, 44);
    [self.loginButton setBackgroundImage:[V2Helper getImageWithColor:[UIColor colorWithWhite:0.000 alpha:0.30] size:self.loginButton.size] forState:UIControlStateNormal];
    [self.loginButton setBackgroundImage:[V2Helper getImageWithColor:[UIColor colorWithWhite:0.000 alpha:0.060] size:self.loginButton.size] forState:UIControlStateHighlighted];
    self.loginButton.layer.borderColor = [UIColor colorWithWhite:0.000 alpha:0.10].CGColor;
    self.loginButton.layer.borderWidth = 0.5;
    [self.containView addSubview:self.loginButton];
    
    self.signUp = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.signUp setTitle:@"注册" forState:UIControlStateNormal];
    [self.signUp setTitleColor:[UIColor colorWithWhite:0.000 alpha:0.30] forState:UIControlStateNormal];
    [self.signUp setTitleColor:[UIColor colorWithWhite:0.000 alpha:0.060] forState:UIControlStateHighlighted];
    self.signUp.size = CGSizeMake(180, 44);
    [self.signUp setBackgroundImage:[V2Helper getImageWithColor:[UIColor colorWithWhite:1.000 alpha:0.00] size:self.signUp.size] forState:UIControlStateNormal];
    [self.signUp setBackgroundImage:[V2Helper getImageWithColor:[UIColor colorWithWhite:1.000 alpha:0.00] size:self.signUp.size] forState:UIControlStateHighlighted];
    [self.containView addSubview:self.signUp];
    
    
    
    // Handles
    @weakify(self);
    [self.usernameField setBk_shouldBeginEditingBlock:^BOOL(UITextField *textField) {
        //@strongify(self);
        
        //[self showKeyboard];
        
        return YES;
    }];
    
    [self.usernameField setBk_shouldReturnBlock:^BOOL(UITextField *textField) {
        @strongify(self);
        
        [self.passwordField becomeFirstResponder];
        
        return YES;
    }];
    
    [self.passwordField setBk_shouldBeginEditingBlock:^BOOL(UITextField *textField) {
        //@strongify(self);
        
        //[self showKeyboard];
        
        return YES;
    }];
    
    [self.passwordField setBk_shouldReturnBlock:^BOOL(UITextField *textField) {
        //@strongify(self);
        
        //[self login];
        
        return YES;
    }];
    
    [self.loginButton bk_addEventHandler:^(id sender) {
        //@strongify(self);
        
        //[self login];
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.signUp bk_addEventHandler:^(id sender) {
        @strongify(self);
        
        [self dismissViewControllerAnimated:YES completion:^{
            @strongify(self);
            [self presentViewController:[[SignUpViewController alloc]init] animated:YES completion:nil];
            
        }];
        
    } forControlEvents:UIControlEventTouchUpInside];
}



@end
