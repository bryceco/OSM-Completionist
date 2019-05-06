//
//  QueryFormViewController.swift
//  Go Map!!
//
//  Created by Wolfgang Timme on 5/6/19.
//  Copyright © 2019 Bryce. All rights reserved.
//

import UIKit

class QueryFormViewController: UIViewController {
    
    // MARK: Private properties
    
    private let viewModel = QueryFormViewModel()
    private var disposal = Disposal()
    
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var stackViewBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Overpass Query"
        
        bindToViewModel()
        
        errorLabel.text = nil
        
        startListeningForKeyboardNotifications()
        setupKeyboardDismissOnTapGestureRecognizer()
    }
    
    // MARK: Private methods
    
    private func bindToViewModel() {
        viewModel.queryText.observe { [weak self] text, _ in
            self?.textView.text = text
            }.add(to: &self.disposal)
    }
    
    func startListeningForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc private func keyboardWillShow(sender: Notification) {
        stackViewBottomConstraint.constant = keyboardHeight(from: sender) - bottomLayoutGuide.length
        
        UIView.animate(withDuration: keyboardAnimationDuration(from: sender)) {
            if let animationCurve = self.keyboardAnimationCurve(from: sender) {
                UIView.setAnimationCurve(animationCurve)
            }
            
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(sender: Notification) {
        stackViewBottomConstraint.constant = 0
        
        UIView.animate(withDuration: keyboardAnimationDuration(from: sender)) {
            if let animationCurve = self.keyboardAnimationCurve(from: sender) {
                UIView.setAnimationCurve(animationCurve)
            }
            
            self.view.layoutIfNeeded()
        }
    }
    
    private func keyboardHeight(from notification: Notification) -> CGFloat {
        guard
            let userInfo = notification.userInfo,
            let keyboardEndFrameValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else {
            return 0
        }
        
        return keyboardEndFrameValue.cgRectValue.height
    }
    
    private func keyboardAnimationCurve(from notification: Notification) -> UIView.AnimationCurve? {
        guard
            let userInfo = notification.userInfo,
            let animationDurationNumber = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber,
            let animationCurve = UIView.AnimationCurve(rawValue: animationDurationNumber.intValue)
        else {
                return nil
        }
        
        return animationCurve
    }
    
    private func keyboardAnimationDuration(from notification: Notification) -> TimeInterval {
        guard
            let userInfo = notification.userInfo,
            let animationDurationNumber = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber
        else {
                return 0
        }
        
        return animationDurationNumber.doubleValue
        
    }
    
    private func setupKeyboardDismissOnTapGestureRecognizer() {
        let gestureRecognizer = UITapGestureRecognizer(target: self,
                                                       action: #selector(dismissKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        gestureRecognizer.cancelsTouchesInView = false
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
