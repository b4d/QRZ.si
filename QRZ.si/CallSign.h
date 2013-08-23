//
//  CallSign.h
//  QRZ.si
//
//  Created by Deni Bacic on 22. 01. 13.
//  Copyright (c) 2013 Deni Bacic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CallSign : NSObject {

}

@property (nonatomic, readwrite) NSInteger ID;
@property (nonatomic, retain) NSString *Call;
@property (nonatomic, retain) NSString *Img;
@property (nonatomic, retain) NSString *Name;
@property (nonatomic, retain) NSString *Address;
@property (nonatomic, retain) NSString *Postal;
@property (nonatomic, retain) NSString *Email;
@property (nonatomic, retain) NSString *Web;
@property (nonatomic, retain) NSString *RadioClub;
@property (nonatomic, retain) NSString *Locator;
@property (nonatomic, retain) NSString *QSL;


@end

/*
<Call>s55db</Call>
<Img>http://url_do_slike</Img>
<Name>Deni Bacic</Name>
<Address>Podgrad 3i</Address>
<Postal>6244 Podgrad</Postal>
<Email>baccic@gmail.com</Email>
<Web>http://b4d.sablun.org</Web>
<RadioClub>RK Sneznik - S59DGO</RadioClub>
<Locator>JN75BM</Locator>
<QSL>Biro</QSL>

*/