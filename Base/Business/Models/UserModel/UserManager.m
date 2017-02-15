//
//  UserManager.m
//  Pear
//
//  Created by Lawrence on 16/1/13.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "UserManager.h"
#import "HTTPRequestManager.h"

@implementation UserManager

static UserManager* userManager = nil;

-(id)init
{
    if (self = [super init]) {
        [self loadUserMessageFromDesk];
    }
    return self;
}



+(id)sharUserManager{
    
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        userManager = [[self alloc] init] ;
    }) ;
    
    return userManager ;
    
}

/** 从内存导入用户信息 */
-(void)loadUserMessageFromDesk{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:CurrentUser_key]) {
        self.userDic = [NSMutableDictionary dictionaryWithDictionary:[defaults objectForKey:CurrentUser_key]];
        self.currentUser =[[User alloc]init];
        [self.currentUser setValuesForKeysWithDictionary:self.userDic];
    }
    else{
        self.userDic = [[NSMutableDictionary alloc]init];
        self.currentUser = [[User alloc]init];
    }
}

-(void)removeAllData{
    
    self.currentUser = [[User alloc] init];
    self.userDic = [[NSMutableDictionary alloc] init];
}


//字典赋值方法
-(void)setUserDicWith :(NSDictionary*)responDic{
    
    [self.userDic setValue:responDic[@"data"][@"corporationId"] forKey:@"userCorporationId"];
    [self.userDic setValue:responDic[@"data"][@"corporationType"] forKey:@"userCorporationType"];
    [self.userDic setValue:responDic[@"data"][@"partyId"] forKey:@"userPartyId"];
    [self.userDic setValue:responDic[@"data"][@"departmentId"] forKey:@"userDepartmentId"];
    [self.userDic setValue:responDic[@"data"][@"departmentName"] forKey:@"userDepartmentName"];
    [self.userDic setValue:responDic[@"data"][@"corporationName"] forKey:@"userCompanyName"];

    [self.userDic setValue:responDic[@"data"][@"corporationVersion"] forKey:@"userCorpversion"];
//
    [self.userDic setValue:responDic[@"data"][@"corporationLogo"] forKey:@"userCompanyLogo"];
    //更新时间
    [self.userDic setValue:responDic[@"data"][@"createdStamp"] forKey:@"userCreatedStamp"];
    [self.userDic setValue:responDic[@"data"][@"lastUpdatedStamp"] forKey:@"userLastUpdatedStamp"];
    
    [self.userDic setValue:responDic[@"data"][@"nickname"] forKey:@"userNickName"];
    [self.userDic setValue:responDic[@"data"][@"firstName"] forKey:@"firstName"];
    [self.userDic setValue:responDic[@"data"][@"userId"] forKey:@"userId"];
    [self.userDic setValue:responDic[@"data"][@"position"] forKey:@"userPost"];
    [self.userDic setValue:responDic[@"data"][@"tel"] forKey:@"userPhoneNum"];
    [self.userDic setValue:responDic[@"data"][@"sign"] forKey:@"userSign"];
    [self.userDic setValue:responDic[@"data"][@"token"] forKey:@"userToken"];
    [self.userDic setValue:responDic[@"data"][@"headImgUrl"] forKey:@"userImgurl"];
    [self.userDic setValue:responDic[@"data"][@"permissionList"] forKey:@"userPermissionList"];
    
    
    
    //微信相关
    [self.userDic setValue:responDic[@"data"][@"openId"] forKey:@"weChatOpenid"];
    [self.userDic setValue:responDic[@"data"][@"openImgUrl"] forKey:@"openImgUrl"];
    [self.userDic setValue:responDic[@"data"][@"openNickname"] forKey:@"openNickname"];
    
    


    [self setCurrentUserWithSelfUserDic];

}

-(void)setCurrentUserWithSelfUserDic{
    
    //用户赋值
    [self.currentUser setValuesForKeysWithDictionary:self.userDic];
//    DebugLog(@"%@",self.currentUser);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.userDic forKey:CurrentUser_key];
    [defaults synchronize];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    [self setValue:@"" forKey:key];
}


@end
