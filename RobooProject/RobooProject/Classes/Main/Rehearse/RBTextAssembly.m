//
//  RBTextAssembly.m
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/5/24.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBTextAssembly.h"

@implementation RBTextAssembly

/*
 //伪代码
 WCRedEnvelopesControlData * m_data = MSHookIvar<WCRedEnvelopesControlData *>(self,"m_data");
 CMessageWrap * msgWrap = [m_data  m_oSelectedMessageWrap];
 WCPayInfoItem * payInfoItem  = [msgWrap m_oWCPayInfoItem];
 NSString * c2cNativeUrl = [payInfoItem m_c2cNativeUrl];
 NSUInteger len = [@"wxpay://c2cbizmessagehandler/hongbao/receivehongbao?" length];
 NSString * c2cNativeUrl2 = [c2cNativeUrl substringFromIndex:len];
 NSDictionary * url_dic = [%c(WCBizUtil) dictionaryWithDecodedComponets:c2cNativeUrl2 separator:@"&"];
 NSMutableDictionary * mutalbe_dic = [%c(NSMutableDictionary) dictionary];
 [mutalbe_dic setObject:@"1" forKey:@"msgType"];
 [mutalbe_dic setObject:url_dic[@"sendid"] forKey:@"sendId"];
 [mutalbe_dic setObject:url_dic[@"channelid"] forKey:@"channelId"];
 MMServiceCenter * mmserCent = [%c(MMServiceCenter) defaultCenter];
 Class ccmgr = [%c(CContactMgr) class];
 CContactMgr * contactMgr = [mmserCent getService:ccmgr];
 CContact * selfContact = [contactMgr getSelfContact];
 id displayName = [selfContact getContactDisplayName];
 [mutalbe_dic setObject:displayName forKey:@"nickName"];
 [mutalbe_dic setObject:[selfContact m_nsHeadImgUrl] forKey:@"headImg"];
 if (msgWrap)
 {
 NSString * nativeUrl =  c2cNativeUrl;
 [mutalbe_dic setObject:nativeUrl forKey:@"nativeUrl"];
 }
 MMMsgLogicManager * redEvenlopsLogicMgr = [[%c(MMServiceCenter) defaultCenter] getService:[%c(MMMsgLogicManager) class]];
 WeixinContentLogicController * currentLogicContoller  = [redEvenlopsLogicMgr GetCurrentLogicController];
 if ( currentLogicContoller )
 {
 CBaseContact * m_contact = [currentLogicContoller m_contact];
 if ( m_contact )
 {
 CBaseContact * contact = [currentLogicContoller m_contact];
 NSString * nsUsrName = [contact m_nsUsrName];
 if ( nsUsrName )
 {
 [mutalbe_dic setObject:nsUsrName forKey:@"sessionUserName"];
 }
 }
 }






 NSLog(@"%@",[displayName class]);



 NSDictionary * m_dicBaseInfo = [m_data m_structDicRedEnvelopesBaseInfo];
 NSString * timingIdentifier = m_dicBaseInfo[@"timingIdentifier"];
 if ([timingIdentifier length]){
 [mutalbe_dic setObject:timingIdentifier forKey:@"timingIdentifier"];
 }


 WCPayLogicMgr * payLogic = [[%c(MMServiceCenter) defaultCenter] getService:[%c(WCPayLogicMgr) class]];



 [payLogic setRealnameReportScene:(unsigned int)1003];
 id subScript = [m_dicBaseInfo objectForKeyedSubscript:@"agree_duty"];


 [payLogic checkHongbaoOpenLicense:subScript acceptCallback:^(){
 WCRedEnvelopesLogicMgr * redEvenlopsLogicMgr  = [[%c(MMServiceCenter) defaultCenter] getService:[%c(WCRedEnvelopesLogicMgr) class]];

 [redEvenlopsLogicMgr OpenRedEnvelopesRequest:mutalbe_dic];

 } denyCallback:^(){

 }];

 */

@end
