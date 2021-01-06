//
//  ViewController.swift
//  TipCalculator
//
//  Created by Macbook Pro on 2021-01-05.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var calculateButton: UIButton!
    @IBOutlet var slider: UISlider!
    @IBOutlet var percentTipLabel: UILabel!
    @IBOutlet var billAmountTextField: UITextField!
    @IBOutlet var totalAmountLabel: UILabel!
    @IBOutlet var scrollView: UIScrollView!
    var percent = 15
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //billAmountTextField.delegate = self
        calculateButton.layer.cornerRadius = 10
        billAmountTextField.layer.cornerRadius = 20
        registerForKeyboardNotification()
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
      view.endEditing(true)
    }
    
    fileprivate func registerForKeyboardNotification() {
      // 1. I want to listen to the keyboard showing / hiding
      //    - "hey iOS, tell(notify) me when keyboard shows / hides"
      NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        percent = Int(sender.value)
        percentTipLabel.text = "\(percent) %"
        calculateTip()
    }
    
    @IBAction func calculateTip(_ sender: UIButton) {
        calculateTip()
    }
    
    func calculateTip() {
        guard let _ = billAmountTextField.text?.isEmpty else { return }
        totalAmountLabel.text = "$ 00.00"
        
        guard let amount = Double (billAmountTextField.text!), amount > 0.0 else { return }
    
        let totalAmount = String(format: "%.2f", (amount + (amount * (Double(percent)/100))))
        totalAmountLabel.text = "$ \(totalAmount)"
    }
    
    @IBAction func billAmountEditingChanged(_ sender: UITextField) {
        calculateTip()
    }
    
    @objc func keyboardWasShown(_ notification: NSNotification) {
      // 2. When notified, I want to ask iOS the size(height) of the keyboard
      guard let info = notification.userInfo, let keyboardFrameValue = info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else { return }
      
      let keyboardFrame = keyboardFrameValue.cgRectValue
        let keyboardHeight = keyboardFrame.size.height
    
      //print(keyboardHeight)
      // 3. Tell scrollview to scroll up (height)
      // there is a significant space at the bottom hence the need to multiply the keyboardHeight to 1.75
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight + 300, right: 0)
      scrollView.contentInset = insets
      scrollView.scrollIndicatorInsets = insets
    }
    
    @objc func keyboardWillBeHidden(_ notification: NSNotification) {
      // 2. When notified, I want to ask iOS the size(height) of the keyboard
      // 3. Tell scrollview to scroll down (height)
      let insets = UIEdgeInsets.zero
      scrollView.contentInset = insets
      scrollView.scrollIndicatorInsets = insets
    }
}

//extension UIViewController: UITextFieldDelegate {
//    public func textFieldDidEndEditing(_ textField: UITextField) {
//
//    }
//}



