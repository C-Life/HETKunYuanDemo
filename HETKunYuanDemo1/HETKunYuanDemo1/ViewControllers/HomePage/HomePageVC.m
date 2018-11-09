//
//  HomePageVC.m
//  HETKunYuanDemo
//
//  Created by JustinYang on 2018/10/10.
//  Copyright © 2018年 JustinYang. All rights reserved.
//

#import "HomePageVC.h"
#import "AuthVC.h"
#import "OpenIdInfo+CoreDataProperties.h"


@interface HomePageVC ()
    //user interface
    @property (weak, nonatomic) IBOutlet UISegmentedControl *seg;
    @property (nonatomic,readonly,weak) UIViewController *authVC;
    @property (weak, nonatomic) IBOutlet UITextField *openIdTextField;
    @property (weak, nonatomic) IBOutlet UIView *authView;
    
    @property (nonatomic,copy)NSString *errorMsg;
    @property (nonatomic,copy)NSString *loadingMsg;
    @end

@implementation HomePageVC
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing: YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    [self initViews];
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    
    [self needShowAuthVCWithEnv:self.seg.selectedSegmentIndex];
}
    
    
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}
    
#pragma mark - private method
-(void)initData{
    [RACObserve(self, errorMsg) subscribeNext:^(id x) {
        if (x == nil) {
            return ;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [HETCommonHelp showAutoDissmissWithMessage:x];
        });
    }];
    
    [RACObserve(self, loadingMsg) subscribeNext:^(id x) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            x == nil?[HETCommonHelp HidHud]:[HETCommonHelp showCustomHudtitle:x];
        });
    }];
}
-(void)initViews{
    self.title = @"主页";
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *env = [defaults objectForKey:kHETEnviroment];
    self.seg.selectedSegmentIndex = env.integerValue;
    
    
}
-(void)needShowAuthVCWithEnv:(NSInteger)env{
    AuthVC *vc = self.childViewControllers.firstObject;
    @weakify(self);
    @weakify(vc);
    vc.dismiss = ^(NSString * _Nullable openId) {
        @strongify(self);
        @strongify(vc);
        self.openIdTextField.text = openId;
        [vc.view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.and.leading.and.trailing.equalTo(self.view);
            make.height.equalTo(@0);
        }];
        [UIView animateWithDuration:0.5 animations:^{
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            self.authView.hidden = YES;
        }];
    };
    
    [vc.view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.and.leading.and.trailing.equalTo(self.view);
        make.height.equalTo(@0);
    }];
    [self.view layoutIfNeeded];
    self.authView.hidden = YES;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"OpenIdInfo"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"enviroment == %d",env];
    request.predicate = predicate;
    NSArray *arr = [AppDelegate.context executeFetchRequest:request error:nil];
    if (arr.count == 0 || ((OpenIdInfo *)[arr firstObject]).openId.length < 32) {
        UIViewController *vc = self.childViewControllers.firstObject;
        [vc.view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.and.trailing.and.bottom.equalTo(self.view);
            make.top.equalTo(self.view.mas_top).offset(kSafeAreaTop);
        }];
        self.authView.hidden = NO;
        vc.view.alpha = 1.0;
        [UIView animateWithDuration:0.5 animations:^{
            [self.view layoutIfNeeded];
        }];
    }else{ //二次授权
        OpenIdInfo *info = arr.firstObject;
        self.openIdTextField.text = info.openId;
        [self secondAuthWithOpenId:info.openId];
    }
}
-(void)secondAuthWithOpenId:(NSString *)openId {
    __block NSString *authCode;
    __block NSString *tokenStr;
    self.loadingMsg = @"正在二次授权";
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    [[HETThirdCloudAuthorize shareInstance] getAuthorizationCodeWithAccount:nil withOpenId:openId success:^(id responseObject) {
        
        NSString * authorizationCode = [responseObject valueForKeyPath:@"data.authorizationCode"];
        NSLog(@"authorizationCode : %@",authorizationCode);
        authCode = authorizationCode;
        dispatch_group_leave(group);
    } failure:^(NSError *error) {
        self.loadingMsg = [error.userInfo valueForKey:@"NSLocalizedDescription"];
        dispatch_group_leave(group);
    }];
    
    NSString *reqStr = [NSString stringWithFormat:@"appId=%@&appSecret=%@&timestamp=%@",kHETAppId,kHETAppSecret,Tools.timestamp];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *env = [defaults objectForKey:kHETEnviroment];
    NSString *path = @"/v1/cloud/token";
    if (env.integerValue == 0) {
        path = @"/v1/app/open/cloud/token";
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",Tools.getHostName,path];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [reqStr dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    dispatch_group_enter(group);
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                              {
                                  
                                  self.loadingMsg = nil;
                                  if (data == nil) {
                                      return ;
                                  }
                                  
                                  NSDictionary *responseObject =  [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                  NSString *code=[responseObject objectForKey:@"code"];
                                  if(code.intValue!=0)
                                  {
                                      self.loadingMsg = [responseObject objectForKey:@"msg"];
                                      return;
                                  }else{
                                      NSDictionary *dataDic = [responseObject objectForKey:@"data"];
                                      NSString *token = [dataDic objectForKey:@"accessToken"];
                                      if(token){
                                          tokenStr = token;
                                      }else{
                                          self.loadingMsg = @"获取token失败啦!";
                                      }
                                  }
                                  NSLog(@"token : %@",tokenStr);
                                  dispatch_group_leave(group);
                              }];
    [task resume];
    
    @weakify(self);
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        @strongify(self);
        self.loadingMsg = nil;
        if (tokenStr == nil || authCode == nil) {
            self.errorMsg = @"无法获取随机码,请重新授权";
            return ;
        }
        
        self.loadingMsg = @"模拟服务器获取随机码";
        
        NSString *reqStr = [NSString stringWithFormat:@"appId=%@&appSecret=%@&timestamp=%@&authorizationCode=%@&accessToken=%@",kHETAppId,kHETAppSecret,Tools.timestamp,authCode,tokenStr];
        // /v1/app/open/cloud/token /v1/cloud/user/checkAuth
        NSString *urlStr = [NSString stringWithFormat:@"%@/v1/cloud/user/checkAuth",Tools.getHostName];
        if (env.integerValue == 0) {
            urlStr = [NSString stringWithFormat:@"%@/v1/app/open/cloud/user/checkAuth",Tools.getHostName];
        }
        
        NSURL *url = [NSURL URLWithString:urlStr];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        request.HTTPMethod = @"POST";
        request.HTTPBody = [reqStr dataUsingEncoding:NSUTF8StringEncoding];
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      
                                      self.loadingMsg = nil;
                                      if (data == nil) {
                                          self.errorMsg = @"无法获取随机码,请重新授权";
                                          return ;
                                      }
                                      
                                      NSDictionary *responseObject =  [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                      NSString *code=[responseObject objectForKey:@"code"];
                                      if(code.intValue!=0)
                                      {
                                          self.errorMsg = responseObject[@"msg"];
                                          return;
                                      }else{
                                          NSDictionary *dataDic = [responseObject objectForKey:@"data"];
                                          NSString *randomCode = [dataDic objectForKey:@"randomCode"];
                                          if(randomCode){
                                              self.loadingMsg = @"正在获取OpenId";
                                              [[HETThirdCloudAuthorize shareInstance]autoAuthorizeWithRandomCode:randomCode verificationCode:nil withCompleted:^(NSString *openId, NSError *error) {
                                                  self.loadingMsg = nil;
                                                  if(error){
                                                      self.errorMsg = @"第二次授权失败,请重新授权";
                                                  }else{
                                                      if (openId) {
                                                          self.errorMsg = @"二次授权成功";
                                                          [self saveOpenId:openId];
                                                      }
                                                  }
                                              }];
                                          }else{
                                              self.errorMsg = @"无法获取随机码,请重新授权";
                                          }
                                      }
                                  }];
        [task resume];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        long flag = dispatch_group_wait(group, dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)));
        if (flag) {
            self.errorMsg = @"第二次授权失败,请重新授权";
        }
    });
    
}
    
-(void)saveOpenId:(NSString *)openId{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *env = [defaults objectForKey:kHETEnviroment];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"OpenIdInfo"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"enviroment == %d",env.integerValue];
    request.predicate = predicate;
    NSArray *arr = [AppDelegate.context executeFetchRequest:request error:nil];
    OpenIdInfo *info = nil;
    if (arr.count == 0) {
         info = [NSEntityDescription insertNewObjectForEntityForName:@"OpenIdInfo" inManagedObjectContext:AppDelegate.context];
        info.enviroment = env.integerValue;
        info.openId = openId;
    }else{
        info = arr.firstObject;
    }
    
    info.openId = openId;
    
    [AppDelegate.context save:nil];
    
    self.openIdTextField.text = openId;
}
#pragma mark - get set method
-(UIViewController *)authVC{
    return  self.childViewControllers.firstObject;
}
    
-(void)setErrorMsg:(NSString *)errorMsg{
    self.loadingMsg = nil;
    _errorMsg = errorMsg;
}
    
- (IBAction)segHandle:(UISegmentedControl *)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *env = [defaults objectForKey:kHETEnviroment];
    if ([env integerValue] != sender.selectedSegmentIndex ) {
        [AppDelegate enviromentSetting:sender.selectedSegmentIndex];
        [self needShowAuthVCWithEnv:sender.selectedSegmentIndex];
    }
}
- (IBAction)reAuthHandle:(id)sender {
    AuthVC *vc = self.childViewControllers.firstObject;
    @weakify(self);
    @weakify(vc);
    vc.dismiss = ^(NSString * _Nullable openId){
        @strongify(self);
        @strongify(vc);
        self.openIdTextField.text = openId;
        [vc.view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.and.leading.and.trailing.equalTo(self.view);
            make.height.equalTo(@0);
        }];
        [UIView animateWithDuration:0.5 animations:^{
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            self.authView.hidden = YES;
        }];
    };
    [vc.view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.and.leading.and.trailing.equalTo(self.view);
        make.height.equalTo(@0);
    }];
    [self.view layoutIfNeeded];
    
    
    [vc.view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.and.bottom.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(kSafeAreaTop);
    }];
    self.authView.hidden = NO;
    vc.view.alpha = 1.0;
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
}
- (IBAction)pushToMattress:(id)sender {
    if ([[HETAuthorize shareManager] isAuthenticated] == NO) {
        self.errorMsg = @"您还为在Het授权";
        return;
    }
    UIViewController *vc = [TargetHETDeviceList getDeviceListWithType:HETDeviceTypeMattress];
    [self.navigationController pushViewController:vc animated:YES];
}
    
- (IBAction)pushToAirBox:(id)sender {
    if ([[HETAuthorize shareManager] isAuthenticated] == NO) {
        self.errorMsg = @"您还未在Het授权";
        return;
    }
    UIViewController *vc = [TargetHETDeviceList getDeviceListWithType:HETDeviceTypeAirBox];
    [self.navigationController pushViewController:vc animated:YES];
}
    
- (IBAction)pushToSleepReport:(id)sender {
    if ([[HETAuthorize shareManager] isAuthenticated] == NO) {
        self.errorMsg = @"您还未在Het授权";
        return;
    }
    UIViewController * vc = [TargetHETSleepReport getSleepReportVC];
    [self.navigationController pushViewController:vc animated:YES];
}
    
- (IBAction)manualAuth:(id)sender {
    if (self.openIdTextField.text.length < 32) {
        self.errorMsg = @"请输入正确的openId";
        return;
    }
    
    [self secondAuthWithOpenId:self.openIdTextField.text];
}
    
@end
