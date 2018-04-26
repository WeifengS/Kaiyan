//
//  WFFontUtil.m
//  kaiyan
//
//  Created by Apple on 2018/4/19.
//  Copyright © 2018年 shiweifeng. All rights reserved.
//

#import "WFFontUtil.h"

@implementation WFFontUtil
+(void)fontName{
    for(NSString *familyname in [UIFont familyNames])
        
    {
        
        NSLog(@"family:'%@'",familyname);
        
        for(NSString *fontName in [UIFont fontNamesForFamilyName:familyname])
            
        {
            
            NSLog(@"\tfont:'%@'",fontName);
            
        }
        
    }
}
@end
