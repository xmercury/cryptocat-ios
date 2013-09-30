//
//  XMPPMessage+Cryptocat.m
//  Cryptocat
//
//  Created by Thomas Balthazar on 26/09/13.
//  Copyright (c) 2013 Thomas Balthazar. All rights reserved.
//

#import "XMPPMessage+Cryptocat.h"
#import "XMPP.h"
#import "NSString+Cryptocat.h"

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation XMPPMessage (Cryptocat)

////////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)tb_isArchiveMessage {
  return [[self elementsForName:@"delay"] count] > 0;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)tb_isComposingMessage {
  return [[self elementForName:@"x"] elementForName:@"composing"]!=nil;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)tb_isPublicKeyMessage {
  NSDictionary *jsonData = [[self body] tb_JSONObject];
  return [[jsonData objectForKey:@"type"] isEqualToString:@"publicKey"];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)tb_isPublicKeyRequestMessage {
  NSDictionary *jsonData = [[self body] tb_JSONObject];
  return [[jsonData objectForKey:@"type"] isEqualToString:@"publicKeyRequest"];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)tb_publicKey {
  /*
  {
    "type":"publicKey",
    "text": {
      "iOSTestApp": {
        "message":"+kzVSOSVe9X3bt/QAH8YtRAgcLERpKZ0CKEpSPRI724="
      }
    }
  }
  */
  
  NSDictionary *jsonData = [[self body] tb_JSONObject];
  return [[[[jsonData objectForKey:@"text"] allValues] lastObject] objectForKey:@"message"];
}

@end