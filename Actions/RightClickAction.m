/**
 * Copyright (c) 2007-2018, Carsten Blüm <carsten@bluem.net>
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * - Redistributions of source code must retain the above copyright notice, this
 *   list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright notice, this
 *   list of conditions and the following disclaimer in the documentation and/or
 *   other materials provided with the distribution.
 * - Neither the name of Carsten Blüm nor the names of his contributors may be
 *   used to endorse or promote products derived from this software without specific
 *   prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "RightClickAction.h"
#include <unistd.h>

@implementation RightClickAction

#pragma mark - ActionProtocol

+ (NSString *)commandShortcut {
    return @"rc";
}

+ (NSString *)commandDescription {
    return @"  rc:x,y  Will RIGHT-CLICK at the point with the given coordinates.\n"
    "          Example: “rc:12,34” will right-click at the point with x coordinate\n"
    "          12 and y coordinate 34. Instead of x and y values, you may\n"
    "          also use “.”, which means: the current position. Using “.” is\n"
    "          equivalent to using relative zero values “c:+0,+0”.";
}

#pragma mark - MouseBaseAction

- (NSString *)actionDescriptionString:(NSString *)locationDescription {
    return [NSString stringWithFormat:@"Right-click at %@", locationDescription];
}

- (void)performActionAtPoint:(CGPoint) p {
    // Right button down
    CGEventRef rightDown = CGEventCreateMouseEvent(NULL, kCGEventRightMouseDown, p, kCGMouseButtonRight);
    CGEventPost(kCGHIDEventTap, rightDown);
    CFRelease(rightDown);

    usleep(15000); // Improve reliability

    // Right button up
    CGEventRef rightUp = CGEventCreateMouseEvent(NULL, kCGEventRightMouseUp, p, kCGMouseButtonRight);
    CGEventPost(kCGHIDEventTap, rightUp);
    CFRelease(rightUp);
}

@end
