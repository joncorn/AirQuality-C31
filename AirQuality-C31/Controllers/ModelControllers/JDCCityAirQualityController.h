//
//  JDCCityAirQualityController.h
//  AirQuality-C31
//
//  Created by Jon Corn on 1/29/20.
//  Copyright © 2020 Jon Corn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JDCCityAirQuality.h"

NS_ASSUME_NONNULL_BEGIN

// Declaring various network fetches
@interface JDCCityAirQualityController : NSObject

+ (void)fetchSupportedCountries:(void (^) (NSArray<NSString *> *_Nullable))completion;

+ (void)fetchSupportedStatesInCountry:(NSString *)country
                   completion:(void (^) (NSArray<NSString *> *_Nullable))completion;

+ (void)fetchSupportedCitiesInState:(NSString *)state
                            country:(NSString *)country
                         completion:(void (^) (NSArray<NSString *> *_Nullable))completion;

+ (void)fetchDataForCity:(NSString *)city
                   state:(NSString *)state
                 country:(NSString *)country
              completion:(void (^) (JDCCityAirQuality *))completion;

@end

NS_ASSUME_NONNULL_END
