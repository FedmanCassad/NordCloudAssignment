//
//  UISheetPresentationControllerDetent+Private.h
//  NordCloudTestAssignment
//
//  Created by Vladimir Banushkin on 12.05.2022.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UISheetPresentationControllerDetent (Private)
+ (UISheetPresentationControllerDetent *)_detentWithIdentifier:(NSString *)identifier constant:(CGFloat)constant;
@end

NS_ASSUME_NONNULL_END
