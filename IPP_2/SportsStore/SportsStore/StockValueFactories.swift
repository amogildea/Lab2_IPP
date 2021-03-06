//
//  StockValueFactories.swift
//  SportsStore
//
//  Created by Admin on 12/14/16.
//  Copyright © 2016 user. All rights reserved.
//

import Foundation

class StockTotalFactory {
    enum Currency {
        case USD
        case GBP
        case EUR
    }
    var formatter:StockValueFormatter?;
    var converter:StockValueConverter?;
    
    class func getFactory(curr:Currency) -> StockTotalFactory {
        if (curr == Currency.USD) {
            return DollarStockTotalFactory.sharedInstance;
        } else if (curr == Currency.GBP){
            return PoundStockTotalFactory.sharedInstance;
        } else {
            return EuroHandlerAdapter.sharedInstance;
        }
    }
}
private class DollarStockTotalFactory : StockTotalFactory {
    private override init() {
        super.init();
        formatter = DollarStockValueFormatter();
        converter = DollarStockValueConverter();
    }
    class var sharedInstance:StockTotalFactory {
        get {
            struct SingletonWrapper {
                static let singleton = DollarStockTotalFactory();
            }
            return SingletonWrapper.singleton;
        }
    }
}
private class PoundStockTotalFactory : StockTotalFactory {
    private override init() {
        super.init();
        
        formatter = PoundStockValueFormatter();
        converter = PoundStockValueConverter();
        
    }
    class var sharedInstance:StockTotalFactory {
        get {
            struct SingletonWrapper {
                static let singleton = PoundStockTotalFactory();
            }
            return SingletonWrapper.singleton;
        }
    }
}
class EuroHandlerAdapter : StockTotalFactory,
                        StockValueConverter,
                        StockValueFormatter {
    private let handler:EuroHandler;
    override init() {
        self.handler = EuroHandler();
        super.init();
        super.formatter = self;
        super.converter = self;
    }
    func formatTotal(total:Double) -> String {
        return handler.getDisplayString(amount: total);
    }
    func convertTotal(total:Double) -> Double {
        return handler.getCurrencyAmount(amount: total);
    }
    class var sharedInstance:EuroHandlerAdapter {
        get {
            struct SingletonWrapper {
                static let singleton = EuroHandlerAdapter();
            }
            return SingletonWrapper.singleton;
        }
    }
}
