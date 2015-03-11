//  PlayersVC.swift
//  Created by Justin Lynch on 3/10/15.
//  Copyright (c) 2015 jlynch.co. All rights reserved.

import UIKit
import Fabric
import Parse
import TwitterKit
import Foundation

class PlayersVC: UIViewController {
    var contacts : DGTContacts = DGTContacts(userSession: Digits.sharedInstance().session())

    override func viewDidLoad() {
        super.viewDidLoad()
        startContactUpload()
    
    }
    
    func startContactUpload() {
        
        contacts.startContactsUploadWithPresenterViewController(self, title: "Find Your Friends") { (result, error) -> Void in
            if error == nil {
                println(result.description)
                let results : DGTContactsUploadResult = result
                let numUploaded = results.numberOfUploadedContacts
                let total = results.totalContacts
                println(numUploaded)
                println(total)
                self.startMatches()
            } else {
                println(error.description)
            }
        }
        
    }
    
    func startMatches() {
        contacts.lookupContactMatchesWithCursor(nil, completion: { (matches, nextCursor, error) -> Void in
            if error == nil {
                println(matches.description)
                var matchAr = matches
                var nCurs = nextCursor
                println(matchAr)
                println(nCurs)
                self.deleteFromFab()
            } else {
                println(error.description)
            }
        })
    }
    
    func deleteFromFab(){
        contacts.deleteAllUploadedContactsWithCompletion { (error) -> Void in
            if error == nil {
                println("Contacts deleted from Fabric")
            } else {
                println(error.description)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
