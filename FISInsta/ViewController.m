//
//  ViewController.m
//  FISInsta
//
//  Created by Cong Sun on 6/17/15.
//  Copyright (c) 2015 Cong Sun. All rights reserved.
//

#import "ViewController.h"
#import <InstagramSimpleOAuth.h>
#import <AFNetworking.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property(strong,nonatomic) NSString *token;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    InstagramSimpleOAuthViewController
    *viewController = [[InstagramSimpleOAuthViewController alloc] initWithClientID:@"3be1650732ff4b45b1887c3b333994ed"
                                                                      clientSecret:@"68cf1c07835d49908ddffbd94580dde9"
                                                                       callbackURL:[NSURL URLWithString:@"http://fis.valosip.com"]
                                                                        completion:^(InstagramLoginResponse *response, NSError *error) {
                                                                            NSLog(@"My Access Token is: %@", response.accessToken);
                                                                            self.token = response.accessToken;
                                                                            //NSLog(@"%@",response);
                                                                            
                                                                        }];
    
    [self presentViewController:viewController animated:YES completion:nil];
    
    

    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)loginAction:(id)sender {
    NSString *url = [NSString stringWithFormat:@"https://api.instagram.com/v1/users/self/feed?access_token=%@",self.token];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

//    InstagramSimpleOAuthViewController
//    *viewController = [[InstagramSimpleOAuthViewController alloc] initWithClientID:@"3be1650732ff4b45b1887c3b333994ed"
//                                                                      clientSecret:@"68cf1c07835d49908ddffbd94580dde9"
//                                                                       callbackURL:[NSURL URLWithString:@"http://fis.valosip.com"]
//                                                                        completion:^(InstagramLoginResponse *response, NSError *error) {
//                                                                            NSLog(@"My Access Token is: %@", response.accessToken);
//                                                                            //NSLog(@"%@",response);
//                                                                            
//                                                                        }];
//    
//    [self presentViewController:viewController animated:YES completion:nil];
//    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
