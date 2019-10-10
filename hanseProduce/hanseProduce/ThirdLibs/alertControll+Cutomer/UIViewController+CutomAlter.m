//
//  UIViewController+CutomAlter.m
//  BaseProject
//
//  Created by 郑桂杰 on 2019/9/25.
//  Copyright © 2019 Sunsgne. All rights reserved.
//

#import "UIViewController+CutomAlter.h"
#import "AAPLCustomPresentationController.h"

@implementation UIViewController (CutomAlter)

-(void)customCenterAlterViewController: (nonnull UIViewController *)destination {
    if (!destination) {
        return;
    }
    AAPLCustomPresentationController *presentationController NS_VALID_UNTIL_END_OF_SCOPE;
    
     presentationController = [[AAPLCustomPresentationController alloc] initWithPresentedViewController:destination presentingViewController:self];
     destination.transitioningDelegate = presentationController;
     [self presentViewController:destination animated:YES completion:NULL];
}

-(void)customCenterAlterViewController:(UIViewController *)destination touchedCoverDismiss:(BOOL)touchedDismiss {
    if (!destination) {
        return;
    }
    AAPLCustomPresentationController *presentationController NS_VALID_UNTIL_END_OF_SCOPE;
    
     presentationController = [[AAPLCustomPresentationController alloc] initWithPresentedViewController:destination presentingViewController:self];
    presentationController.touchedDismissed = touchedDismiss;
     destination.transitioningDelegate = presentationController;
     [self presentViewController:destination animated:YES completion:NULL];
}

@end
