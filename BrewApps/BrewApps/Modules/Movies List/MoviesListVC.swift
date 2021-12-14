//
//  MoviesListVC.swift
//  BrewApps
//
//  Created by Nirzar Gandhi on 14/12/21.
//

class MoviesListVC: UIViewController {
    
    //MARK: - UITextField Outlet
    @IBOutlet weak var txtSearchMovies: UITextField!
    
    //MARK: - UICollectionView Outlet
    @IBOutlet weak var cvMoviesList: UICollectionView!
    
    //MARK: - UILabel Outlet
    @IBOutlet weak var lblNoData: UILabel!
    
    //MARK: - UIActivityIndicatorView Outlet
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Variable Declaration
    var arrMoviesList = [MoviesList]()
    var arrSearchMoviesList = [MoviesList]()
    var isSearch = false
    var isBottomRefresh = false
    var intPageNumber = 1
    var intTotalPageNumber = Int()
    
    //MARK: - ViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialization()
        
        wsMoviesList()
    }
    
    //MARK: - Initialization Method
    func initialization() {
        
        showNavigationBar(isTabbar: false)
        
        setNavigationHeader(strTitleName: "Movies List", isTabbar: false)
    }
    
    //MARK: - UIScrollView Method
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        hideIQKeyboard()
        
        if scrollView == cvMoviesList {
            
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height) {
                if !isBottomRefresh && !isSearch {
                    isBottomRefresh = true
                    activityIndicator.startAnimating()
                    loadMoreMoviesList()
                }
            }
        }
    }
    
    //MARK: - Load More Movies List Method
    func loadMoreMoviesList() {
        
        if intPageNumber <= intTotalPageNumber {
            intPageNumber += 1
            activityIndicator.isHidden = false
            wsMoviesList()
        } else {
            activityIndicator.stopAnimating()
            isBottomRefresh = false
        }
    }
    
    //MARK: - UIButton Action Method
    @objc func btnDeleteAction(_ sender: UIButton) {
        arrMoviesList.remove(at: sender.tag)
        
        cvMoviesList.reloadData()
    }
    
    //MARK: - Webservice Call Method
    func wsMoviesList(isLoader : Bool = true) {
        
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.view.makeToast(AlertMessage.msgNetworkConnection)
            return
        }
        
        ApiCall().get(apiUrl: "\(WebServiceURL.moviesListURL)\(WebServiceParameter.pAPIKey)=\(MovieListAPIKey.apiKey)&\(WebServiceParameter.pPage)=\(intPageNumber)", model: MoviesListModel.self) { (success, responseData) in
            if success, let responseData = responseData as? MoviesListModel {
                
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                
                self.intTotalPageNumber = responseData.total_pages ?? 0
                
                if self.isBottomRefresh == true {
                    self.arrMoviesList.append(contentsOf: responseData.results ?? [])
                } else {
                    self.arrMoviesList = responseData.results ?? []
                }
                
                self.isBottomRefresh = false
                
                if self.arrMoviesList.count > 0 {
                    self.cvMoviesList.reloadData()
                    
                    self.cvMoviesList.isHidden = false
                    self.lblNoData.isHidden = true
                } else {
                    self.cvMoviesList.isHidden = true
                    self.lblNoData.isHidden = false
                }
            } else {
                mainThread {
                    self.view.makeToast(Utility().wsFailResponseMessage(responseData: responseData!))
                    
                    if self.arrMoviesList.count == 0 {
                        self.arrMoviesList = [MoviesList]()
                        
                        self.cvMoviesList.isHidden = true
                        self.lblNoData.isHidden = false
                    }
                    
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    self.isBottomRefresh = false
                }
            }
        }
    }
}

//MARK: - UICollectionViewDelegate & UICollectionViewDataSource Extension
extension MoviesListVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isSearch ? arrSearchMoviesList.count : arrMoviesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (isSearch ? arrSearchMoviesList[indexPath.row].vote_average ?? 0.0 : arrMoviesList[indexPath.row].vote_average ?? 0.0) >= 7.0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.kCellPopularMovies, for: indexPath) as! MoviesListCVC
            
            cell.imgvMovies.sd_setImage(with: URL(string: "\(WebServiceURL.loadBackDropURL)\(isSearch ? arrSearchMoviesList[indexPath.row].backdrop_path ?? "" : arrMoviesList[indexPath.row].backdrop_path ?? "")"), completed: nil)
            
            cell.btnDelete.tag = indexPath.row
            cell.btnDelete.addTarget(self, action: #selector(btnDeleteAction(_:)) , for: .touchUpInside)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.kCellUnPopularMovies, for: indexPath) as! MoviesListCVC
            
            cell.imgvMovies.sd_setImage(with: URL(string: "\(WebServiceURL.loadPosterURL)\(isSearch ? arrSearchMoviesList[indexPath.row].poster_path ?? "" : arrMoviesList[indexPath.row].poster_path ?? "")"), completed: nil)
            
            cell.lblTitle.text = isSearch ? arrSearchMoviesList[indexPath.row].title ?? "" : arrMoviesList[indexPath.row].title ?? ""
            
            cell.lblOverview.text = isSearch ? arrSearchMoviesList[indexPath.row].overview ?? "" : arrMoviesList[indexPath.row].overview ?? ""
            
            cell.btnDelete.tag = indexPath.row
            cell.btnDelete.addTarget(self, action: #selector(btnDeleteAction(_:)) , for: .touchUpInside)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let objMovieDetailsVC = AllStoryBoard.Main.instantiateViewController(withIdentifier: ViewControllerName.kMovieDetailsVC) as! MovieDetailsVC
        objMovieDetailsVC.dictMovieDetails = isSearch ? arrSearchMoviesList[indexPath.row] : arrMoviesList[indexPath.row]
        self.navigationController?.pushViewController(objMovieDetailsVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: collectionView.frame.size.width, height: 300)
        return size
    }
}

//MARK: - UITextFieldDelegate Extension
extension MoviesListVC : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.returnKeyType == UIReturnKeyType.next {
            textField.superview?.superview?.superview?.viewWithTag(textField.tag + 1)?.becomeFirstResponder()
        } else if textField.returnKeyType == UIReturnKeyType.done {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == txtSearchMovies {
            let strTextFieldValue: NSString = (textField.text ?? "") as NSString
            let strSearchText = strTextFieldValue.replacingCharacters(in: range, with: string)
            
            if Int(strSearchText.count) > 0 {
                isSearch = true
            } else if Int(strSearchText.count) == 0 {
                isSearch = false
                
                textField.text = ""
                textField.resignFirstResponder()
            }
            
            if isSearch {
                arrSearchMoviesList = arrMoviesList.filter({($0.title ?? "").lowercased().contains(strSearchText)})
            }
            
            cvMoviesList.reloadData()
        }
        
        return true
    }
}
