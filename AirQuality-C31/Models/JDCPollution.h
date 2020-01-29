//
//  JDCPollution.h
//  AirQuality-C31
//
//  Created by Jon Corn on 1/29/20.
//  Copyright © 2020 Jon Corn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JDCPollution : NSObject

// Property for pollution model object
@property (nonatomic, readonly) NSInteger airQualityIndex;
// Initializer
- (instancetype)initWithInt:(NSInteger)aqi;

@end

// dict initializer in extension
@interface JDCPollution (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end

NS_ASSUME_NONNULL_END
