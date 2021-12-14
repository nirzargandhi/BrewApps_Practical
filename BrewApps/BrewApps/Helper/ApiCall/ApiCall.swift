//
//  ApiCall.swift

class ApiCall: NSObject {
    
    let constValueField = "application/x-www-form-urlencoded"
    let constHeaderField = "Content-Type"
    
    func post<T : Decodable ,A>(apiUrl : String, requestPARAMS: [String: A], model: T.Type, isLoader : Bool = true, isErrorToast : Bool = true, isAPIToken : Bool = false, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        requestMethod(apiUrl: apiUrl, params: requestPARAMS as [String : AnyObject], method: "POST", model: model, isLoader : isLoader, isErrorToast : isErrorToast, isAPIToken : isAPIToken, completion: completion)
    }
    
    func put<T : Decodable ,A>(apiUrl : String, requestPARAMS: [String: A], model: T.Type, isLoader : Bool = true, isErrorToast : Bool = true, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        requestMethod(apiUrl:apiUrl, params: requestPARAMS as [String : AnyObject], method: "PUT",model: model , isLoader : isLoader, isErrorToast : isErrorToast, completion: completion)
    }
    
    func get<T : Decodable>(apiUrl : String, model: T.Type, isLoader : Bool = true, isErrorToast : Bool = true, isAPIToken : Bool = false, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        requestGetMethod(apiUrl: apiUrl, method: "GET", model: model, isLoader : isLoader, isErrorToast : isErrorToast, isAPIToken : isAPIToken, completion: completion)
    }
    
    func delete<T : Decodable>(apiUrl : String, model: T.Type, isLoader : Bool = true, isErrorToast : Bool = true, isAPIToken : Bool = false, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        requestDeleteMethod(apiUrl: apiUrl, method: "DELETE", model: model, isLoader : isLoader, isErrorToast : isErrorToast, isAPIToken : isAPIToken, completion: completion)
    }
    
    func requestMethod<T : Decodable>(apiUrl : String, params: [String: AnyObject], method: NSString, model: T.Type ,isLoader : Bool = true, isErrorToast : Bool = true, isAPIToken : Bool = false, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        if isLoader {
            Utility().showLoader()
        }
        
        var request = URLRequest(url: URL(string: apiUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!)
        request.httpMethod = method as String
        request.setValue(constValueField, forHTTPHeaderField: constHeaderField)
        
        let jsonTodo: NSData
        do {
            jsonTodo = try JSONSerialization.data(withJSONObject: params, options: []) as NSData
            request.httpBody = jsonTodo as Data
        } catch {
            print("Error: cannot create JSON from todo")
            return
        }
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task: URLSessionDataTask = session.dataTask(with : request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            Utility().hideLoader()
            
            guard let data = data, error == nil else {
                return
            }
            
            let decoder = JSONDecoder()
            do {
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    print(convertedJsonIntoDict)
                }
                
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    let dictResponse = try decoder.decode(model, from: data)
                    mainThread {
                        completion(true, dictResponse as AnyObject)
                    }
                } else {
                    let dictResponse = try decoder.decode(GeneralResponseModal.self, from: data)
                    mainThread {
                        completion(false, dictResponse.status_message as AnyObject)
                    }
                }
                
            } catch let error as NSError {
                print("\n\n===========Error===========")
                print("Error Code: \(error._code)")
                print("Error Messsage: \(error.localizedDescription)")
                if let str = String(data: data, encoding: String.Encoding.utf8){
                    print("Print Server data:- " + str)
                }
                debugPrint(error)
                print("===========================\n\n")
                
                debugPrint(error)
                completion(false, error as AnyObject)
            }
        })
        task.resume()
    }
    
    func requestGetMethod<T : Decodable>(apiUrl : String, method: String, model: T.Type, isLoader : Bool = true, isErrorToast : Bool = true, isAPIToken : Bool = false, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        if isLoader {
            Utility().showLoader()
        }
        
        var request = URLRequest(url: URL(string: apiUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!)
        
        request.httpMethod = method
        request.addValue(constValueField, forHTTPHeaderField: constHeaderField)
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task: URLSessionDataTask = session.dataTask(with : request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            Utility().hideLoader()
            
            guard let data = data, error == nil else {
                completion(false, nil)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    print(convertedJsonIntoDict)
                }
                
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    let dictResponse = try decoder.decode(model, from: data)
                    mainThread {
                        completion(true, dictResponse as AnyObject)
                    }
                } else {
                    let dictResponse = try decoder.decode(GeneralResponseModal.self, from: data)
                    mainThread {
                        completion(false, dictResponse.status_message as AnyObject)
                    }
                }
                
            } catch let error as NSError {
                print("\n\n===========Error===========")
                print("Error Code: \(error._code)")
                print("Error Messsage: \(error.localizedDescription)")
                if let str = String(data: data, encoding: String.Encoding.utf8){
                    print("Print Server data:- " + str)
                }
                debugPrint(error)
                print("===========================\n\n")
                
                debugPrint(error)
                completion(false, error as AnyObject)
            }
        })
        task.resume()
    }
    
    func requestDeleteMethod<T : Decodable>(apiUrl : String, method: String, model: T.Type, isLoader : Bool = true, isErrorToast : Bool = true, isAPIToken : Bool = false, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        if isLoader {
            Utility().showLoader()
        }
        
        var request = URLRequest(url: URL(string: apiUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!)
        
        request.httpMethod = method
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task: URLSessionDataTask = session.dataTask(with : request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            Utility().hideLoader()
            
            guard let data = data, error == nil else {
                completion(false, nil)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    print(convertedJsonIntoDict)
                }
                
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    let dictResponse = try decoder.decode(model, from: data)
                    mainThread {
                        completion(true, dictResponse as AnyObject)
                    }
                } else {
                    let dictResponse = try decoder.decode(GeneralResponseModal.self, from: data)
                    mainThread {
                        completion(false, dictResponse.status_message as AnyObject)
                    }
                }
                
            } catch let error as NSError {
                print("\n\n===========Error===========")
                print("Error Code: \(error._code)")
                print("Error Messsage: \(error.localizedDescription)")
                if let str = String(data: data, encoding: String.Encoding.utf8){
                    print("Print Server data:- " + str)
                }
                debugPrint(error)
                print("===========================\n\n")
                
                debugPrint(error)
                completion(false, error as AnyObject)
            }
        })
        task.resume()
    }
}

//MARK: - GeneralResponseModal Class
struct GeneralResponseModal : Codable {
    let status_code : Int?
    let status_message : String?
    let success : Bool?
    let page : Int?
    let results : [String]?
    let total_pages : Int?
    let total_results : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case status_code = "status_code"
        case status_message = "status_message"
        case success = "success"
        case page = "page"
        case results = "results"
        case total_pages = "total_pages"
        case total_results = "total_results"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status_code = try values.decodeIfPresent(Int.self, forKey: .status_code)
        status_message = try values.decodeIfPresent(String.self, forKey: .status_message)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        results = try values.decodeIfPresent([String].self, forKey: .results)
        total_pages = try values.decodeIfPresent(Int.self, forKey: .total_pages)
        total_results = try values.decodeIfPresent(Int.self, forKey: .total_results)
    }
}
