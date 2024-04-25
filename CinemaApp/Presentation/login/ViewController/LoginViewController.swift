//
//  SetupLoginViewController.swift
//  CinemaApp
//
//  Created by 유림 on 4/23/24.
//

import UIKit
import Kingfisher

class LoginViewController: UIViewController {
    
    
    // MARK: - UI Components 연결
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var bgPosterImage: UIImageView!
    @IBOutlet weak var bgTransparentBlackImage: UIImageView!
    
    
    @IBOutlet weak var loginComponentsView: UIView!
    @IBOutlet weak var appLogoImage: UIImageView!
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    
    @IBOutlet weak var autoLoginCheckView: UIView!
    @IBOutlet weak var autoLoginCheckButton: UIButton!
    @IBOutlet weak var autoLoginCheckLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var searchIDButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    // 영화 목록을 저장할 배열
    var upcomingMovies: [Movie] = []
    var randomUpcomingMovie: Movie?
    
    // 자동 로그인 상태
    var autoLoginStatus: Bool = true {
        didSet {
            updateAutoLoginCheckImage()
        }
    }
    
    // color set
    let BackgroundColor = UIColor(named: "BackgroundColor")
    let customPrimaryColor = UIColor(named: "customPrimaryColor")
    let PrimaryContainerColor = UIColor(named: "PrimaryContainerColor")
    let LabelTextColor = UIColor(named: "LabelTextColor")
    
    @IBAction func tappedAutoLoginCheckButton(_ sender: UIButton) {
        autoLoginStatus = !autoLoginStatus
    }
    
    @IBAction func tappedLoginButton(_ sender: UIButton) {
        conductLogin()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupConstraints()
        self.conductAutoLogin()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.setBackgroundUI()
        print("yyyyyyyy")
    }
    
    // MARK: - Auto Login
    func conductAutoLogin() {
        // autoLoginStatus 체크
        if autoLoginStatus == true {
            // 1. text에 userDefaults 정보 넣기
            idTextField.text = UserDefaults.standard.string(forKey: "userID")
            pwTextField.text = UserDefaults.standard.string(forKey: "userPW")
            conductLogin()
        }
        
    }
    
    func conductLogin() {
        // 1. ID & PW 일치 확인
        if idTextField.text == UserDefaults.standard.string(forKey: "userID"),
           pwTextField.text == UserDefaults.standard.string(forKey: "userPW") {
            // TODO: 화면 이동 함수 추가
            
        } else {
            // Alert: 로그인 정보가 일치하지 않습니다
            EasyAlert.showAlert(title: "로그인 실패", message: "로그인 정보가 일치하지 않습니다.", vc: self)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - UI Setting functions
    func setupUI() {
        updateAutoLoginCheckImage()
        setBackgroundUI()
        setAppLogoUI()
        setCornerRadius()
        setFont()
        setColors()
        setPlaceholderText()
    }
    
    func setupConstraints() {
        setTranslatesAutoresizingMaskIntoConstraintsFalse()
        setBackgroundConstraints()
        setLoginComponentsConstraints()
    }
    
    
    
    // MARK: - Setup UI
    // AutoLogin check 이미지 변경 함수
    func updateAutoLoginCheckImage() {
        if autoLoginStatus {
            autoLoginCheckButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        } else {
            autoLoginCheckButton.setImage(UIImage(systemName: "square.fill"), for: .normal)
        }
    }
    
    
    func setBackgroundUI() {
        // 배경 포스터 이미지 설정
        self.fetchUpcomingMovieData(listType: "upcoming")
        self.bgPosterImage.contentMode = .scaleAspectFill
        
        // 투명도 80% 검정으로 덮기
        self.bgTransparentBlackImage.backgroundColor = UIColor.black
        self.bgTransparentBlackImage.alpha = 0.8
    }
    
    func setAppLogoUI() {
        let image = UIImage(systemName: "apple.logo")
        self.appLogoImage.tintColor = .white
        self.appLogoImage.image = image
        self.appLogoImage.contentMode = .scaleAspectFit
    }
    
    func setCornerRadius() {
        [self.idTextField, 
         self.pwTextField].forEach {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 30
        }
        self.loginButton.layer.cornerRadius = 30
    }
    
    func setFont() {
        [self.idTextField, 
         self.pwTextField].forEach {
            $0.font = UIFont.systemFont(ofSize: 18)
        }
        [self.searchIDButton.titleLabel,
         self.registerButton.titleLabel].forEach {
            $0?.font = UIFont.boldSystemFont(ofSize: 16)
        }
        self.autoLoginCheckLabel.font = UIFont.systemFont(ofSize: 16)
        self.loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    func setColors() {
        [self.idTextField, 
         self.pwTextField].forEach {
            $0?.backgroundColor = PrimaryContainerColor
            $0?.textColor = LabelTextColor
        }
        self.loginComponentsView.backgroundColor = nil
        self.autoLoginCheckLabel.textColor = LabelTextColor
        self.loginButton.backgroundColor = customPrimaryColor
        self.loginButton.tintColor = LabelTextColor
        [self.searchIDButton,
         self.registerButton].forEach {
            $0?.tintColor = LabelTextColor
        }
    }
    
    func setPlaceholderText() {
        // 텍스트
        idTextField.attributedPlaceholder = NSAttributedString(string: "아이디를 입력하세요", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        pwTextField.attributedPlaceholder = NSAttributedString(string: "비밀번호를 입력하세요", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        // 패딩
        [self.idTextField,
         self.pwTextField].forEach {
            $0?.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 0))
            $0?.leftViewMode = .always
        }
    }
    
    
    // MARK: - Setup Constraints
    // set translatesAutoresizingMaskIntoConstraints false
    func setTranslatesAutoresizingMaskIntoConstraintsFalse() {
        [self.bgView,
         self.bgPosterImage,
         self.bgTransparentBlackImage,
         self.loginComponentsView,
         self.appLogoImage,
         self.idTextField,
         self.pwTextField,
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
    
    func setBackgroundConstraints() {
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
        //self.loginComponentsView.backgroundColor = .systemPink
        self.loginComponentsView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(140) // bottom
            $0.height.equalTo(360) // height
            $0.horizontalEdges.equalToSuperview().inset(35)
        }
        
        // 앱 로고: top, height, centerX, width
        self.appLogoImage.snp.makeConstraints {
            $0.top.equalTo(loginComponentsView.snp.top) // top
            $0.height.equalTo(40) // height
            $0.centerX.equalTo(loginComponentsView) // centerX
            $0.width.equalTo(loginComponentsView) // width
        }
        
        // idTextField: top, height, horizontalEdges
        self.idTextField.snp.makeConstraints {
            $0.top.equalTo(appLogoImage.snp.bottom).offset(30)
            $0.height.equalTo(60)
            $0.horizontalEdges.equalTo(loginComponentsView)
        }
        
        // pwTextField: top, height, horizontalEdges
        self.pwTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(20)
            $0.height.equalTo(60)
            $0.horizontalEdges.equalTo(loginComponentsView)
        }
        
        // 자동로그인 뷰: top, height, trailing, width
        self.autoLoginCheckView.snp.makeConstraints {
            $0.top.equalTo(pwTextField.snp.bottom).offset(10)
            $0.height.equalTo(26)
            $0.trailing.equalTo(loginComponentsView.snp.trailing)
            $0.width.equalTo(loginComponentsView)
        }
        
        // 자동로그인 label: centerY, trailing, width
        self.autoLoginCheckLabel.snp.makeConstraints {
            $0.centerY.equalTo(autoLoginCheckView)
            $0.trailing.equalTo(autoLoginCheckView.snp.trailing)
            $0.width.greaterThanOrEqualTo(0)
        }
        
        // 자동로그인 버튼 : horizontalEdges, trailing
        self.autoLoginCheckButton.snp.makeConstraints {
            $0.verticalEdges.equalTo(autoLoginCheckView)
            $0.trailing.equalTo(autoLoginCheckLabel.snp.leading).inset(2)
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
    
    
    // MARK: - 배경 포스터 이미지 가져오는 함수 set
    // #1. API로 upcomingMovies 데이터 가져오기
    func fetchUpcomingMovieData(listType: String) {
        print("start: fetchUpcomingMovieData / Thread: \(Thread.current)")
        MovieListApiManager.shared.fetchMovieList(listType: listType, page: 1) { result in
            switch result {
            case .success(let movies):
                print(">>>> Category:\(listType) Page: 1 Success")
                self.upcomingMovies.append(contentsOf: movies.results) // escaping closure 사용?
                print(">>>> append success! \(self.upcomingMovies[1].title)")
                
                // #2. Upcoming Movies에서 랜덤으로 하나 뽑기
                self.pickRandomMovieData()
                
                // #3. randomUpcomingMovie 포스터 이미지를 컴포넌트에 연결하기
                self.setBackgroundPosterImage()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // #2. Upcoming Movies에서 랜덤으로 하나 뽑기
    func pickRandomMovieData() {
        print("start: pickRandomMovieData / Thread: \(Thread.current)")
        let randomIndex = Int.random(in: 0..<upcomingMovies.count)
        self.randomUpcomingMovie = upcomingMovies[randomIndex]
    }
    
    // #3. randomUpcomingMovie 포스터 이미지를 컴포넌트에 연결하기
    func setBackgroundPosterImage() {
        print("start: setBackgroundPosterImage / Thread: \(Thread.current)")
        if let imageURL = randomUpcomingMovie?.posterPath {
            let urlString = "https://image.tmdb.org/t/p/w500\(imageURL)"
            let fullImageURL = URL(string: urlString)
            DispatchQueue.main.async {
                print("start: 포스터 업로드 / Thread: \(Thread.current)")
                self.bgPosterImage.kf.setImage(with: fullImageURL)
            }
        }
    }
    
    
    
}
