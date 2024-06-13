//
//  TabController.swift
//  myGameApp
//
//  Created by Emmanuel Uduma
//  @00566883
//
//  This tab controller controlls the tab that the user can use after
//  palying to quickly navigate to settings, main page or a new game 
//

//..............Import Statements...........................................................................
import UIKit


class TabController: UITabBarController {

    // Define the titles and image names for tab bar items
    let tabBarItemTitles = ["Main Page", "Settings", "New Game"]
    let tabBarItemImageNames = ["heart", "heart", "heart"]

    override func viewDidLoad() { //on load
        super.viewDidLoad()

        // Customize each tab bar item
        if let viewControllers = self.viewControllers {
            for (index, viewController) in viewControllers.enumerated() {
                let tabBarItem = viewController.tabBarItem

                tabBarItem?.title = tabBarItemTitles[index] // Set tab bar item title

                // Set custom image for tab bar item
                if let image = UIImage(named: tabBarItemImageNames[index]) {
                    let resizedImage = resizeImage(image: image, targetSize: CGSize(width: 40, height: 40))
                    tabBarItem?.image = resizedImage.withRenderingMode(.alwaysOriginal)
                }

                // Customize tab bar item text attributes
                let attributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 24.0),  // Set custom font size
                    .foregroundColor: UIColor.orange          // Set custom text color
                ]
                tabBarItem?.setTitleTextAttributes(attributes, for: .normal)
                
                // Set selected tab bar item text color
                let selectedAttributes: [NSAttributedString.Key: Any] = [
                    .foregroundColor: UIColor.blue    // Customize selected text color
                ]
                tabBarItem?.setTitleTextAttributes(selectedAttributes, for: .selected)
       
                tabBar.barTintColor = UIColor.blue  // Set custom tab bar background color
            }
        }
    }

    //method to resize tab bar item images 
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        let scaledImage = renderer.image { (context) in
            image.draw(in: CGRect(origin: .zero, size: targetSize))
        }
        return scaledImage
    }
    //............................................................. END OF CLASS ............................................................
}


