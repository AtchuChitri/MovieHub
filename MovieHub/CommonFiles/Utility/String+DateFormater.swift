//
//  String+DateFormater.swift
//  MovieHub
//
//  Created by Atchu on 9/2/23.
//

import Foundation

extension String {
    func getDateString() -> String? {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMMM yyyy"
        
        if let date = dateFormatterGet.date(from: self) {
            let dateStr = dateFormatterPrint.string(from: date)
            return dateStr
        }
        return nil
    }
}
