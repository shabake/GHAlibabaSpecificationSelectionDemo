#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "PPBadgeLabel.h"
#import "PPBadgeView.h"
#import "UIBarButtonItem+PPBadgeView.h"
#import "UITabBarItem+PPBadgeView.h"
#import "UIView+PPBadgeView.h"

FOUNDATION_EXPORT double PPBadgeViewVersionNumber;
FOUNDATION_EXPORT const unsigned char PPBadgeViewVersionString[];

