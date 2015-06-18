//
//  FISMainTableViewCell.h
//  FISInsta
//
//  Created by Val Osipenko on 6/18/15.
//  Copyright (c) 2015 Cong Sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FISMainTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageThumbnail;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;
@end
