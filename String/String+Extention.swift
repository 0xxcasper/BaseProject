//
//  String+Extention.swift
//  TextToSpeak
//
//  Created by admin on 30/12/2019.
//  Copyright © 2019 SangNX. All rights reserved.
//

import Foundation
import AVFoundation

extension String
{
    func configAVSpeechUtterance() -> AVSpeechUtterance {
        let utterance = AVSpeechUtterance(string: self)
        if let languageCode = UserDefaultHelper.shared.voiceCode {
            utterance.voice = AVSpeechSynthesisVoice(identifier: languageCode)
        } else {
            utterance.voice = AVSpeechSynthesisVoice(identifier: AVSpeechSynthesisVoice.currentLanguageCode())
        }
        if let rate = UserDefaultHelper.shared.rate {
            utterance.rate = rate
        }
        if let pitch = UserDefaultHelper.shared.pitch {
            utterance.pitchMultiplier = pitch
        }
        return utterance
    }
    
    var wordCount: Int {
        let regex = try? NSRegularExpression(pattern: "\\w+")
        return regex?.numberOfMatches(in: self, range: NSRange(location: 0, length: self.utf16.count)) ?? 0
    }
    
//    let phrase = "How much wood would a woodchuck chuck if a woodchuck would chuck wood?"
//    print(phrase.replacingOccurrences(of: "would", with: "should", count: 1))
    func replacingOccurrences(of search: String, with replacement: String, count maxReplacements: Int) -> String {
        var count = 0
        var returnValue = self

        while let range = returnValue.range(of: search) {
            returnValue = returnValue.replacingCharacters(in: range, with: replacement)
            count += 1

            // exit as soon as we've made all replacements
            if count == maxReplacements {
                return returnValue
            }
        }
        return returnValue
    }
    
//    let url = "www.hackingwithswift.com"
//    let fullURL = url.withPrefix("https://")
    func withPrefix(_ prefix: String) -> String {
        if self.hasPrefix(prefix) { return self }
        return "\(prefix)\(self)"
    }
}
