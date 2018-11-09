//
//  AuthVC.m
//  HETKunYuanDemo
//
//  Created by JustinYang on 2018/10/10.
//  Copyright © 2018年 JustinYang. All rights reserved.
//

#import "AuthVC.h"
#import "OpenIdInfo+CoreDataProperties.h"
@interface AuthVC ()
    //user interface
    @property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextFeild;
    @property (weak, nonatomic) IBOutlet UILabel *authorCodeLabel;
    @property (weak, nonatomic) IBOutlet UITextField *textCodeTextFeild;
    @property (weak, nonatomic) IBOutlet UILabel *openIdLabel;
    
    //data
    @property (nonatomic,copy) NSString *phoneNumber;
    @property (nonatomic,copy) NSString *token;
    @property (nonatomic,copy) NSString *authorizationCode;
    @property (nonatomic,copy) NSString *randomCode;
    @property (nonatomic,copy)NSString *errorMsg;
    @property (nonatomic,copy)NSString *loadingMsg;
    @end

@implementation AuthVC
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing: YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
}
-(void)initData{
    [RACObserve(self, errorMsg)  subscribeNext:^(id x) {
        if (x == nil) {
            return ;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [HETCommonHelp showAutoDissmissWithMessage:x];
        });
    }];
    
    [[RACObserve(self, loadingMsg) distinctUntilChanged] subscribeNext:^(id x) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            x == nil?[HETCommonHelp HidHud]:[HETCommonHelp showCustomHudtitle:x];
        });
    }];
    
    self.view.layer.masksToBounds = YES;
}
- (IBAction)requestAuthCode:(id)sender {
    if (self.phoneNumberTextFeild.text.length != 11) {
        self.errorMsg = @"请输入正确的手机号码";
        return;
    }
    self.phoneNumber = self.phoneNumberTextFeild.text;
    self.loadingMsg =  @"正在请求...";
    
    [[HETThirdCloudAuthorize shareInstance] getAuthorizationCodeWithAccount:self.phoneNumber
                                                                 withOpenId:@""
                                                                    success:^(id responseObject) {
                                                                        self.loadingMsg = nil;
                                                                        NSString * authorizationCode = [responseObject valueForKeyPath:@"data.authorizationCode"];
                                                                        NSLog(@"%@",authorizationCode);
                                                                        self.authorizationCode = authorizationCode;
                                                                        self.authorCodeLabel.text = [NSString stringWithFormat:@"授权码:%@",self.authorizationCode];
                                                                    }
                                                                    failure:^(NSError *error) {
                                                                        self.loadingMsg = nil;
                                                                        self.errorMsg = [error.userInfo valueForKey:@"NSLocalizedDescription"];
                                                                        
                                                                    }];
    
    
}
- (IBAction)getToken:(id)sender {
    
    NSString *reqStr = [NSString stringWithFormat:@"appId=%@&appSecret=%@&timestamp=%@",kHETAppId,kHETAppSecret,Tools.timestamp];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *env = [defaults objectForKey:kHETEnviroment];
    NSString *path = @"/v1/cloud/token";
    if (env.integerValue == 0) {
        path = @"/v1/app/open/cloud/token";
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",Tools.getHostName,path];
    //  /v1/cloud/token /v1/app/open/cloud/token
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [reqStr dataUsingEncoding:NSUTF8StringEncoding];
    
    self.loadingMsg = @"模拟服务器获取token";
    NSURLSession *session = [NSURLSession sharedSession];
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
                                      self.errorMsg = [responseObject objectForKey:@"msg"];
                                      return;
                                  }else{
                                      NSDictionary *dataDic = [responseObject objectForKey:@"data"];
                                      NSString *token = [dataDic objectForKey:@"accessToken"];
                                      if(token){
                                          self.token = token;
                                      }else{
                                          self.errorMsg = @"获取token失败啦!";
                                      }
                                  }
                              }];
    [task resume];
}
- (IBAction)getRandomCode:(id)sender {
    if (self.authorizationCode == nil) {
        self.errorMsg = @"请先获取授权码";
        return;
    }
    if (self.token == nil) {
        self.errorMsg = @"请先获取token";
        return;
    }
    
    NSString *reqStr = [NSString stringWithFormat:@"appId=%@&appSecret=%@&timestamp=%@&authorizationCode=%@&accessToken=%@",kHETAppId,kHETAppSecret,Tools.timestamp,self.authorizationCode,self.token];
    //  /v1/app/open/cloud/user/checkAuth  /v1/cloud/user/checkAuth
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *env = [defaults objectForKey:kHETEnviroment];
    NSString *path = @"/v1/cloud/user/checkAuth";
    if (env.integerValue == 0) {
        path = @"/v1/app/open/cloud/user/checkAuth";
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",Tools.getHostName,path];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [reqStr dataUsingEncoding:NSUTF8StringEncoding];
    self.loadingMsg = @"正在获取随机码";
    NSURLSession *session = [NSURLSession sharedSession];
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
                                      self.errorMsg = [responseObject objectForKey:@"msg"];
                                      return;
                                  }else{
                                      NSDictionary *dataDic = [responseObject objectForKey:@"data"];
                                      NSString *randomCode = [dataDic objectForKey:@"randomCode"];
                                      if(randomCode){
                                          self.randomCode = randomCode;
                                      }else{
                                          self.errorMsg = @"获取随机码失败啦!";
                                      }
                                  }
                              }];
    [task resume];
    
}
- (IBAction)getOpenIdHandle:(id)sender {
    if (self.randomCode == nil) {
        self.errorMsg = @"请先获取随机码";
        return;
    }
    if (self.textCodeTextFeild.text == nil) {
        self.errorMsg = @"请输入短信验证码";
        return;
    }
    self.loadingMsg = @"正在获取OpenId";
    [[HETThirdCloudAuthorize shareInstance]autoAuthorizeWithRandomCode:self.randomCode verificationCode:self.textCodeTextFeild.text withCompleted:^(NSString *openId, NSError *error) {
        self.loadingMsg = nil;
        if(error){
            self.errorMsg = [error.userInfo valueForKey:@"NSLocalizedDescription"];
        }else{
            if (openId) {
                self.openIdLabel.text = [NSString stringWithFormat:@"OpenId:%@",openId];
                self.errorMsg = @"授权成功";
                [self saveOpenId:openId];
            }
        }
    }];
}
    
-(void)saveOpenId:(NSString *)openId{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *env = [defaults objectForKey:kHETEnviroment];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"OpenIdInfo"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"enviroment == %d",env.integerValue];
    request.predicate = predicate;
    NSArray *arr = [AppDelegate.context executeFetchRequest:request error:nil];
    if (arr.count == 0) {
        OpenIdInfo *info = [NSEntityDescription insertNewObjectForEntityForName:@"OpenIdInfo" inManagedObjectContext:AppDelegate.context];
        info.enviroment = env.integerValue;
        info.openId = openId;
        info.phone = self.phoneNumber;
    }else{
        OpenIdInfo *info = arr.firstObject;
        info.openId = openId;
        info.phone = self.phoneNumber;
    }
    [AppDelegate.context save:nil];
    
}
- (IBAction)dismiss:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *env = [defaults objectForKey:kHETEnviroment];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"OpenIdInfo"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"enviroment == %d",env.integerValue];
    request.predicate = predicate;
    
    NSArray *arr = [AppDelegate.context executeFetchRequest:request error:nil];
    if (arr.count == 0 || ((OpenIdInfo *)[arr firstObject]).openId.length < 32){
        self.errorMsg = @"您还未授权成功";
        return;
    }
    !self.dismiss?:self.dismiss(((OpenIdInfo *)[arr firstObject]).openId);
}
- (IBAction)cancelHandle:(id)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *env = [defaults objectForKey:kHETEnviroment];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"OpenIdInfo"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"enviroment == %d",env.integerValue];
    request.predicate = predicate;
    
    NSArray *arr = [AppDelegate.context executeFetchRequest:request error:nil];
    if (arr.count == 0 || ((OpenIdInfo *)[arr firstObject]).openId.length < 32){
        self.errorMsg = @"您未授权成功,需要授权成功才能使用Het服务";
    }
    !self.dismiss?:self.dismiss(nil);
}
    
-(void)setErrorMsg:(NSString *)errorMsg{
    self.loadingMsg = nil;
    _errorMsg = errorMsg;
}
    @end
