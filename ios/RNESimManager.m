#import "RNESimManager.h"
@import CoreTelephony;

@implementation RNESimManager

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(isEsimSupported:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    
    if (@available(iOS 12.0, *)) {
        CTCellularPlanProvisioning *plan = [[CTCellularPlanProvisioning alloc] init];
        resolve(@(plan.supportsCellularPlan));
    } else {
        NSError *error = [NSError errorWithDomain:@"react.native.esim.native.module" code:1 userInfo:nil];
        reject(@"iOS 12 api availability", @"This functionality is not supported before iOS 12.0", error);
    }
}

RCT_EXPORT_METHOD(setupEsim:(NSDictionary *)config
                  promiseWithResolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {
    
    if (@available(iOS 12.0, *)) {
        CTCellularPlanProvisioning *plan = [[CTCellularPlanProvisioning alloc] init];
        
        if (plan.supportsCellularPlan != YES) {
            NSError *error = [NSError errorWithDomain:@"react.native.esim.native.module" code:2 userInfo:nil];
            reject(@"Doesn't support cellular plan", @"This functionality is not supported on this device", error);
        } else {
            CTCellularPlanProvisioningRequest *request = [[CTCellularPlanProvisioningRequest alloc] init];
            request.OID = config[@"oid"];
            request.EID = config[@"eid"];
            request.ICCID = config[@"iccid"];
            request.address = config[@"address"];
            request.matchingID = config[@"matchingId"];
            request.confirmationCode = config[@"confirmationCode"];
            
            // The user may send your app to the background prior to finishing the eSIM installation. To ensure your app has an opportunity to execute the completion handler and get the installation result, perform the eSIM installation as a background task. To do so, call beginBackgroundTask(expirationHandler:) prior to calling addPlan(with:completionHandler:), then call endBackgroundTask(_:) inside the completion handler.
            UIBackgroundTaskIdentifier backgroundTaskIdentifier = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{}];
            
            [plan addPlanWith:request completionHandler:^(CTCellularPlanProvisioningAddPlanResult result) {
                resolve(@(result));
                [[UIApplication sharedApplication] endBackgroundTask:backgroundTaskIdentifier];
            }];
        }
        
    } else {
        NSError *error = [NSError errorWithDomain:@"react.native.esim.native.module" code:1 userInfo:nil];
        reject(@"iOS 12 api availability", @"This functionality is not supported before iOS 12.0", error);
    }
}

@end
