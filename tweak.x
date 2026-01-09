#import <UIKit/UIKit.h>

// ئەم کۆدە لە کاتی کردنەوەی هەر پەڕەیەکی بەرنامەکەدا کار دەکات
%hook UIViewController

- (void)viewDidAppear:(BOOL)animated {
    %orig;

    // ئەم بەشە دڵنیایی دەداتەوە کە دایەلۆگەکە تەنها یەکجار دەردەکەوێت و دووبارە نابێتەوە
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // دروستکردنی ناوەڕۆکی ئاگادارکردنەوەکە
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Welcome"
            message:@"\n بەخێرهاتن \n\n ئەم بەرنامەیە لە لایەن M1StoreCa درووست کراوە"
            preferredStyle:UIAlertControllerStyleAlert];

        // دروستکردنی دوگمەی تێلیگرام
        UIAlertAction *telegramAction = [UIAlertAction actionWithTitle:@"Join Telegram"
            style:UIAlertActionStyleDefault
            handler:^(UIAlertAction * action) {
                // لێرە لینکی تێلیگرامەکەی خۆت دابنێ
                NSURL *url = [NSURL URLWithString:@"https://t.me/M1StoreCa"];
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            }];

        // دوگمەی داخستن (OK)
        UIAlertAction *closeAction = [UIAlertAction actionWithTitle:@"باشە"
            style:UIAlertActionStyleCancel
            handler:nil];

        // زیادکردنی دوگمەکان بۆ ناو دایەلۆگەکە
        [alert addAction:telegramAction];
        [alert addAction:closeAction];

        // پیشاندانی دایەلۆگەکە بە شێوازێکی جوڵاو (Animated)
        [self presentViewController:alert animated:YES completion:nil];
    });
}

%end
