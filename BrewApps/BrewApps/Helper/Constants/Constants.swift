//
//  Constants.swift
 
//MARK: - Colors
extension UIColor {
    
    class func appBlack() -> UIColor { return UIColor(named: "AppBlack")! }
    class func appDarkCyan() -> UIColor { return UIColor(named: "AppDarkCyan")! }
    class func appGray() -> UIColor { return UIColor(named: "AppGray")! }
    class func appOffWhite() -> UIColor { return UIColor(named: "AppOffWhite")! }
    class func appWhite() -> UIColor { return UIColor(named: "AppWhite")! }
}

// MARK: - Global
enum GlobalConstants {
    
    static let appName    = Bundle.main.infoDictionary!["CFBundleName"] as! String
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    static let appBuild = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
}

//MARK: - StoryBoard Identifier's
enum AllStoryBoard {
    
    static let Main = UIStoryboard(name: "Main", bundle: nil)
}

//MARK: - ViewController Names
enum ViewControllerName {
    
    static let kMoviesListVC = "MoviesListVC"
}

//MARK: - Cell Identifiers
enum CellIdentifiers {
    
    static let kCellMoviesList = "CellMoviesList"
}

//MARK: - Message's
enum AlertMessage {
    
    //In Progress Message
    static let msgComingSoon = "Coming soon"
    
    //Internet Connection Message
    static let msgNetworkConnection = "You are not connected to internet. Please connect and try again"
    
    //Camera, Images and ALbums Related Messages
    static let msgPhotoLibraryPermission = "Please enable access for photos from Privacy Settings"
    static let msgCameraPermission = "Please enable camera access from Privacy Settings"
    static let msgNoCamera = "Device has no camera"
    static let msgImageSaveIssue = "Photo is unable to save in your local storage. Please check storage or try after some time"
    static let msgSelectPhoto = "Please select photo"
    static let msgNotFoundBackCamera = "Could not find a back camera"
    static let msgNotCreateVideoDevice = "Could not create video device input"
    static let msgNotAddVideoInputSession = "Could not add video device input to the session"
    static let msgNotAdVideoOutputSession = "Could not add video data output to the session"
    
    //General Error Message
    static let msgError = "Something went wrong. Please try after sometime"
    
    //Validation Messages
    static let msgFirstName = "Please enter first name"
    static let msgValidFirstName = "First name must contain atleast 2 characters and maximum 30 characters"
    
    static let msgLastName = "Please enter last name"
    static let msgValidLastName = "Last name must contain atleast 2 characters and maximum 30 characters"
    
    static let msgEmail = "Please enter email address"
    static let msgValidEmail = "Please enter valid email address"
    
    static let msgPassword = "Please enter password"
    static let msgPasswordCharacter = "Password must contain atleast 8 characters and maximum 16 characters"
    static let msgValidPassword = "Password should contain atleast one uppercase letter, one lowercase letter, one digit and one special character with minimum eight character length"
    
    static let msgDate = "Please enter date"
    static let msgValidDate = "Date must contain atleast 2 characters"
    
    static let msgMonth = "Please enter month"
    static let msgValidMonth = "Month must contain atleast 2 characters"
    
    static let msgYear = "Please enter year"
    static let msgValidYear = "Year must contain atleast 4 characters"
    
    static let msgCountryCode = "Please select country code"
    static let msgPhoneNumber = "Please enter phone number"
    
    static let msgOTP = "Please enter opt"
    
    static let msgNationalInsuranceNumber = "Please enter national insurance number"
    
    static let msgPostalCode = "Please enter postal code for search"
    
    static let msgOldPassword = "Please enter old password"
    static let msgOldPasswordCharacter = "Old password must contain atleast 8 characters and maximum 16 characters"
    
    static let msgNewPassword = "Please enter new password"
    static let msgNewPasswordCharacter = "New password must contain atleast 8 characters and maximum 16 characters"
    
    //General Delete Message
    static let msgGeneralDelete = "Are you sure you want to delete?"
    
    //Logout Message
    static let msgLogout = "Are you sure you want to log out from the application?"
    
    //Celebrity profile
    static let msgCopyPortfolio = "Portfolio has been copied!"
}

//MARK: - Web Service URLs
enum WebServiceURL {
    
    static let mainURL = "https://api.gatherinvesting.com/v1/"
    
    static let productsURL = mainURL + "products"
}

//MARK: - Web Service Parameters
enum WebServiceParameter {
    
    static let pFirstname = "firstname"
}

//MARK: - UserDefault
enum UserDefault {
    
    static let kAPIToken = "api_token"
    static let kIsKeyChain = "isKeyChain"
}

//MARK: - Constants
struct Constants {
    
    //MARK: - Device Type
    enum UIUserInterfaceIdiom : Int {
        
        case Unspecified
        case Phone
        case Pad
    }
    
    //MARK: - Screen Size
    struct ScreenSize {
        
        static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
        static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
        static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    }
}

//MARK: - DateTime Format
enum DateAndTimeFormatString {
    
    static let strDateFormate_ddMMMyyyyhhmmss = "dd MMM yyyy hh:mm:ss a"
    static let strDateFormate_ddMMMyyyy = "dd MMM yyyy"
    static let strDateFormate_hhmma = "hh:mm a"
    static let strDateFormate_yyyyMMdd = "yyyy/MM/dd"
    static let strDateFormate_ddMMyyyy = "dd/MM/yyyy"
    static let strDateFormate_dd = "dd"
    static let strDateFormate_MM = "MM"
    static let strDateFormate_yyyy = "yyyy"
}
