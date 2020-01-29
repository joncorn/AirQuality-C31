//
//  JDCWeather.h
//  AirQuality-C31
//
//  Created by Jon Corn on 1/29/20.
//  Copyright © 2020 Jon Corn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JDCWeather : NSObject

// Properties for weather model object
@property (nonatomic, readonly) NSInteger temperature;
@property (nonatomic, readonly) NSInteger humidity;
@property (nonatomic, readonly) NSInteger windSpeed;
// Initializer for weather model object
- (instancetype)initWithWeatherInfo:(NSInteger)temperature
                           humidity:(NSInteger)humidity
                          windSpeed:(NSInteger)windSpeed;

@end

// Initializer for dict in an extension JSONConvertable
@interface JDCWeather (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end

NS_ASSUME_NONNULL_END
