//
//  JDCCityAirQuality.m
//  AirQuality-C31
//
//  Created by Jon Corn on 1/29/20.
//  Copyright © 2020 Jon Corn. All rights reserved.
//

#import "JDCCityAirQuality.h"
#import "JDCWeather.h"
#import "JDCPollution.h"

@implementation JDCCityAirQuality

- (instancetype)initWithCity:(NSString *)city state:(NSString *)state country:(NSString *)country weather:(JDCWeather *)weather pollution:(JDCPollution *)pollution
{
    self = [super init];
    if (self) {
        _city = city;
        _state = state;
        _country = country;
        _weather = weather;
        _pollution = pollution;
    }
    return self;
}

@end

@implementation JDCCityAirQuality (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSString *city = dictionary[@"city"];
    NSString *state = dictionary[@"state"];
    NSString *country = dictionary[@"country"];
    NSDictionary *currentInfo = dictionary[@"current"];
    
    JDCWeather *weather = [[JDCWeather alloc] initWithDictionary:currentInfo[@"weather"]];
    JDCPollution *pollution = [[JDCPollution alloc] initWithDictionary:currentInfo[@"pollution"]];
    
    return [self initWithCity:city state:state country:country weather:weather pollution:pollution];
}

@end
