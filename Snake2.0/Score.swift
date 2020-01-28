//
//  Score.swift
//  Snake2.0
//
//  Created by Hector Barrios on 1/8/20.
//  Copyright © 2020 Barrios Programming. All rights reserved.
//

import Foundation

struct Score
{
    var score: Int
    var name: String
    var timestamp: TimeInterval
    
    static func tempScores() -> [Score]
    {
        var scores = [Score]()
        
        for value in 1...1000
        {
            let score = Score(score: value, name: "ABC", timestamp: Date().timeIntervalSince1970)
            scores.append(score)
        }
        return scores
    }
}
