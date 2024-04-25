//
//  SetupRegisterViewController.swift
//  CinemaApp
//
//  Created by 유림 on 4/23/24.
//

import UIKit
import SnapKit

class RegisterViewController: UIViewController {
    
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
    
    @IBAction func tappedExitButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func tappedRegisterButton(_ sender: UIButton) {
        // 데이터 안 채우고 가입하기 버튼 눌렀을 경우
        guard let userName = nameViewTextField.text,
              let userID = idViewTextField.text,
              let userPW = pwViewTextField.text,
              !userName.isEmpty, // TextField가 비어있으면 nil이 아니라 ""이기 때문에 필요.
              !userID.isEmpty,
              !userPW.isEmpty
        else {
            self.showAlertIfDataIncomplete(userName: nameViewTextField.text, userID: idViewTextField.text, userPW: pwViewTextField.text)
            return
        }
        
        // userDefauts에 정보 저장
        UserDefaults.standard.set(userName, forKey: "userName")
        UserDefaults.standard.set(userID, forKey: "userID")
        UserDefaults.standard.set(userPW, forKey: "userPW")
        self.showAlertIfDataComplete()
        print("가입 완료: \(UserDefaults.standard.value(forKey: "userName")) / \(UserDefaults.standard.value(forKey: "userID")) / \(UserDefaults.standard.value(forKey: "userPW"))")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setupUI()
    }
    
    
    
    func setupUI() {
        setColors()
        setFontAndText()
        setCornerRadius()
        setTextFieldPadding()
    }
    
    func setupConstraints() {
        setTranslatesAutoresizingMaskIntoConstraintsFalse()
        setTitleConstraints()
        setNameViewConstraints()
        setIdViewConstraints()
        setPwViewConstraints()
        setRegisterButtonConstraints()
        setExitButtonConstraints()
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
        self.pageSubtitleLabel.font = UIFont.systemFont(ofSize: 16)
        self.pageSubtitleLabel.numberOfLines = 0
        
        // MARK: page title 텍스트 가운데 정렬
        [self.pageTitleLabel,
         self.pageSubtitleLabel].forEach {
            $0.textAlignment = .center
        }
        
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
        
        // MARK: Register button <- 적용 안 됨....
        self.registerButton.titleLabel?.text = "가입하기"
        self.registerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
    }
    
    func setCornerRadius() { // frame과 관련된 값은 viewDidAppear
        [self.nameViewTextField,
         self.idViewTextField,
         self.pwViewTextField].forEach {
            $0.clipsToBounds = true // TextField는 여러 뷰로 구성됨 -> clipsToBounds = true 해야 cornerRadius 제대로 적용 가능
            $0.layer.cornerRadius = 20 // height이 설정된 후에 실행되어야 함
        }
    }
    
    func setTextFieldPadding() {
        [self.nameViewTextField,
         self.idViewTextField,
         self.pwViewTextField].forEach {
            $0?.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 0))
            $0?.leftViewMode = .always
        }
    }
    
    // MARK: - set up constraints
    func setTranslatesAutoresizingMaskIntoConstraintsFalse() {
        [pageTitleLabel,
         pageSubtitleLabel,
         nameView,
         nameViewTitleLabel,
         nameViewTextField,
         idView,
         idViewTitleLabel,
         idViewTextField,
         pwView,
         pwViewTitleLabel,
         pwViewTextField,
         exitButton,
         registerButton].forEach {
            $0?.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    // title: top,horizontalEdges
    func setTitleConstraints() {
        self.pageTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.snp.top).offset(40)
            $0.horizontalEdges.equalTo(self.view)
        }
        self.pageSubtitleLabel.snp.makeConstraints {
            $0.top.equalTo(pageTitleLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(self.view)
        }
    }
    
    func setNameViewConstraints() {
        // view: top, horizontalEdges
        self.nameView.snp.makeConstraints {
            $0.top.equalTo(pageSubtitleLabel.snp.bottom).offset(30)
            $0.horizontalEdges.equalTo(self.view).inset(40)
        }
        // title: top, horizontalEdges
        self.nameViewTitleLabel.snp.makeConstraints {
            $0.top.equalTo(nameView)
            $0.horizontalEdges.equalTo(nameView)
        }
        // textField: top, horizontalEdgs, height, bottom
        self.nameViewTextField.snp.makeConstraints {
            $0.top.equalTo(nameViewTitleLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(nameView)
            $0.height.equalTo(40)
            $0.bottom.equalTo(nameView.snp.bottom)
        }
    }
    
    func setIdViewConstraints() {
        // view: top, horizontalEdges
        self.idView.snp.makeConstraints {
            $0.top.equalTo(nameView.snp.bottom).offset(30)
            $0.horizontalEdges.equalTo(self.view).inset(40)
        }
        // title: top, horizontalEdges
        self.idViewTitleLabel.snp.makeConstraints {
            $0.top.equalTo(idView)
            $0.horizontalEdges.equalTo(idView)
        }
        // textField: top, horizontalEdgs, height, bottom
        self.idViewTextField.snp.makeConstraints {
            $0.top.equalTo(idViewTitleLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(idView)
            $0.height.equalTo(40)
            $0.bottom.equalTo(idView.snp.bottom)
        }
    }
    
    func setPwViewConstraints() {
        // view: top, horizontalEdges
        self.pwView.snp.makeConstraints {
            $0.top.equalTo(idView.snp.bottom).offset(30)
            $0.horizontalEdges.equalTo(self.view).inset(40)
        }
        // title: top, horizontalEdges
        self.pwViewTitleLabel.snp.makeConstraints {
            $0.top.equalTo(pwView)
            $0.horizontalEdges.equalTo(pwView)
        }
        // textField: top, horizontalEdgs, height, bottom
        self.pwViewTextField.snp.makeConstraints {
            $0.top.equalTo(pwViewTitleLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(pwView)
            $0.height.equalTo(40)
            $0.bottom.equalTo(pwView.snp.bottom)
        }
    }
    
    func setRegisterButtonConstraints() {
        // top, width, centerX
        self.registerButton.snp.makeConstraints {
            $0.top.equalTo(pwView.snp.bottom).offset(30)
            $0.width.equalTo(100)
            $0.centerX.equalTo(self.view)
        }
    }
    
    func setExitButtonConstraints() {
        // top,leading, width, height
        self.exitButton.snp.makeConstraints {
            $0.top.leading.equalTo(self.view).offset(15)
            $0.width.height.equalTo(30)
        }
    }
    
    
    // MARK: - Alert: 정보 다 안 채우고 가입하기 버튼 누를 경우
    func showAlertIfDataIncomplete(userName: String?, userID: String?, userPW: String?) {
        // Alert Title 설정
        var alertTitle = ""
        if userName == nil || userName == "" {
            alertTitle = "이름을 입력하세요."
        } else if userID == nil || userID == "" {
            alertTitle = "아이디를 입력하세요"
        } else if userPW == nil || userPW == "" {
            alertTitle = "비밀번호를 입력하세요"
        }
        EasyAlert.showAlert(title: alertTitle, message: nil, vc: self)
    }
    
    // MARK: - Alert: 정상 가입 되었을 경우
    func showAlertIfDataComplete() {
        let alert = UIAlertController(title: "회원가입 완료", message: "회원가입이 완료되었습니다.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .cancel) { [weak self] _ in
            self?.dismiss(animated: true)
        }
        
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
    
    
}
