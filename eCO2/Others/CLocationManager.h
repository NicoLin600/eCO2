//
//  CLocationManager.h
//  Carbon
//
//  Created by Nic on 28/09/2019.
//  Copyright © 2019 NicLin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class CLocationManager;

typedef enum {
    PSLocationManagerGPSSignalStrengthInvalid = 0
    , PSLocationManagerGPSSignalStrengthWeak
    , PSLocationManagerGPSSignalStrengthStrong
} CLocationManagerGPSSignalStrength;

@protocol CLocationManagerDelegate <NSObject>

@optional
- (void)locationManager:(CLocationManager *)locationManager signalStrengthChanged:(CLocationManagerGPSSignalStrength)signalStrength;
- (void)locationManagerSignalConsistentlyWeak:(CLocationManager *)locationManager;
- (void)locationManager:(CLocationManager *)locationManager distanceUpdated:(CLLocationDistance)distance;
- (void)locationManager:(CLocationManager *)locationManager waypoint:(CLLocation *)waypoint calculatedSpeed:(double)calculatedSpeed;
- (void)locationManager:(CLocationManager *)locationManager error:(NSError *)errorCLocationManager;
- (void)locationManager:(CLocationManager *)locationManager debugText:(NSString *)text;

@end

@interface CLocationManager : NSObject <CLLocationManagerDelegate>

@property (nonatomic, weak) id<CLocationManagerDelegate> delegate;
@property (nonatomic, readonly) CLocationManagerGPSSignalStrength signalStrength;
@property (nonatomic, readonly) CLLocationDistance totalDistance;
@property (nonatomic, readonly) NSTimeInterval totalSeconds;
@property (nonatomic, readonly) double currentSpeed;

+ (CLocationManager *)sharedLocationManager;

- (BOOL)prepLocationUpdates; // this must be called before startLocationUpdates (best to call it early so we can get an early lock on location)
- (BOOL)startLocationUpdates;
- (void)stopLocationUpdates;
- (void)resetLocationUpdates;

@end

