//
//  Constants.swift
//  HydrationTracking_GOQii_AdityaGhadge
//
//  Created by Aditya on 29/06/24.
//

import Foundation

enum StringConstants: String {
    case title = "Hydration Tracking"
    case target = "Daily Target"
    case progress = "Daily Progress"
    case edit = "Edit"
    case submit = "Submit"
    case cancel = "CANCEL"
    case log = "LOG"
    case ml200 = "200 ml"
    case ml500 = "500 ml"
    case ml750 = "750 ml"
    case ml1000 = "1 Litre"
    case quickLog = "Quick Log"
    case done = "Done"
    case alertTitle = "Alert"
    case emptyFields = "Please fill both the fields"
    case invalidFields = "Entered fields are not valid"
    case milestoneAchieved = "Daily Milestone Acheived!"
}

enum ImageConstants: String {
    case img200 = "img200"
    case img500 = "img500"
    case img750 = "img750"
    case img1000 = "img1000"
    case bottle0 = "bottle0"
    case bottle200 = "bottle200"
    case bottle500 = "bottle500"
    case bottle750 = "bottle750"
    case bottle1000 = "bottle1000"
    case hurray = "hurray"
}

enum CellConstants: String {
    case setProgressCell = "SetProgressTableViewCell"
    case quickLogCell = "QuickLogTableViewCell"
}

enum NotificationNames: String {
    case updateSetProgress = "updateSetProgress"
}

enum FileConstants: String {
    case alertVC = "AlertViewController"
}
