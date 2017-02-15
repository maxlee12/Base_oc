//
//  User.h
//  Pear
//
//  Created by Lawrence on 16/1/13.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSInteger, powerType){
    
    EMPLOYEE  = 0,      //@"employee"        //普通员工
    ATTD_ADMIN,         //@"attd_admin"     //公司考勤员
    ATTD_OU_ADMIN,      //@"attd_ou_admin"  //部门考勤员
    CORP_ADMIN ,        //@"corp_admin"     //公司管理员
    MANAGER ,           //@"manager"        //经理
    
};

@interface User : NSObject
@property(nonatomic,strong) NSString *userCorporationId;
@property(nonatomic,strong) NSString *userCorporationType;
@property(nonatomic,strong) NSString *userPartyId;   //partyId
@property(nonatomic,strong) NSString *userDepartmentId;   //departmentId
@property(nonatomic,strong) NSString *userDepartmentName;


@property(nonatomic,strong) NSString *userCorpversion;  //公司规则类型
@property(nonatomic,strong) NSString *userCompanyName;
@property(nonatomic,strong) NSString *userCompanyLogo;
@property(nonatomic,strong) NSString *userNickName;
@property(nonatomic,strong) NSString *firstName;
@property(nonatomic,strong) NSString *userPost;
@property(nonatomic,strong) NSString *userId;
@property(nonatomic,strong) NSString *userPhoneNum;
@property(nonatomic,strong) NSString *userIdCard;
@property(nonatomic,strong) NSString *userSign;
@property(nonatomic,strong) NSString *userToken;
@property(nonatomic,strong) NSString *userImgurl;
@property(nonatomic,strong) NSArray *userPermissionList;



@property(nonatomic,strong) NSString *userCreatedStamp;
@property(nonatomic,strong) NSString *userLastUpdatedStamp;

@property(nonatomic,strong)NSString *weChatOpenid;
@property(nonatomic,strong)NSString *openNickname;
@property(nonatomic,strong)NSString *openImgUrl;

@end
