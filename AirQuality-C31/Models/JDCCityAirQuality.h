//
//  JDCCityAirQuality.h
//  AirQuality-C31
//
//  Created by Jon Corn on 1/29/20.
//  Copyright © 2020 Jon Corn. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JDCWeather;
@class JDCPollution;

NS_ASSUME_NONNULL_BEGIN

@interface JDCCityAirQuality : NSObject

// Create model properties
@property (nonatomic, copy, readonly) NSString *city;
@property (nonatomic, copy, readonly) NSString *state;
@property (nonatomic, copy, readonly) NSString *country;
// Endpoint has two more levels of dicts, add them as properties
@property (nonatomic, copy, readonly) JDCWeather *weather;
@property (nonatomic, copy, readonly) JDCPollution *pollution;
// Initializer for this model object
- (instancetype)initWithCity:(NSString *)city
                       state:(NSString *)state
                     country:(NSString *)country
                     weather:(JDCWeather *)weather
                   pollution:(JDCPollution *)pollution;


@end

// Add initializer for dictionary in extension
@interface JDCCityAirQuality (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end

NS_ASSUME_NONNULL_END
