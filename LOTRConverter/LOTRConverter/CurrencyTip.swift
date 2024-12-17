//
//  CurrencyTip.swift
//  LOTRConverter
//
//  Created by Sushant Dhakal on 2024-12-16.
//

import TipKit

struct CurrencyTip: Tip {
    
    var title: Text = Text("Change Currency")
    
    var message: Text? = Text("Tap on left or right to change the currency")
    
    var image: Image? = Image (systemName: "hand.tap.fill")
    
}
