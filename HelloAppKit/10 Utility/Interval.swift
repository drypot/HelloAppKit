//
//  Interval.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 10/2/24.
//

import Foundation

func interval(code: () -> Void) -> Double {

    let start = DispatchTime.now()

    code()

    let end = DispatchTime.now()

    let nanoseconds = end.uptimeNanoseconds - start.uptimeNanoseconds
    let seconds = Double(nanoseconds) / 1_000_000_000  // 초 단위로 변환

    return seconds
}
