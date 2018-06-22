//
//  LrcModel.h
//  Obj-C-Project
//
//  Created by 邵亮亮 on 2018/6/22.
//  Copyright © 2018年 shaoliangliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LrcModel : NSObject
@property (nonatomic,assign) NSTimeInterval startTime;
@property (nonatomic,assign) NSTimeInterval endTime;
@property (nonatomic,copy)   NSString *lrcLabel;
@end
