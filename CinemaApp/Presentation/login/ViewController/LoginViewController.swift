//
//  LoginViewController.swift
//  CinemaApp
//
//  Created by 유림 on 4/22/24.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        configureUI()
    }
    
    // MARK: - UI Components 연결
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var bgPosterImage: UIImageView!
    @IBOutlet weak var bgTransparentBlackImage: UIImageView!
    
    
    @IBOutlet weak var loginComponentsView: UIView!
    @IBOutlet weak var appLogoImage: UIImageView!
    
    @IBOutlet weak var idBoxView: UIView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var pwBoxView: UIView!
    @IBOutlet weak var pwLabel: UILabel!
    
    @IBOutlet weak var autoLoginCheckView: UIView!
    @IBOutlet weak var autoLoginCheckButton: UIButton!
    @IBOutlet weak var autoLoginCheckLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var searchIDButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    
    // MARK: - UI Setting functions
    func setupConstraints() {
        setTranslatesAutoresizingMaskIntoConstraintsFalse()
        setBackgroundConstraints()
        setLoginComponentsConstraints()
    }
   
    func configureUI() {
        setBackgroundUI()
        setAppLogoUI()
    }
    
    
    
    // MARK: - Setup Constraints
    // set translatesAutoresizingMaskIntoConstraints false
    func setTranslatesAutoresizingMaskIntoConstraintsFalse() {
        [self.bgView,
         self.bgPosterImage,
         self.bgTransparentBlackImage,
         self.loginComponentsView,
         self.appLogoImage,
         self.idBoxView,
         self.idLabel,
         self.pwBoxView,
         self.pwLabel,
         self.autoLoginCheckView,
         self.autoLoginCheckLabel,
         self.autoLoginCheckButton,
         self.loginButton,
         self.searchIDButton,
         self.registerButton
        ].forEach {
            $0?.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setBackgroundConstraints() { // 전체 크기로 안 됨...
        self.bgView.snp.makeConstraints {
            $0.edges.equalTo(self.view)
        }
        self.bgPosterImage.snp.makeConstraints {
            $0.edges.equalTo(self.view)
        }
        self.bgTransparentBlackImage.snp.makeConstraints {
            $0.edges.equalTo(self.view)
        }
    }
    
    func setLoginComponentsConstraints() {
        // 컴포넌트 엄마뷰: bottom, height, horizontalEdges
        self.loginComponentsView.backgroundColor = .systemPink
        self.loginComponentsView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(140) // bottom
            $0.height.equalTo(360) // height
            $0.horizontalEdges.equalToSuperview().inset(35)
        }
        
        // 앱 로고: top, height, centerX
        self.appLogoImage.snp.makeConstraints {
            $0.top.equalTo(loginComponentsView.snp.top) // top
            $0.height.equalTo(40) // height
            $0.centerX.equalTo(loginComponentsView) // centerX
        }
        
        // id Box: top, height, horizontalEdges
        self.idBoxView.snp.makeConstraints {
            $0.top.equalTo(appLogoImage.snp.bottom).offset(30)
            $0.height.equalTo(60)
            $0.horizontalEdges.equalTo(loginComponentsView)
        }
        
        // id label: leading, centerY
        self.idLabel.snp.makeConstraints {
            $0.leading.equalTo(idBoxView.snp.leading).offset(20)
            $0.centerY.equalTo(idBoxView)
        }
        
        // pw Box: top, height, horizontalEdges
        self.pwBoxView.snp.makeConstraints {
            $0.top.equalTo(idBoxView.snp.bottom).offset(20)
            $0.height.equalTo(60)
            $0.horizontalEdges.equalTo(loginComponentsView)
        }
        
        // pw label: leading, centerY
        self.pwLabel.snp.makeConstraints {
            $0.leading.equalTo(pwBoxView.snp.leading).offset(20)
            $0.centerY.equalTo(pwBoxView)
        }
        
        // 자동로그인 뷰: top, height, trailing
        self.autoLoginCheckView.snp.makeConstraints {
            $0.top.equalTo(pwBoxView.snp.bottom).offset(10)
            $0.height.equalTo(26)
            $0.trailing.equalTo(loginComponentsView.snp.trailing)
        }
        
        // 자동로그인 label: centerY, trailing
        self.autoLoginCheckLabel.snp.makeConstraints {
            $0.centerY.equalTo(autoLoginCheckView)
            //$0.trailing.equalTo(autoLoginCheckView.snp.trailing)
        }
        
        // 자동로그인 버튼 : horizontalEdges, trailing
        self.autoLoginCheckButton.snp.makeConstraints {
            $0.horizontalEdges.equalTo(autoLoginCheckView)
            $0.trailing.equalTo(autoLoginCheckLabel.snp.leading).inset(3)
        }
        
        // 로그인 버튼: top, height, horizontalEdges
        self.loginButton.snp.makeConstraints {
            $0.top.equalTo(autoLoginCheckView.snp.bottom).offset(18)
            $0.height.equalTo(60)
            $0.horizontalEdges.equalTo(loginComponentsView)
        }
        
        // 아이디·비밀번호 찾기 버튼: top, leading
        self.searchIDButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(10)
            $0.leading.equalTo(loginComponentsView.snp.leading)
        }
        
        // 회원가입 버튼: top, trailing
        self.registerButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(10)
            $0.trailing.equalTo(loginComponentsView.snp.trailing)
        }
        
    }
    
    
    
    
    
    // MARK: - configure UI
    func setBackgroundUI() {
        // 포스터 이미지
        let image = UIImage(systemName: "photo.fill")
        self.bgPosterImage.image = image
        self.bgPosterImage.contentMode = .scaleAspectFill
        
        // 투명도 80% 검정
        self.bgTransparentBlackImage.backgroundColor = UIColor.black
        self.bgTransparentBlackImage.alpha = 0.8
    }
    
    func setAppLogoUI() {
        let image = UIImage(systemName: "apple.logo")
        self.appLogoImage.image = image
        self.appLogoImage.contentMode = .scaleAspectFit
    }
    
    
}
