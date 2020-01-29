//
//  JDCPollution.m
//  AirQuality-C31
//
//  Created by Jon Corn on 1/29/20.
//  Copyright © 2020 Jon Corn. All rights reserved.
//

#import "JDCPollution.h"

@implementation JDCPollution

// Model initializer
- (instancetype)initWithInt:(NSInteger)aqi
{
    self = [self init];
    if (self)
    {
        _airQualityIndex = aqi;
    }
    return self;
}

@end

@implementation JDCPollution (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    
}

@end
