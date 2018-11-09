//
//  AppDelegate.m
//  HETKunYuanDemo
//
//  Created by JustinYang on 2018/10/10.
//  Copyright © 2018年 JustinYang. All rights reserved.
//

#import "AppDelegate.h"
#import <MagicalRecord/MagicalRecord.h>

@interface AppDelegate ()
@property(nonatomic,strong) NSManagedObjectContext *managedObjectContext;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [HETOpenSDK registerAppId:kHETAppId appSecret:kHETAppSecret];
    [HETOpenSDK openLog:YES];
    [AppDelegate enviromentInit];

    [self initCoreData];
    [MagicalRecord setupCoreDataStack];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)initCoreData{
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];

    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    
    NSPersistentStoreCoordinator *store = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    NSString *docStr = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *sqlPath = [docStr stringByAppendingPathComponent:@"coreData.sqlite"];
    NSLog(@"数据库 path = %@", sqlPath);
    NSURL *sqlUrl = [NSURL fileURLWithPath:sqlPath];
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption,
                             nil];
    
    
    NSError *error = nil;
    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:sqlUrl options:options error:&error];
    
    if (error) {
        NSLog(@"添加数据库失败:%@",error);
    } else {
        NSLog(@"添加数据库成功");
    }
    

    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    context.persistentStoreCoordinator = store;

    _managedObjectContext = context;
}

+(NSManagedObjectContext *)context{
    return ((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;
}


+(void)enviromentSetting:(NSInteger)setting{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@(setting) forKey:kHETEnviroment];
    NSNumber *env = [defaults objectForKey:kHETEnviroment];
    [defaults synchronize];
    [self setOpenSDKEnviroment:[env integerValue]];
}
+(void)enviromentInit{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *env = [defaults objectForKey:kHETEnviroment];
    
    [self setOpenSDKEnviroment:[env integerValue]];
}
+(void)setOpenSDKEnviroment:(NSInteger)env{
    switch (env) {
        case 0:
            [HETOpenSDK setNetWorkConfig:HETNetWorkConfigType_ETE];
            break;
        case 1:
            [HETOpenSDK setNetWorkConfig:HETNetWorkConfigType_PRE];
            break;
        case 2:
            [HETOpenSDK setNetWorkConfig:HETNetWorkConfigType_PE];
            break;
        default:
            [HETOpenSDK setNetWorkConfig:HETNetWorkConfigType_ETE];
            break;
    }
}
@end
