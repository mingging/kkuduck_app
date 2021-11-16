//
//  getFile.swift
//  kkuduck
//
//  Created by Khyeji on 2021/10/26.
//

import Foundation

func getFileName(_ fileName: String) -> String {
    
    let documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let docPath = documentDir[0] as NSString
    let fullPath = docPath.appendingPathComponent(fileName)
    
    return fullPath
}
