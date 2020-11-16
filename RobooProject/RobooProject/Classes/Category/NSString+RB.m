//
//  NSString+RB.m
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/9/25.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "NSString+RB.h"

@implementation NSString (RB)

- (NSURL *)url{
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    return [NSURL URLWithString:(NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]", NULL,kCFStringEncodingUTF8))];
#pragma clang diagnostic pop
}
@end
