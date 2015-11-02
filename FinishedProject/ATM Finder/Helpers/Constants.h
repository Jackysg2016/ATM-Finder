//
//  Constants.h
//  ATM Finder
//
//  Created by Archibald on 9/22/15.
//  Copyright © 2015 Buy n Large. All rights reserved.
//

#import <Foundation/Foundation.h>

// FOURSQUARE
#define SERVICE_HOST     @"https://api.foursquare.com/v2/venues/search?client_id=%@&client_secret=%@&v=20130815&ll=%.2f,%.2f&query=atm"
#define CLIENT_ID        @"PWS55XITBPEMFL041SC5BC1YVFABXGL5KRHFVOHZ0PDXW5WY"
#define CLIENT_SECRET    @"X5RA0VO1FK0F0DYR54ZLRBIB33TOOJ2JGGMEGY2PFBMJGOGK"


// UICOLOR FROM RGB
#define UIColorFromRGB(rgbValue) \
            UIColorFromRGBwithAlpha(rgbValue,1.0)

#define UIColorFromRGBwithAlpha(rgbValue,alphaValue) \
            [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                            green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
                             blue:((float)(rgbValue & 0xFF))/255.0 \
                            alpha:alphaValue]


// ATM RGB COLORS
#define RGB_RED          0xD0021B
#define RGB_GRAY         0xC7C7C7


// FONTS
#define FONT_HELVETICA_REGULAR          @"HelveticaNeue"
#define FONT_HELVETICA_MEDIUM           @"HelveticaNeue-Medium"
#define FONT_HELVETICA_LIGHT            @"HelveticaNeue-Light"


// OTHER VALUES
#define ONE_MILE @1609344


@interface Constants : NSObject

@end
