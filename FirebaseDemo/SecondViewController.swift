//
//  SecondViewController.swift
//  FirebaseDemo
//
//  Created by Duncan on 2016/6/19.
//  Copyright © 2016年 Duncan. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    var selectedProductKey: String?
    let ProductKeyArr = ["ad", "sign", "led"]
    let ProductValueArr = ["廣告", "招牌", "LED"]
    let object = [
        "ad": ["Product1", "Product2", "Product3"],
        "sign": ["Product4", "Product5", "Product6"],
        "led": ["Product7", "Product8", "Product9"]
    ]
    
    @IBOutlet weak var productPickerInput: UITextField!
    @IBOutlet weak var productDetailPickerInput: UITextField!
    @IBOutlet weak var customerInput: UITextField!
    
    
    
    @IBAction func sendButton(_ sender: AnyObject) {
        print([productPickerInput.text, productDetailPickerInput.text, customerInput.text])
    }
    
    @IBAction func tapScreen(_ sender: AnyObject) {
        productPickerInput.resignFirstResponder()
        productDetailPickerInput.resignFirstResponder()
        customerInput.resignFirstResponder()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let productPicker = UIPickerView()
        let productDetailPicker = UIPickerView()
        productPicker.delegate = self
        productDetailPicker.delegate = self
        
        productPickerInput.inputView = productPicker
        productDetailPickerInput.inputView = productDetailPicker
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == productPickerInput.inputView{
            return ProductValueArr.count
        }else{
            if selectedProductKey != nil{
                
                return object[selectedProductKey!]!.count
            }else{
                return 0
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == productPickerInput.inputView{
        
            return ProductValueArr[row]
        }else{
            if selectedProductKey != nil{
            
                return object[selectedProductKey!]![row]
            }else{
                return ""
            }
        }
        
    }
    
 
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if pickerView == productPickerInput.inputView{
        
            productDetailPickerInput.text = ""
            selectedProductKey = ProductKeyArr[row]
            productPickerInput.text = ProductValueArr[row]
        }else{
            if selectedProductKey != nil{
                productDetailPickerInput.text = object[selectedProductKey!]![row]
            }
        }

    }

 

    
}

