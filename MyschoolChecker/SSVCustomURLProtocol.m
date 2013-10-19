//
//  SSVCustomURLProtocol.m
//  MyschoolChecker
//
//  Created by Kári Tristan Helgason on 23.9.2013.
//  Copyright (c) 2013 Kári Tristan Helgason. All rights reserved.
//

#import "SSVCustomURLProtocol.h"

@implementation SSVCustomURLProtocol

static NSString *AUTHORIZED_REQUEST_HEADER = @"X-AUTHORIZED";

+(BOOL) canInitWithRequest:(NSMutableURLRequest *)request
{
    // check if the request is one you want to authorize
    BOOL canInit = (![request.URL.scheme isEqualToString:@"file"] && [request valueForHTTPHeaderField:[AUTHORIZED_REQUEST_HEADER stringByAppendingString:[request.URL absoluteString]]] == nil);
    return canInit;
}

-(id) initWithRequest:(NSURLRequest *)request cachedResponse:(NSCachedURLResponse *)cachedResponse client:(id<NSURLProtocolClient>)client
{
    _customRequest = [request mutableCopy];
    [_customRequest setValue:@"" forHTTPHeaderField:[AUTHORIZED_REQUEST_HEADER stringByAppendingString:[request.URL absoluteString]]];
    
    self = [super initWithRequest:_customRequest cachedResponse:cachedResponse client:client];
    
    return self;
}

+(NSURLRequest *) canonicalRequestForRequest:(NSURLRequest *)request
{
    NSMutableURLRequest *customRequest = [request mutableCopy];
    [customRequest setValue:@"" forHTTPHeaderField:[AUTHORIZED_REQUEST_HEADER stringByAppendingString:[request.URL absoluteString]]];

    NSString* basicAuthentication = [[NSUserDefaults standardUserDefaults] valueForKey:@"Authentication"];
    
    [customRequest setValue:basicAuthentication forHTTPHeaderField:@"Authorization"];
    
    return customRequest;
}

- (void) startLoading
{
    NSString* basicAuthentication = [[NSUserDefaults standardUserDefaults] valueForKey:@"Authentication"];
    
    [_customRequest setValue:basicAuthentication forHTTPHeaderField:@"Authorization"];
    _connection = [NSURLConnection connectionWithRequest:_customRequest delegate:self];
    // Fixes stupid log message
    [self.client URLProtocol:self didReceiveResponse:[[NSURLResponse alloc] init] cacheStoragePolicy:NSURLCacheStorageNotAllowed];
}

- (void) stopLoading
{
    [_connection cancel];
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [[self client] URLProtocol:self didLoadData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [[self client] URLProtocol:self didFailWithError:error];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [[self client] URLProtocolDidFinishLoading:self];
}

-(NSURLRequest *) connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse
{
    // This protocol forgets to store cookies, so do it manually
    if([redirectResponse isKindOfClass:[NSHTTPURLResponse class]])
    {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:[NSHTTPCookie cookiesWithResponseHeaderFields:[(NSHTTPURLResponse*)redirectResponse allHeaderFields] forURL:[redirectResponse URL]] forURL:[redirectResponse URL] mainDocumentURL:[request mainDocumentURL]];
    }
    
    // copy all headers to the new request
    NSMutableURLRequest *redirect = [request mutableCopy];
    for (NSString *header in [request allHTTPHeaderFields])
    {
        [redirect setValue:[[request allHTTPHeaderFields] objectForKey:header] forHTTPHeaderField:header];
    }
    
    return redirect;
}



@end
