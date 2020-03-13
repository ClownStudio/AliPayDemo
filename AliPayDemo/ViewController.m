//
//  ViewController.m
//  AliPayDemo
//
//  Created by Jam Zhang on 2020/3/13.
//  Copyright © 2020 Jam Zhang. All rights reserved.
//

#import "ViewController.h"
#import "APAuthInfo.h"
#import "APRSASigner.h"
#import <AlipaySDK/AlipaySDK.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self doAPAuth];
}

- (void)doAPAuth
{
    // 重要说明
    // 这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
    // 真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
    // 防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *pid = @"2088302068315794";
    NSString *appID = @"2021001141672266";
    
    // 如下私钥，rsa2PrivateKey 或者 rsaPrivateKey 只需要填入一个
    // 如果商户两个都设置了，优先使用 rsa2PrivateKey
    // rsa2PrivateKey 可以保证商户交易在更加安全的环境下进行，建议使用 rsa2PrivateKey
    // 获取 rsa2PrivateKey，建议使用支付宝提供的公私钥生成工具生成，
    // 工具地址：https://doc.open.alipay.com/docs/doc.htm?treeId=291&articleId=106097&docType=1
    NSString *rsa2PrivateKey = @"MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCZJY8A+IwJNrEs4iQNaojoUexC7rrqLGSwMcEfC154n5IduBt213Zu6crUhu4UN4wVJlqpLzreLviffbUqEM83Whf9nMXVms4y7pRd/ze0gT7iMobwZShjfuw7UZ0QxKfvFqktoR9xwiGusYqUYNhMHjZGYnTebcnk/KtgQ+Oygpx0nI+Nu7GLDXtp6oc5NGxWCzicSo7wB5HsStA3pD/FIn2WVfivy3DIKGUrwEQ/YQVzwtLeZifSejS314efmvFTuh06r5QVUmHunmddckjnTCklEaWaQQKEFed7mgQbmHTlHcKEUghPy72QSP5Pi6zX3tREMCPbLSsDzJAz90sPAgMBAAECggEBAIL03AEfiFfEneLciamzRNksXJSrocfnKD6GfTa3uRP6l660JUANZOfZIal0rBc7nJzlTDdJ/NPLZKy1iPosn5UchFFJAt7yXoqs+tAaEp9WudghDsR4K/5QpV7gHigdkeDgBtDO652SPM0uYmsZGTyVxSGQxZECXtdhvIY353hX4khw9ffo6jSnW8kp1195yTsYvIw1N9nhr2M2hzi2evyI9FLCtEUumX+vpt7jUacK/Jg/6OCH0DYPDzPcTOdkKhadAptCCvuRu3q+MGhAbe4jWomNm2DZr1Z0BXq5b7/YqZJ0bICOu9ryT4+u2wDUcClpBdl7j5BGK45+VSUaRIECgYEA6nccBk+Q1grrpm+hR9pXsIFfSzVxCk0nd8/AUoUyW7CLVB2t8Rav9aIlnCLDo398BKw527cWPhQ6RnLtznMS4ssCWLpUL+n48xMrPEXA1gNlm/9J6ZPs9mC1ieRM6xtjxVcfOc7Yyv7efDeIgGfjG/57mEub+A4X3ntbMNfQbcECgYEApzZwBUarTWKDwrGeZhQ8vz5fZTII2QbMvuyCCb6IjM1ztIZsqHyMXCAUsIw2m6++UnlWFLragol6XU5Uf7H12AraXFWKvQZgZ1mFeNIwxQRpDJ7R8JxEKKR0hAYCUg4Mvr413g8d2TnuJyFnMkNxZaib2ZOlJVjfUsBuB8KpjM8CgYADaqbq5J/sro4Oh9Pm0ySx+sCjvOyfxM4NbeaUjUJVmbX+DMyrFbSMtMcthkgpisMI4mWZcQqO7waGXkhe2Mhuq5ymJFjztcod6KqZnz6XH8eMRWUTVUd/s5sRnlUMnAKRLprS4dPA6YPedYS0sk7Z6pRsfLWSIMpyQIPsq0hrQQKBgEuqPpakm++wnJ8FcQAQOEzyFIjeU1Kh2RSsQUvXhELy1WDjU1gKxBkMC1C4oh1hMWZwsZs/0pEvVMfUIjiGdxEEGDugGd/fetBJmjRKKPd+P2sOk0Gl9NHPWUpEzdgDs5C80fNiM8eQh0v9uYztJ+swmRWj0h9MUAJKQYARflfRAoGBANQsKxXzDPodbyInb5RqQMv802wCLhh8F07ptOdWeIjLDj5y/4+5557GrgOn1x6ZMeeUBjHQOWw7LVwnboT4s5hJz/npTs5CI0pRpkMdcC57UO6RNiLflcf8EB4j+rUaV5GN2PdvDGam1oZtv8kKR5SO3s6Y3ioQciqkm6tpdbBe";
    NSString *rsaPrivateKey = @"";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //pid和appID获取失败,提示
    if ([pid length] == 0 ||
        [appID length] == 0 ||
        ([rsa2PrivateKey length] == 0 && [rsaPrivateKey length] == 0))
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                       message:@"缺少pid或者appID或者私钥,请检查参数设置"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action){
                                                           
                                                       }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:^{ }];
        return;
    }
    
    //生成 auth info 对象
    APAuthInfo *authInfo = [APAuthInfo new];
    authInfo.pid = pid;
    authInfo.appID = appID;
    
    //auth type
    NSString *authType = [[NSUserDefaults standardUserDefaults] objectForKey:@"authType"];
    if (authType) {
        authInfo.authType = authType;
    }
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"qiandazhanggui";
    
    // 将授权信息拼接成字符串
    NSString *authInfoStr = [authInfo description];
    NSLog(@"authInfoStr = %@",authInfoStr);
    
    // 获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    NSString *signedString = nil;
    APRSASigner* signer = [[APRSASigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
    if ((rsa2PrivateKey.length > 1)) {
        signedString = [signer signString:authInfoStr withRSA2:YES];
    } else {
        signedString = [signer signString:authInfoStr withRSA2:NO];
    }
    
    // 将签名成功字符串格式化为订单字符串,请严格按照该格式
    if (signedString.length > 0) {
        authInfoStr = [NSString stringWithFormat:@"%@&sign=%@&sign_type=%@", authInfoStr, signedString, ((rsa2PrivateKey.length > 1)?@"RSA2":@"RSA")];
        [[AlipaySDK defaultService] auth_V2WithInfo:authInfoStr
                                         fromScheme:appScheme
                                           callback:^(NSDictionary *resultDic) {
                                               NSLog(@"result = %@",resultDic);
                                               // 解析 auth code
                                               NSString *result = resultDic[@"result"];
                                               NSString *authCode = nil;
                                               if (result.length>0) {
                                                   NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                                                   for (NSString *subResult in resultArr) {
                                                       if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                                                           authCode = [subResult substringFromIndex:10];
                                                           break;
                                                       }
                                                   }
                                               }
                                               NSLog(@"授权结果 authCode = %@", authCode?:@"");
                                           }];
    }
}

@end
