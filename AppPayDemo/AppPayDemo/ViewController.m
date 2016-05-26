//
//  ViewController.m
//  AppPayDemo
//
//  Created by Biao on 16/5/26.
//  Copyright © 2016年 Biao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller didAuthorizePayment:(PKPayment *)payment completion:(void (^)(PKPaymentAuthorizationStatus))completion
{
    
    NSLog(@"Payment was authorized: %@", payment);
    
    BOOL asuncSuccessful = FALSE;
    
    if(asuncSuccessful)
    {
        //身份验证是否会成功
        completion(PKPaymentAuthorizationStatusSuccess);
        NSLog(@"支付成功");
    }
    else
    {
        //身份验证是否会失败
        completion(PKPaymentAuthorizationStatusFailure);
        NSLog(@"支付失败");
    }
    
}

/**
 *  @author Biao
 *
 *  完成付款视图控制器
 */
- (void)paymentAuthorizationViewControllerDidFinish:(PKPaymentAuthorizationViewController *)controller
{
    NSLog(@"Finishing payment view controller");
    
    [controller dismissViewControllerAnimated:TRUE completion:nil];
}


- (IBAction)checkOut:(id)sender
{
    if([PKPaymentAuthorizationViewController canMakePayments])
    {
        NSLog(@"可以支付.");
        PKPaymentRequest *request = [PKPaymentRequest new];

        //支付卡类
        PKPaymentSummaryItem *widget1 = [PKPaymentSummaryItem
                                         summaryItemWithLabel:@"Widget 1"
                                         amount:[NSDecimalNumber decimalNumberWithString:@"0.99"]];
        PKPaymentSummaryItem *widget2 = [PKPaymentSummaryItem
                                         summaryItemWithLabel:@"Widget 2"
                                         amount:[NSDecimalNumber decimalNumberWithString:@"1.00"]];
        PKPaymentSummaryItem *widget3 = [PKPaymentSummaryItem
                                         summaryItemWithLabel:@"Widget 3"
                                         amount:[NSDecimalNumber decimalNumberWithString:@"2.00"]];
        //支付总数
        PKPaymentSummaryItem *total = [PKPaymentSummaryItem
                                         summaryItemWithLabel:@"Grand Total"
                                       amount:[NSDecimalNumber decimalNumberWithString:@"3.99"]];
        
        
        request.paymentSummaryItems = @[widget1,widget2,widget3,total];
        
        //国家
        request.countryCode = @"US";
        //货币
        request.currencyCode = @"USD";
        //支付卡类
        request.supportedNetworks = @[PKPaymentNetworkAmex,PKPaymentNetworkMasterCard,PKPaymentNetworkVisa,PKPaymentNetworkChinaUnionPay];
        //银行标示
        request.merchantIdentifier = @"merchant.com.demo.crittercismdemo";
        
        //支付功能
        request.merchantCapabilities = PKMerchantCapabilityEMV;
        
        //付款窗口
        PKPaymentAuthorizationViewController *paymentPane = [[PKPaymentAuthorizationViewController alloc]initWithPaymentRequest:request];
        //设置代理
        paymentPane.delegate = self;
        
        [self presentViewController:paymentPane animated:TRUE completion:^{
        
        }];
        
    }
    else
    {
        NSLog(@"这个设备不能支付");
    }
    
    
}







@end
