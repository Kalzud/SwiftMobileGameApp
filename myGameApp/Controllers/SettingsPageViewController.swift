//
//  SettingsPageViewController.swift
//  myGameApp
//
//  Created by Emmanuel Uduma.
//  @00566883
//
//  This is the controller for the settings page which contoels the view and functions it

//..............Import Statements...........................................................................
import UIKit


class SettingsPageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    let gameDataManager = GameDataManager.shared // Access the shared GameDataManager instance
    let cellIdentifier = "myCellIdentifier" // assigning field with identifier of table cell
    
    //.............Settings objects and arraylist...........................
    var settingsOptions = [SettingsOptionsObject]()
    let lightThemeOption = LightThemeOption()
    let darkThemeOption = DarkThemeOption()
    let soundOffOption = SoundOffOption()
    let soundOnOption = SoundOnOption()

    //load function
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = gameDataManager.backgroundColor
        
        // add objects to arraylist............................
        settingsOptions.append(lightThemeOption)
        settingsOptions.append(darkThemeOption)
        settingsOptions.append(soundOffOption)
        settingsOptions.append(soundOnOption)
        
        // Set custom text color for tab bar item.......................
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 24.0),
            .foregroundColor: UIColor.orange
        ]
        tabBarItem.setTitleTextAttributes(attributes, for: .normal)
    }
    
    open func getSettingsOptions()->[SettingsOptionsObject]{
        return settingsOptions
    }
    
    // MARK: - TABLE METHODS
    // Implement UITableViewDelegate methods to customize cell height and spacing =======================================================
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60 // Adjust cell height as needed
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20 // Add space at the bottom of each section
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20 // Add space at the top of each section
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getSettingsOptions().count
    }
    
    // =========================== Set up each cell in the table ========================================================================
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath)
        let settingsOPtions = getSettingsOptions();
        cell.textLabel?.text = settingsOPtions[indexPath.row].getText()
        cell.textLabel?.textColor = UIColor.orange // Set text color to orange
        cell.imageView?.image = settingsOPtions[indexPath.row].getImage()
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    // ================== Calling delegate method to customize the action for cell selection =====================================================
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         // Retrieve the selected SettingsOptionsObject
         let selectedOption = settingsOptions[indexPath.row]

         // ............................ Check if the selected option and call on its object clicked ............................................
         if let lightThemeOption = selectedOption as? LightThemeOption {
             lightThemeOption.onObjectClicked()
             view.backgroundColor = .white
         }else if let darkThemeOption = selectedOption as? DarkThemeOption{
             darkThemeOption.onObjectClicked()
             view.backgroundColor = .black
         }else if let soundOnOption = selectedOption as? SoundOnOption{
             soundOnOption.onObjectClicked()
         }else if let soundOffOption = selectedOption as? SoundOffOption{
             soundOffOption.onObjectClicked()
         }

         // Deselect the row to visually show the tap feedback
         tableView.deselectRow(at: indexPath, animated: true)
     }
    
    // resize cell image ..................................
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        let scaledImage = renderer.image { (context) in
            image.draw(in: CGRect(origin: .zero, size: targetSize))
        }
        return scaledImage
    }
//.................................................. END OF CLASS ..........................................................................
}
