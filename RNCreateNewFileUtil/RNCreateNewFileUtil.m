//
//  RNCreateNewFileUtil.m
//  RNCreateNewFileUtil
//
//  Created by Ross Haker on 8/28/15.
//  Copyright (c) 2015 Facebook. All rights reserved.
//

#import "RNCreateNewFileUtil.h"

@implementation RNCreateNewFileUtil

// Expose this module to the React Native bridge
RCT_EXPORT_MODULE()

// Persist data
RCT_EXPORT_METHOD(createFile:(NSString *)fileName
                  errorCallback:(RCTResponseSenderBlock)failureCallback
                  callback:(RCTResponseSenderBlock)successCallback) {
    
    // Validate the file name has positive length
    if ([fileName length] < 1) {
       
        // Show failure message
        NSDictionary *resultsDict = @{
                                      @"success" : @NO,
                                      @"errMsg"  : @"Your file does not have a name."
                                      };
        
        // Execute the JavaScript failure callback handler
        failureCallback(@[resultsDict]);
        return;
        
    }
    
    // Validate the file name extension
    NSRange isRange = [fileName rangeOfString:@"." options:NSCaseInsensitiveSearch];
    
    // check if the file is hidden (. extension only)
    if(isRange.location == 0) {
        
        // Show failure message
        NSDictionary *resultsDict = @{
                                      @"success" : @NO,
                                      @"errMsg"  : @"Your file does not have a valid extension."
                                      };
        
        // Execute the JavaScript failure callback handler
        failureCallback(@[resultsDict]);
        return;
        
    } else {
        
        if(isRange.location == NSNotFound) {

            // Show failure message
            NSDictionary *resultsDict = @{
                                          @"success" : @NO,
                                          @"errMsg"  : @"Your file does not have a valid extension."
                                          };
            
            // Execute the JavaScript failure callback handler
            failureCallback(@[resultsDict]);
            return;
            
        }
    }
    
    // Initialize FileManager to check if file already exists
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // Set an array of directory paths to get the app documents directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    // Set the app documents directory
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    // Set the file path
    NSString *pathForFile = [NSString stringWithFormat:@"%@/%@", documentsDirectory, fileName];
    
    // Create file only if it does not exist already
    if ([fileManager fileExistsAtPath:pathForFile]){

        // Show failure message
        NSDictionary *resultsDict = @{
                                      @"success" : @NO,
                                      @"errMsg"  : @"This file already exists."
                                      };
        
        // Execute the JavaScript failure callback handler
        failureCallback(@[resultsDict]);
        return;
        
    }
    
    // Initialize an NSError variable
    NSError *writeError;
    
    // Initialize null contents to create a blank file
    NSString *contents = @"";
    
    // Write the file to disk
    [contents writeToFile : pathForFile
               atomically : NO
               encoding   : NSStringEncodingConversionAllowLossy
               error      : &writeError];
    
    // Check that the file was created without errors
    if (writeError) {
        
        // Detail the error
        NSDictionary *resultsDict = @{
                                      @"success" : @NO,
                                      @"errMsg"  : [writeError localizedDescription]
                                      };
        
        // Execute the JavaScript failure callback handler
        failureCallback(@[resultsDict]);
        
    } else {
        
        // Success - blank file was created
        NSDictionary *resultsDict = @{
                                      @"success" : @YES
                                      };
        
        // Call the JavaScript sucess handler
        successCallback(@[resultsDict]);
    }
    
}

@end

