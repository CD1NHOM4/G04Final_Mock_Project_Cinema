//
//  Utils.swift
//  G04Final_Mock_Project_Cinema
//
//  Created by THANH on 5/20/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//

import Foundation
import UIKit
import CoreData

public class Util{
    
    static func getBookingTime() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let result = dateFormatter.string(from: date)
        return result
    }
    
    static func getDateTimeFromString(string: String, interval: Double) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        var date = dateFormatter.date(from: string)
        date?.addTimeInterval(interval)
        return date!
    }
    
    static func getDateFromString(releaseDate: String, interval: Double) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        var date = dateFormatter.date(from: releaseDate)
        date?.addTimeInterval(interval)
        return date!
    }
    
    static func getDate(interval: Double) -> String {
        var date = Date()
        date.addTimeInterval(interval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let result = dateFormatter.string(from: date)
        return result
    }
    
    func md5(_ string: String) -> String {
        
        let context = UnsafeMutablePointer<CC_MD5_CTX>.allocate(capacity: 1)
        var digest = Array<UInt8>(repeating:0, count:Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5_Init(context)
        CC_MD5_Update(context, string, CC_LONG(string.lengthOfBytes(using: String.Encoding.utf8)))
        CC_MD5_Final(&digest, context)
        context.deallocate(capacity: 1)
        var hexString = ""
        for byte in digest {
            hexString += String(format:"%02x", byte)
        }
        
        return hexString
    }
}
extension String {
    func md5() -> String! {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.deinitialize()
        
        return String(format: hash as String)
    }
}
