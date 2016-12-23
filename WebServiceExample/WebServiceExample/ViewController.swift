//
//  ViewController.swift
//  WebServiceExample
//
//  Created by Patrick Donahue on 12/22/16.
//  Copyright © 2016 Patrick Donahue. All rights reserved.
//
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var forecastLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        let manager = AFHTTPSessionManager()
        
        self.forecastLabel.text = ""
        
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        view.addSubview(activityIndicatorView)
        activityIndicatorView.center = view.center
        activityIndicatorView.startAnimating()

        
        manager.get("http://api.openweathermap.org/data/2.5/forecast/daily?q=London&mode=json&units=metric&cnt=1&appid=6412692c30fa26199bdd5b9ba5e1cff1",
                    parameters: nil,
                    progress: nil,
                    success: { (operation: URLSessionDataTask, responseObject:Any?) in

                        let json = JSON(responseObject)
                        print(json)
//                        let forecast = json["list"][0]["temp"]["max"]
//                        print(forecast)
                        
                        if let forecast = json["list"][0]["weather"][0]["description"].string {
                            self.forecastLabel.text = forecast
                        }

                        if let temp = json["list"][0]["temp"]["max"].float {
                            print(temp)
                            switch temp {
                            case 1..<20:
                                self.view.backgroundColor = UIColor.blue
                            case 21..<30:
                                self.view.backgroundColor = UIColor.yellow
                            case 30..<40:
                                self.view.backgroundColor = UIColor.red
                            default:
                                self.view.backgroundColor = UIColor.gray
                            }
                            activityIndicatorView.removeFromSuperview()

                        }
                        
//                        if let listOfDays = (responseObject as AnyObject)["list"] as? [AnyObject] {
//                            if let tomorrow = listOfDays[0] as? [String:AnyObject] {
//                                if let tomorrowsWeather = tomorrow["weather"] as? [AnyObject] {
//                                    if let firstWeatherOfDay = tomorrowsWeather[0] as? [String:AnyObject] {
//                                        if let forecast = firstWeatherOfDay["description"] as? String {
//                                            self.forecastLabel.text = forecast
//                                        }
//                                    }
//                                }
//                            }
//                       }
        }) { (operation:URLSessionDataTask?, error:Error) in
            print("Error: " + error.localizedDescription)
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

