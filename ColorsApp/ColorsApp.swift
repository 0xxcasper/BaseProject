//
//  ColorsApp.swift
//  TMD
//
//  Created by iMac Flix on Jun/24/2019.
//  Copyright © 2019 ITP Vietnam. All rights reserved.
//

import UIKit

extension UIColor {
   
    static var colorWhite = UIColor.color(0xffffff)
    static var colorBlack = UIColor.color(0x000000)
    
    static var colorText_detail         =  UIColor.color(0x858A8D)
    static var colorText_Title          =  UIColor.color(0x202427)
    static var colorBackground          =  UIColor.color(0xFFFFFF)
    static var colorHomeBackground      =  UIColor.color(0xF6F6F8)
    static var colorRedNotify           =  UIColor.color(0xFB0108)
    static var colorLine                =  UIColor.color(0xD7D7D7)
    static var colorSelect_Cell         =  UIColor.color(0xFFE9E9)
    static var color_lightBlue          =  UIColor.color(0xC2D7FF)
    static var colorMesage_background   =  UIColor.color(0xF5F5F5)
    
    static var colorLine_light          =  UIColor.color(0xE7E7E7)
    static var colorText_blackThin      =  UIColor.color(0x252525)
    static var color_gray_light         =  UIColor.color(0xF1F2F2)
    static var color_title_carCompare   =  UIColor.color(0x414042)
    static var color_background_points  =  UIColor.color(0xF3F4FA)
    static var color_gray_text          =  UIColor.color(0x555555)
    static var color_gray_background    =  UIColor.color(0xE6E6E6)
    static var color_blue_sky           =  UIColor.color(0x2C68D7)
    static var color_blue_background    =  UIColor.color(0xE5F5FF)
    static var color_blue_point         =  UIColor.color(0x356ED5)
    static var color_red_shadow         =  UIColor.color(0xFFD8DA)
    static var color_gray_heavy_text    =  UIColor.color(0x72797B)
    
    //RANK-TEXT COLOR
        //***Rank COMMON
    static var color_text_rank_common                   =  UIColor.color(0x61422C)
    static var color_text_rank_common_shadow            =  UIColor.color(0xD8B493)
    static var color_top_gradient_rank_common           =  UIColor.color(0xD7AF8E)
    static var color_bot_gradient_rank_common           =  UIColor.color(0x825837)

        //***Rank SILVER
    static var color_text_rank_silver                   =  UIColor.color(0x737475)
    static var color_text_rank_silver_shadow            =  UIColor.color(0xE8E8E8)
    static var color_top_gradient_rank_silver           =  UIColor.color(0xAAB8BB)
    static var color_bot_gradient_rank_silver           =  UIColor.color(0x535F64)
    
        //***Rank GOLD
    static var color_text_rank_gold                     =  UIColor.color(0x9B772B)
    static var color_text_rank_gold_shadow              =  UIColor.color(0xFFFBEC)
    static var color_top_gradient_rank_gold             =  UIColor.color(0xFFEFB2)
    static var color_bot_gradient_rank_gold             =  UIColor.color(0xF6B004)
    
        //***Rank PLATINUM
    static var color_text_rank_platinum                 =  UIColor.color(0xE6ECEE)
    static var color_text_rank_platinum_shadow          =  UIColor.color(0x373B3E)
    static var color_top_gradient_platinum              =  UIColor.color(0x8E949D)
    static var color_bot_gradient_platinum              =  UIColor.color(0x454A50)
    
        //***Rank DIAMOND
    static var color_text_rank_diamond                  =  UIColor.color(0x72797B)
    static var color_text_rank_diamond_shadow           =  UIColor.color(0xFFFFFF)
    static var color_chart_rank_diamond                 =  UIColor.color(0xBDEBFF)
    static var color_top_gradient_rank_diamond          =  UIColor.color(0xAAEAFE)
    static var color_bot_gradient_rank_diamond          =  UIColor.color(0xBEEBFF)
    
    static var color_chart_background                   =  UIColor.color(0xE0E0E0)
    //
    
    static var color_icon   =  UIColor.color(0x888D90)

    //calendar
    static var colorText_date_calendar  =  UIColor.color(0x656A6D)
    static var colorText_today_calendar =  UIColor.color(0xF42B22)
    static var colorBackground_today_calendar = UIColor.color(0xFFF1F1)
    static var colorText_date_below_calendar  = UIColor.color(0x5891FB)
    
    
    static var colorText_deep_green  = UIColor.color(0x088038)
}

extension UIColor {
    static func color(_ hex: Int, alpha: CGFloat = 1.0) -> UIColor {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0xFF)) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
