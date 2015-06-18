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
#import "FISMainTableViewController.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (strong,nonatomic) NSString *token;
@property (nonatomic, strong) NSDictionary *imageFiles;
@property (nonatomic, strong) NSMutableArray *imagePagination;
@property (nonatomic, strong) NSMutableString *paginationID;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imagePagination = [[NSMutableArray alloc]init];
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

-(void)fetchImagesFromURL:(NSURL *)url
{
    // do the AFNetworking request
    // stash the results in an array property
    // if there are more pages, feed those back into -fetchImagesFromURL:
    // when all pages are done ... ... call a method?
}

- (IBAction)loginAction:(id)sender {
    
    
    /* ============================================================================================*/
    NSString *url = [NSString stringWithFormat:@"https://api.instagram.com/v1/users/self/media/recent/?access_token=%@",self.token];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSDictionary *returnData = responseObject;
        self.imageFiles = responseObject;
        self.paginationID = [NSMutableString stringWithFormat:@"&max_id=%@",self. imageFiles[@"pagination"][@"next_max_id"]];
        
        NSLog(@"Next URL for Pagination: %@",returnData[@"pagination"][@"next_url"]);  //pagination url
        NSLog(@"Next URL for Pagination: %@", self.paginationID);  //pagination url
        NSLog(@"Image Count: %lu",(unsigned long)[returnData[@"data"] count]);
        
        for (NSDictionary * image in returnData[@"data"]){
            //NSLog(@"Timestamp:%@",image[@"created_time"]);
            [self.imagePagination addObject:image];
            NSLog(@"Image array count: %lu", (unsigned long)self.imagePagination.count);
        }
        if (self.imageFiles[@"pagination"][@"next_url"]){
            NSLog(@"There are more images, need to paginate:");
            [self getNextInstagramPage:self.paginationID];
        }
        if (!self.imageFiles[@"pagination"][@"next_url"]){
            NSLog(@"There are no more images");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
    /* ============================================================================================*/
}
-(void)getNextInstagramPage: (NSString*)nextPaginationID{
    /* ============================================================================================*/
    NSString *url = [NSString stringWithFormat:@"https://api.instagram.com/v1/users/self/media/recent/?access_token=%@%@",self.token,nextPaginationID];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *returnData = responseObject;
        self.imageFiles = responseObject;
        self.paginationID = [NSMutableString stringWithFormat:@"&max_id=%@",self. imageFiles[@"pagination"][@"next_max_id"]];
        
        for (NSDictionary * image in returnData[@"data"]){
            [self.imagePagination addObject:image];
            NSLog(@"Image array count: %lu", (unsigned long)self.imagePagination.count);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
    /* ============================================================================================*/
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    FISMainTableViewController * destination = segue.destinationViewController;
    
    destination.imageList = self.imagePagination;
    
    
    
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
