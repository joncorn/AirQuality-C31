//
//  JDCCityAirQualityController.m
//  AirQuality-C31
//
//  Created by Jon Corn on 1/29/20.
//  Copyright © 2020 Jon Corn. All rights reserved.
//░░░░░░░░▀████▀▄▄░░░░░░░░░░░░░░▄█
//░░░░░░░░░░█▀░░░░▀▀▄▄▄▄▄░░░░▄▄▀▀█
//░░▄░░░░░░░░█░░░░░░░░░░▀▀▀▀▄░░▄▀
//░▄▀░▀▄░░░░░░▀▄░░░░░░░░░░░░░░▀▄▀
//▄▀░░░░█░░░░░█▀░░░▄█▀▄░░░░░░▄█
//▀▄░░░░░▀▄░░█░░░░░▀██▀░░░░░██▄█
//░▀▄░░░░▄▀░█░░░▄██▄░░░▄░░▄░░▀▀░█
//░░█░░▄▀░░█░░░░▀██▀░░░░▀▀░▀▀░░▄▀
//░█░░░█░░█░░░░░░▄▄░░░░░░░░░░░▄▀

#import "JDCCityAirQualityController.h"
#import "JDCCityAirQuality.h"
#import "JDCWeather.h"
#import "JDCPollution.h"

// String helpers
static NSString *const baseURLString = @"https://api.airvisual.com/";
static NSString *const versionComponent = @"v2";
static NSString *const countryComponent = @"countries";
static NSString *const stateComponent = @"states";
static NSString *const cityComponent = @"cities";
static NSString *const cityDetailsComponent = @"city";
static NSString *const apiKey = @"5f3cd124-bdc5-4762-bb71-b81df5566cec";

@implementation JDCCityAirQualityController

+ (void)fetchSupportedCountries:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    // Build URL
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *versionURL = [baseURL URLByAppendingPathComponent:versionComponent];
    NSURL *countryURL = [versionURL URLByAppendingPathComponent:countryComponent];
    NSURLComponents *components = [NSURLComponents componentsWithURL:countryURL resolvingAgainstBaseURL:true];
    NSURLQueryItem *apiQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:apiKey];
    components.queryItems = @[apiQuery];
    NSURL *finalURL = components.URL;
    // Data task
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"Error: %@", error);
            return completion([NSArray new]);
        }
        
        if (!data)
        {
            NSLog(@"No data");
            return completion([NSArray new]);
        }
        NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error: &error];
        NSDictionary *dataDictionary = topLevelDictionary[@"data"];
        NSMutableArray *countryArray = [NSMutableArray new];
        
        for (NSDictionary *country in dataDictionary)
        {
            [countryArray addObject:country[@"country"]];
        }
        return completion(countryArray);
        
    }]resume];
}

+ (void)fetchSupportedStatesInCountry:(NSString *)country completion:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    // Build URL
    NSURL *baseURL = [[NSURL alloc] initWithString:baseURLString];
    NSURL *versionURL = [baseURL URLByAppendingPathComponent:versionComponent];
    NSURL *stateURL = [versionURL URLByAppendingPathComponent:stateComponent];
    NSURLComponents *components = [NSURLComponents componentsWithURL:stateURL resolvingAgainstBaseURL:true];
    NSURLQueryItem *apiQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:apiKey];
    NSURLQueryItem *countryQuery = [[NSURLQueryItem alloc] initWithName:@"country" value:country];
    components.queryItems = @[countryQuery, apiQuery];
    NSURL *finalURL = components.URL;
    // Data task
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"Error: %@", error);
            return completion([NSArray new]);
        }
        
        if (!data)
        {
            NSLog(@"No Data");
            return completion([NSArray new]);
        }
        NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSDictionary *dataDictionary = topLevelDictionary[@"data"];
        NSMutableArray *stateArray = [NSMutableArray new];
        for (NSDictionary *state in dataDictionary)
        {
            [stateArray addObject:state[@"state"]];
        }
        return completion(stateArray);
    }] resume];
}

+ (void)fetchSupportedCitiesInState:(NSString *)state country:(NSString *)country completion:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    // Build URL
    NSURL *baseURL = [[NSURL alloc] initWithString:baseURLString];
    NSURL *versionURL = [baseURL URLByAppendingPathComponent:versionComponent];
    NSURL *cityURL = [versionURL URLByAppendingPathComponent:cityComponent];
    NSURLComponents *components = [NSURLComponents componentsWithURL:cityURL resolvingAgainstBaseURL:true];
    NSURLQueryItem *countryQuery = [[NSURLQueryItem alloc] initWithName:@"country" value:country];
    NSURLQueryItem *stateQuery = [[NSURLQueryItem alloc] initWithName:@"state" value:state];
    NSURLQueryItem *apiQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:apiKey];
    components.queryItems = @[stateQuery, countryQuery, apiQuery];
    NSURL *finalURL = components.URL;
    // Data task
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"Error: %@", error);
            return completion([NSArray new]);
        }
        
        if (!data)
        {
            NSLog(@"No Data");
            return completion([NSArray new]);
        }
        NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSDictionary *dataDictionary = topLevelDictionary[@"data"];
        NSMutableArray *cityArray = [NSMutableArray new];
        for (NSDictionary *city in dataDictionary)
        {
            [cityArray addObject:city[@"city"]];
        }
    }] resume];
}

+ (void)fetchDataForCity:(NSString *)city state:(NSString *)state country:(NSString *)country completion:(void (^)(JDCCityAirQuality * _Nullable))completion
{
    // Build URL
    NSURL *baseURL = [[NSURL alloc] initWithString:baseURLString];
    NSURL *versionURL = [baseURL URLByAppendingPathComponent:versionComponent];
    NSURL *cityDetailURL = [versionURL URLByAppendingPathComponent:cityDetailsComponent];
    NSURLComponents *components = [NSURLComponents componentsWithURL:cityDetailURL resolvingAgainstBaseURL:true];
    NSURLQueryItem *cityQuery = [[NSURLQueryItem alloc] initWithName:@"city" value:city];
    NSURLQueryItem *stateQuery = [[NSURLQueryItem alloc] initWithName:@"state" value:state];
    NSURLQueryItem *countryQuery = [[NSURLQueryItem alloc] initWithName:@"country" value:country];
    NSURLQueryItem *apiQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:apiKey];
    components.queryItems = @[cityQuery, stateQuery, countryQuery, apiQuery];
    NSURL *finalURL = components.URL;
    // Data task
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
               {
                   NSLog(@"Error: %@", error);
                   return completion([JDCCityAirQuality new]);
               }
               
               if (!data)
               {
                   NSLog(@"No Data");
                   return completion([JDCCityAirQuality new]);
               }
    }] resume];
}

@end
