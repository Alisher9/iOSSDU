//
//  ViewController.swift
//  Animation
//
//  Created by Alisher Sattarbek on 11/18/19.
//  Copyright © 2019 AlisherSattarbek. All rights reserved.
//
import UIKit
import Cartography

class ViewController: UIViewController {
    
    @IBOutlet weak var nextButton: UIButton!
    
    lazy var firstTextField : UITextField = {
        let firstTextField = UITextField(frame: .zero)
        firstTextField.placeholder = "Email"
        let paddleView:UIView = UIView(frame: CGRect(x:0, y:0, width:5, height:30))
        firstTextField.leftView = paddleView
        firstTextField.leftViewMode = UITextFieldViewMode.always
        firstTextField.backgroundColor = .white
        firstTextField.layer.cornerRadius  = 5
        firstTextField.font = UIFont.systemFont(ofSize: 15)
        return firstTextField
    }()
    
    lazy var secondTextField : UITextField = {
        let secondTextField = UITextField(frame: .zero)
        secondTextField.placeholder = "Password"
        let paddleView:UIView = UIView(frame: CGRect(x:0, y:0, width:5, height:30))
        secondTextField.leftView = paddleView
        secondTextField.leftViewMode = UITextFieldViewMode.always
        secondTextField.backgroundColor = .white
        secondTextField.layer.cornerRadius = 5
        secondTextField.font = UIFont.systemFont(ofSize: 15)
        return secondTextField
    }()
    
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .transitionFlipFromLeft, animations: {
            self.firstTextField.center.x += self.view.bounds.width
        }, completion: nil)
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .transitionFlipFromRight, animations: {
            self.secondTextField.center.x -= self.view.bounds.width
        }, completion: nil)
        
        UIView.animate(withDuration: 1.0, delay: 1, animations: {
            self.nextButton.alpha = 0
        }, completion: nil)
        //let viewController = SecondViewController()
        //present(viewController, animated: true, completion: nil)
    }
    
    
    func nextButtonSetup() {
        nextButton.setTitle("Next", for: .normal)
        nextButton.layer.borderWidth = 1
        nextButton.layer.borderColor = UIColor.white.cgColor
        nextButton.layer.cornerRadius = 10
        nextButton.clipsToBounds = true
        nextButton.tintColor = UIColor.init(red: 31.0/255, green: 155.0/255, blue: 255.0/255, alpha: 1)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        nextButtonSetup()
        animation()
    }
    
    func animation() {
        UIView.animate(withDuration: 1.5, delay: 0, options: .transitionFlipFromRight, animations: {
            self.firstTextField.center.x += self.view.bounds.width
        }, completion: nil)
        
        
        UIView.animate(withDuration: 1.5, delay: 0, options: .transitionFlipFromLeft, animations: {
            self.secondTextField.center.x -= self.view.bounds.width
        }, completion: nil)
        nextButton.alpha = 0
        UIView.animate(withDuration: 1, delay: 1.5, animations: {
            self.nextButton.alpha = 1
        }, completion: nil)
    }
    
    
    
    func setupView() {
        view.backgroundColor = .mainBackground
        view.addSubview(firstTextField)
        view.addSubview(secondTextField)
        view.addSubview(nextButton)
    }
    
    
    
    func setupConstraints() {
        constrain(firstTextField, secondTextField, nextButton, view) { fTF, sTF, nB, vw in
            fTF.top == vw.top + (300 / 736 * UIScreen.main.bounds.height)
            fTF.centerX == vw.centerX
            fTF.height == 30 / 736 * UIScreen.main.bounds.height
            fTF.width == 250 / 414 * UIScreen.main.bounds.width
            
            sTF.top == fTF.bottom + (20 / 736 * UIScreen.main.bounds.height)
            sTF.centerX == vw.centerX
            sTF.height == 30 / 736 * UIScreen.main.bounds.height
            sTF.width == 250 / 414 * UIScreen.main.bounds.width
            
            nB.top == sTF.bottom + (20 / 736 * UIScreen.main.bounds.height)
            nB.centerX == vw.centerX
            nB.height == 40 / 736 * UIScreen.main.bounds.height
            nB.width == 80 / 414 * UIScreen.main.bounds.width
            
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}



