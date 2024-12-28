//
//  SubRunnerSample2Runner.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 12/28/24.
//

class SubRunnerSample2Runner: SubRunner {
    override func run() {
        let seconds = interval {
            subclasses(of: SubRunner.self).forEach { print($0.className()) }
        }
        print("\(seconds) seconds")
    }
}
