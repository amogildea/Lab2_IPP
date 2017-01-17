//
//  ViewController.swift
//  SportsStore
//
//  Created by user on 11/15/16.
//  Copyright © 2016 user. All rights reserved.
//

import UIKit

class ProductTableCell : UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var stockStepper: UIStepper!
    @IBOutlet weak var stockField: UITextField!
    //      var productId:Int?;
    var product:Product?;
}
//var handler = { (p:Product) in
//    print("Change: \(p.name) \(p.stockLevel) items in stock");
//};
class ViewController: UIViewController,UITableViewDataSource {
    @IBOutlet var totalStockLabel: UILabel!
    @IBOutlet var dataTableView: UITableView!
    var productStore = ProductDataStore();
//    let logger = Logger<Product>(callback: handler);
//    var products = [
//        Product(name:"Kayak", description:"A boat for one person",
//                category:"Watersports", price:275.0, stockLevel:10),
//        Product(name:"Lifejacket", description:"Protective and fashionable",
//                category:"Watersports", price:48.95, stockLevel:14),
//        Product(name:"Soccer Ball", description:"FIFA-approved size and weight",
//                category:"Soccer", price:19.5, stockLevel:32),
//        Product(name:"Corner Flags",
//                description:"Give your playing field a professional touch",
//                category:"Soccer", price:34.95, stockLevel:1),
//        Product(name:"Stadium", description:"Flat-packed 35,000-seat stadium",
//                category:"Soccer", price:79500.0, stockLevel:4),
//        Product(name:"Thinking Cap",
//                description:"Improve your brain efficiency by 75%",
//                category:"Chess", price:16.0, stockLevel:8),
//        Product(name:"Unsteady Chair",
//                description:"Secretly give your opponent a disadvantage",
//                category: "Chess", price: 29.95, stockLevel:3),
//        Product(name:"Human Chess Board",
//                description:"A fun game for the family", category:"Chess",
//                price:75.0, stockLevel:2),
//        Product(name:"Bling-Bling King",
//                description:"Gold-plated, diamond-studded King",
//                category:"Chess", price:1200.0, stockLevel:4)];
    
    //    var products = [
    //        ("Kayak", "A boat for one person", "Watersports", 275.0, 10),
    //        ("Lifejacket", "Protective and fashionable", "Watersports", 48.95, 14),
    //        ("Soccer Ball", "FIFA-approved size and weight", "Soccer", 19.5, 32),
    //        ("Corner Flags", "Give your playing field a professional touch",
    //         "Soccer", 34.95, 1),
    //        ("Stadium", "Flat-packed 35,000-seat stadium", "Soccer", 79500.0, 4),
    //        ("Thinking Cap", "Improve your brain efficiency by 75%", "Chess", 16.0, 8),
    //        ("Unsteady Chair", "Secretly give your opponent a disadvantage",
    //         "Chess", 29.95, 3),
    //        ("Human Chess Board", "A fun game for the family", "Chess", 75.0, 2),
    //        ("Bling-Bling King", "Gold-plated, diamond-studded King",
    //         "Chess", 1200.0, 4)
    //    ];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productStore.callback = {(p:Product) in
            for cell in self.dataTableView.visibleCells {
                if let pcell = cell as? ProductTableCell {
                    if pcell.product?.name == p.name {
                        pcell.stockStepper.value = Double(p.stockLevel);
                        pcell.stockField.text = String(p.stockLevel);
                    }
                } }
            self.displayStockTotal();
        }
//        displayStockTotal();
//        print("",handler);
        // Do any additional setup after loading the view, typically from a nib.
    }
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return productStore.products.count;
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = productStore.products[indexPath.row];
        let cell = dataTableView.dequeueReusableCell(withIdentifier: "ProductTableCell")
            as! ProductTableCell;
        cell.product = product;
        cell.nameLabel.text = product.name;
        cell.descriptionLabel.text = product.productDescription;
        //        cell.descriptionLabel.text = product.description;
        cell.stockStepper.value = Double(product.stockLevel);
        cell.stockField.text = String(product.stockLevel);
        
        //        cell.nameLabel.text = product.0;
        //        cell.descriptionLabel.text = product.1;
        //        cell.stockStepper.value = Double(product.4);
        //        cell.stockField.text = String(product.4);
        //        cell.productId = indexPath.row;
        return cell;
    }
    func displayStockTotal() {
        let finalTotals:(Int, Double) = productStore.products.reduce((0, 0.0),
                                                                     {(totals, product) -> (Int, Double) in
                                                                        return (
                                                                            totals.0 + product.stockLevel,
                                                                            totals.1 + product.stockValue
                                                                        );
        });
//
//        var factory = StockTotalFactory.getFactory(StockTotalFactory.Currency.EUR);
//        var totalAmount = factory.converter?.convertTotal(finalTotals.1);
//        var formatted = factory.formatter?.formatTotal(totalAmount!);
//        
        //Facade
        let formatted = StockTotalFacade.formatCurrencyAmount(amount: finalTotals.1,
                                                              currency: StockTotalFacade.Currency.GBP);
        
//
        //Adapter + Abstract Factory
//        let factory = StockTotalFactory.getFactory(curr: StockTotalFactory.Currency.USD);
//        let totalAmount = factory.converter?.convertTotal(total: finalTotals.1);
//        let formatted = factory.formatter?.formatTotal(total: totalAmount!);
        
        
        totalStockLabel.text = "\(finalTotals.0) Products in Stock. "
            + "Total Value: \(formatted!)";
    }
//        totalStockLabel.text = "\(finalTotals.0) Products in Stock. "
//            + "Total Value: \(Utils.currencyStringFromNumber(number:finalTotals.1))";
//    }
//    func displayStockTotal() {
//        let finalTotals:(Int, Double) = products.reduce((0, 0.0),
//                                                        {(totals, product) -> (Int, Double) in
//                                                            return (
//                                                                totals.0 + product.stockLevel,
//                                                                totals.1 + product.stockValue
//                                                            ); });
//        totalStockLabel.text = "\(finalTotals.0) Products in Stock. "
//            + "Total Value: \(Utils.currencyStringFromNumber(number: finalTotals.1))";
        //        let stockTotal = products.reduce(0,
        //                                         {(total, product) -> Int in return total + product.stockLevel}); totalStockLabel.text = "\(stockTotal) Products in Stock";
        //        let stockTotal = products.reduce(0,
        //                                         {(total, product) -> Int in return total + product.4});
        //        totalStockLabel.text = "\(stockTotal) Products in Stock";
//    }
    
    @IBAction func stockLevelDidChange(_ sender: Any) {
        if var currentCell = sender as? UIView {
            while (true) {
                currentCell = currentCell.superview!;
                if let cell = currentCell as? ProductTableCell {
                    if let product = cell.product {
                        if let stepper = sender as? UIStepper {
                            product.stockLevel = Int(stepper.value);
                        } else if let textfield = sender as? UITextField {
                            if let newValue = Int(textfield.text!){
                                product.stockLevel = newValue;
                            } }
                        cell.stockStepper.value = Double(product.stockLevel);
                        cell.stockField.text = String(product.stockLevel);
                        productLogger.logItem(product);
//                        logger.logItem(item: product);
                    }
                    //                    if let id = cell.productId {
                    //                        var newStockLevel:Int?;
                    //                        if let stepper = sender as? UIStepper {
                    //                            newStockLevel = Int(stepper.value);
                    //                        } else if let textfield = sender as? UITextField {
                    //                            if let newValue = Int(textfield.text!) {
                    //                                newStockLevel = newValue;
                    //                            }
                    //                        }
                    //                        if let level = newStockLevel {
                    //                            products[id].4 = level;
                    //                            cell.stockStepper.value = Double(level);
                    //                            cell.stockField.text = String(level);
                    //                        }
                    //                }
                    break;
                }
            }
            displayStockTotal();
        }
    }
    
    
}

