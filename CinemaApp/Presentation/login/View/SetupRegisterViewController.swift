//
//  SetupRegisterViewController.swift
//  CinemaApp
//
//  Created by 유림 on 4/23/24.
//

import UIKit

class SetupRegisterViewController: RegisterViewController {
    
    @IBOutlet weak var pageTitleLabel: UILabel!
    @IBOutlet weak var pageSubtitleLabel: UILabel!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var nameViewTitleLabel: UILabel!
    @IBOutlet weak var nameViewTextField: UITextField!
    @IBOutlet weak var idView: UIView!
    @IBOutlet weak var idViewTitleLabel: UILabel!
    @IBOutlet weak var idViewTextField: UITextField!
    @IBOutlet weak var pwView: UIView!
    @IBOutlet weak var pwViewTitleLabel: UILabel!
    @IBOutlet weak var pwViewTextField: UITextField!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    // color set
    let BackgroundColor = UIColor(named: "BackgroundColor")
    let customPrimaryColor = UIColor(named: "customPrimaryColor")
    let PrimaryContainerColor = UIColor(named: "PrimaryContainerColor")
    let LabelTextColor = UIColor(named: "LabelTextColor")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupUI() {
        setColors()
        setFontAndText()
    }
    
    override func setupConstraints() {
    }
    
    // MARK: - Setup UI
    // background
    func setColors() {
        // view background
        self.view.backgroundColor = customPrimaryColor
        self.nameView.backgroundColor = nil
        self.idView.backgroundColor = nil
        self.pwView.backgroundColor = nil
        
        // 라벨 컬러
        [self.pageTitleLabel, 
         self.pageSubtitleLabel,
         self.nameViewTitleLabel,
         self.idViewTitleLabel,
         self.pwViewTitleLabel
        ].forEach {
            $0?.textColor = LabelTextColor
        }
        
        // Text Field 컬러
        [self.nameViewTextField,
        self.idViewTextField,
         self.pwViewTextField].forEach {
            $0?.backgroundColor = PrimaryContainerColor
            $0?.textColor = LabelTextColor
        }
        
        // 버튼 컬러
        [self.exitButton,
         self.registerButton].forEach {
            $0?.tintColor = LabelTextColor
        }
    }
    
    func setFontAndText() {
        // MARK: title
        self.pageTitleLabel.text = "회원가입"
        self.pageTitleLabel.font = UIFont.boldSystemFont(ofSize: 26)
        
        self.pageSubtitleLabel.text = "Twelve Cinema에 오신 것을 환영합니다."
        self.pageSubtitleLabel.font = UIFont.systemFont(ofSize: 18)
        
        // MARK: view title labels
        // text
        self.nameViewTitleLabel.text = "이름"
        self.idViewTitleLabel.text = "아이디"
        self.pwViewTitleLabel.text = "비밀번호"
        // font
        [self.nameViewTitleLabel,
         self.idViewTitleLabel,
         self.pwViewTitleLabel].forEach {
            $0?.font = UIFont.boldSystemFont(ofSize: 18)
        }
        
        // MARK: text field place holder
        // text
        self.nameViewTextField.attributedPlaceholder = NSAttributedString(string: "이름을 입력하세요.", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        self.idViewTextField.attributedPlaceholder = NSAttributedString(string: "아이디를 입력하세요.", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        self.pwViewTextField.attributedPlaceholder = NSAttributedString(string: "비밀번호를 입력하세요.", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        // font
        [self.nameViewTextField,
         self.idViewTextField,
         self.pwViewTextField].forEach {
            $0?.font = UIFont.systemFont(ofSize: 18)
        }
        
    }
    
    
    
}
