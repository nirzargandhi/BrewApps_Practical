//
//  MovieDetailsVC.swift
//  BrewApps
//
//  Created by Nirzar Gandhi on 14/12/21.
//

class MovieDetailsVC: UIViewController {
    
    //MARK: - UIImageView Outlet
    @IBOutlet weak var imgvMovies: UIImageView!
    
    //MARK: - UILabel Outlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    
    //MARK: - Variable Declaration
    var dictMovieDetails : MoviesList?
    
    //MARK: - ViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialization()
        
        setData()
    }
    
    //MARK: - Initialization Method
    func initialization() {
        
        setNavigationHeader(strTitleName: "Movie Details", isTabbar: false)
        
        setupBackButton(isTabbar: false)
    }
    
    //MARK: - Set Data Method
    func setData() {
        
        if dictMovieDetails?.vote_average ?? 0.0 >= 7.0 {
            imgvMovies.sd_setImage(with: URL(string: "\(WebServiceURL.loadBackDropURL)\(dictMovieDetails?.backdrop_path ?? "")"), completed: nil)
        } else {
            imgvMovies.sd_setImage(with: URL(string: "\(WebServiceURL.loadPosterURL)\(dictMovieDetails?.poster_path ?? "")"), completed: nil)
        }
        
        lblTitle.text = dictMovieDetails?.title ?? ""
        
        if let date = Utility().datetimeFormatter(strFormat: DateAndTimeFormatString.strDateFormate_yyyyMMdd, isTimeZoneUTC: false).date(from: dictMovieDetails?.release_date ?? "1947-01-01") {
            lblReleaseDate.text = "Release Date: \(Utility().datetimeFormatter(strFormat: DateAndTimeFormatString.strDateFormate_ddMMMyyyy, isTimeZoneUTC: false).string(from: date))"
        } else {
            lblReleaseDate.text = "Release Date: "
        }
        
        lblOverview.text = dictMovieDetails?.overview ?? ""
    }
}
