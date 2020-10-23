//
//  ViewController.swift
//  myFirstApp
//
//  Created by Olivier on 21/10/2020.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var movies: Array<MovieObject> = []
    var searchParameter = ""
    
    @IBOutlet weak var generalTabView: UITableView!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var refreshButton: UIButton!
    
    func loadMovies(){
        print("load movies")
        if let url = URL(string: "https://www.omdbapi.com/?s="+self.searchParameter+"&apikey=e238f827"){
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                if let error = error {
                    print("\(error)")
                }
        
                if let data = data {
                    do{
                        let jsonDecoder = JSONDecoder()
                        let jsonDecode: Movie = try jsonDecoder.decode(Movie.self, from: data)
                        self.movies = jsonDecode.movieObject
                        DispatchQueue.main.async {
                            self.generalTabView.reloadData()
                        }
                    } catch DecodingError.dataCorrupted {
                        print("error = dataCorrupted")
                    } catch DecodingError.keyNotFound {
                        print("error = keyNotFound")
                    } catch DecodingError.typeMismatch {
                        print("error = typeMismatch")
                    } catch DecodingError.valueNotFound {
                        print("error = valueNotFound")
                    } catch {
                        print("error")
                    }
                }
            }.resume()
        } else {
            self.movies = []
            DispatchQueue.main.async {
                self.generalTabView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.generalTabView.delegate = self
        self.generalTabView.dataSource = self
        
        self.searchTextField.becomeFirstResponder()
        self.generalTabView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        
        refreshButton.setImage( UIImage.init(named: "refresh"), for: .normal)
        
        self.loadMovies()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.movies.count > 0 {
            return self.movies.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.movies.count > 0 {
            if let myCell = self.generalTabView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as? MovieTableViewCell{
                if let posterURL = URL(string: self.movies[indexPath.row].poster) {
                    do {
                        DispatchQueue.global().async {
                            do {
                                let posterData = try Data(contentsOf: posterURL)
                                let posterImage: UIImage? = UIImage(data: posterData)
                                    DispatchQueue.main.async {
                                        myCell.myMoviePoster.image = posterImage
                                    }
                            } catch DecodingError.dataCorrupted {
                                print("error = dataCorrupted")
                            } catch DecodingError.keyNotFound {
                                print("error = keyNotFound")
                            } catch DecodingError.typeMismatch {
                                print("error = typeMismatch")
                            } catch DecodingError.valueNotFound {
                                print("error = valueNotFound")
                            } catch {
                                print("error")
                            }
                        }
                    }
                }
                
                myCell.myMovieLabel.text = self.movies[indexPath.row].name
                
                if (indexPath.row % 2 == 0) {
                    myCell.backgroundColor = UIColor(rgb: 0xFFFFFF) // set your default color
                } else {
                    myCell.backgroundColor = UIColor(rgb: 0xDCDCDC)
                }
                
                return myCell
            }
        } else {
            if let myCell = self.generalTabView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as? MovieTableViewCell{
                
                myCell.myMovieLabel.numberOfLines=0
                myCell.myMovieLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
                
                myCell.myMoviePoster.image = #imageLiteral(resourceName: "three_dots")
                
                myCell.myMovieLabel.text = "Il n'y a aucun film à afficher. Vous pouvez effectuer votre recherche en haut de l'écran"
                return myCell
            }
        }
        return UITableViewCell()
    }
    
    @IBAction func searchAction(_ sender: UITextField) {
        self.searchParameter = sender.text ?? ""
        self.loadMovies()
    }
    
    @IBAction func searchDidEndAction(_ sender: UITextField) {
        self.searchParameter = sender.text ?? ""
        self.loadMovies()
    }
    
    @IBAction func refreshActionTouchDown(_ sender: UIButton) {
        self.loadMovies()
    }
}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
