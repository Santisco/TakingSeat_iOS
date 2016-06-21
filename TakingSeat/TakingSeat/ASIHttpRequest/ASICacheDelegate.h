//
//  ASICacheDelegate.h
//  Part of ASIHTTPRequest -> http://allseeing-i.com/ASIHTTPRequest
//
//  Created by Ben Copsey on 01/05/2010.
//  Copyright 2010 All-Seeing Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ASIHTTPRequest;

// Cache policies control the behaviour of a cache and how requests use the cache
// When setting a cache policy, you can use a combination of these values as a bitmask
// For example: [request setCachePolicy:ASIAskServerIfModifiedCachePolicy|ASIFallbackToCacheIfLoadFailsCachePolicy|ASIDoNotWriteToCacheCachePolicy];
// Note that some of the behaviours below are mutally exclusive - you cannot combine ASIAskServerIfModifiedWhenStaleCachePolicy and ASIAskServerIfModifiedCachePolicy, for example.
typedef enum _ASICachePolicy {

       
    
	ASIUseDefaultCachePolicy = 0,//默认情况下的缓存策略(它不能与其它策略组合使用)
	ASIDoNotReadFromCacheCachePolicy = 1,//当前请求不读取缓存数据。
	ASIDoNotWriteToCacheCachePolicy = 2,//当前请求不写缓存数据。
    
	ASIAskServerIfModifiedWhenStaleCachePolicy = 4,//默认缓存行为，request会先判断是否存在缓存数据，如果没有再进行网络请求。 如果存在缓存数据，并且数据没有过期，则使用缓存。如果存在缓存数据，但已经过期，request会先进行网络请求，判断服务器版本与本地版本是否一样，如果一样，则使用缓存。如果服务器有新版本，会进行网络请求，并更新本地缓存。（使用GET请求时有效）
    
	ASIAskServerIfModifiedCachePolicy = 8,//每次请求都会 去服务器判断是否有更新。（使用GET请求时有效）
    
	ASIOnlyLoadIfNotCachedCachePolicy = 16,//只要有缓存，就读取缓存数据而不管数据是否过期。直到请求的数据不在缓冲中时，才去服务器获取。
    
	ASIDontLoadCachePolicy = 32,//只要有缓存，就读取缓存数据而不管数据是否过期。如果缓存中没有数据，则停止，不向服务器请求。
    
	ASIFallbackToCacheIfLoadFailsCachePolicy = 64//这个选项经常被用来与其它选项组合使用。请求失败时，使用本地缓存数据，如果使用本地缓冲，请求会成功不会引发错误（这个在处理异常时非常有用）
} ASICachePolicy;

// Cache storage policies control whether cached data persists between application launches (ASICachePermanentlyCacheStoragePolicy) or not (ASICacheForSessionDurationCacheStoragePolicy)
// Calling [ASIHTTPRequest clearSession] will remove any data stored using ASICacheForSessionDurationCacheStoragePolicy
typedef enum _ASICacheStoragePolicy {
	ASICacheForSessionDurationCacheStoragePolicy = 0,
	ASICachePermanentlyCacheStoragePolicy = 1
} ASICacheStoragePolicy;


@protocol ASICacheDelegate <NSObject>

@required

// Should return the cache policy that will be used when requests have their cache policy set to ASIUseDefaultCachePolicy
- (ASICachePolicy)defaultCachePolicy;

// Returns the date a cached response should expire on. Pass a non-zero max age to specify a custom date.
- (NSDate *)expiryDateForRequest:(ASIHTTPRequest *)request maxAge:(NSTimeInterval)maxAge;

// Updates cached response headers with a new expiry date. Pass a non-zero max age to specify a custom date.
- (void)updateExpiryForRequest:(ASIHTTPRequest *)request maxAge:(NSTimeInterval)maxAge;

// Looks at the request's cache policy and any cached headers to determine if the cache data is still valid
- (BOOL)canUseCachedDataForRequest:(ASIHTTPRequest *)request;

// Removes cached data for a particular request
- (void)removeCachedDataForRequest:(ASIHTTPRequest *)request;

// Should return YES if the cache considers its cached response current for the request
// Should return NO is the data is not cached, or (for example) if the cached headers state the request should have expired
- (BOOL)isCachedDataCurrentForRequest:(ASIHTTPRequest *)request;

// Should store the response for the passed request in the cache
// When a non-zero maxAge is passed, it should be used as the expiry time for the cached response
- (void)storeResponseForRequest:(ASIHTTPRequest *)request maxAge:(NSTimeInterval)maxAge;

// Removes cached data for a particular url
- (void)removeCachedDataForURL:(NSURL *)url;

// Should return an NSDictionary of cached headers for the passed URL, if it is stored in the cache
- (NSDictionary *)cachedResponseHeadersForURL:(NSURL *)url;

// Should return the cached body of a response for the passed URL, if it is stored in the cache
- (NSData *)cachedResponseDataForURL:(NSURL *)url;

// Returns a path to the cached response data, if it exists
- (NSString *)pathToCachedResponseDataForURL:(NSURL *)url;

// Returns a path to the cached response headers, if they url
- (NSString *)pathToCachedResponseHeadersForURL:(NSURL *)url;

// Returns the location to use to store cached response headers for a particular request
- (NSString *)pathToStoreCachedResponseHeadersForRequest:(ASIHTTPRequest *)request;

// Returns the location to use to store a cached response body for a particular request
- (NSString *)pathToStoreCachedResponseDataForRequest:(ASIHTTPRequest *)request;

// Clear cached data stored for the passed storage policy
- (void)clearCachedResponsesForStoragePolicy:(ASICacheStoragePolicy)cachePolicy;

@end
