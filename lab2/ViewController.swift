//
//  ViewController.swift
//  lab2
//
//  Created by Brad Hodkinson on 9/19/18.
//  Copytrailing © 2018 Brad Hodkinson. All trailings reserved.
//

import UIKit

class ViewController: UIViewController {
    //create private variables used throughout the view controller class
    private var pets:[Pet] = Array()
    private let padding = CGFloat(10)
    
    private var statsStackView = UIStackView()
    private var actionButtonStackView = UIStackView()
    private var bottomButtonStackView = UIStackView()
    
    var bottomButtonViews:[UIView] = Array()
    
    private let playButtonView = UIView()
    private let feedButtonView = UIView()
    private let happinessView = UIView()
    private let foodView = UIView()
    
    private var bird:Pet!
    private var bunny:Pet!
    private var cat:Pet!
    private var dog:Pet!
    private var fish:Pet!
    private var scooby:Pet!
    private var currentPet:Pet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //create all the pets and add them to an arrays of pets
        bird = Pet(name: "Tweety", petType: .bird, imageName: "bird", color: .yellow)
        pets.append(bird)
        bunny = Pet(name: "Bugs", petType: .bunny, imageName: "bunny", color: .magenta)
        pets.append(bunny)
        cat = Pet(name: "Felix", petType: .cat, imageName: "cat", color: UIColor(red: 135/255, green: 205/255, blue: 250/255, alpha: 1))
        pets.append(cat)
        dog = Pet(name: "Buddy", petType: .dog, imageName: "dog", color: .red)
        pets.append(dog)
        fish = Pet(name: "Nemo", petType: .fish, imageName: "fish", color: .purple)
        pets.append(fish)
        //default the current pet to bird when app loads by setting a pointer to the bird
        currentPet = bird
    
        //create the structure of the app
        createBottomButtonBar()
        createStatsDisplay()
        createActionButtons()
        updateDisplay()
    }
    
    //function to update the pet display with new value being loaded in from a new pet being selected
    func updateDisplay(){
        happinessDisplayView.color = currentPet.color
        happinessDisplayView.value = CGFloat(Double(currentPet.happinessLevel)/10.0)
        happinessLevelLabel.text = "played: \(currentPet.happinessLevel)"
        foodDisplayView.color = currentPet.color
        foodDisplayView.value = CGFloat(Double(currentPet.foodLevel)/10.0)
        foodLevelLabel.text = "fed: \(currentPet.foodLevel)"
        petNameLabel.text = currentPet.name
        createPetView()
    }
    
    //function to create the bottom buttons that are used to select the pet
    func createBottomButtonBar(){
        //create an array of pet buttons
        var bottomButtons:[UIButton] = Array()
        //for each pet create a button and view so it can be added to the stack view
        for pet in pets {
            let tempButton = createPetButton(name: pet.imageName.capitalized)
            let tempView = UIView()
            tempButton.translatesAutoresizingMaskIntoConstraints = false
            bottomButtons.append(tempButton)
            tempView.addSubview(tempButton)
            bottomButtonViews.append(tempView)
        }
        //add all the pet views created to the stack view
        bottomButtonStackView = UIStackView(arrangedSubviews: bottomButtonViews)
        //settings for the stack view
        bottomButtonStackView.axis = .horizontal
        bottomButtonStackView.distribution = .fillEqually
        
        //add the stack view to the main view
        view.addSubview(bottomButtonStackView)
        
        //enable auto layout
        bottomButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        //constraints for auto layout for the stack view with the buttons for selecting a pet
        NSLayoutConstraint.activate([
            bottomButtonStackView.heightAnchor.constraint(equalToConstant: 50),
            bottomButtonStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            bottomButtonStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            bottomButtonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            ])
        //for each button set constraints to it respective view
        var i = 0
        for tempButton in bottomButtons {
            NSLayoutConstraint.activate([
                tempButton.topAnchor.constraint(equalTo: bottomButtonViews[i].topAnchor, constant: 0),
                tempButton.leadingAnchor.constraint(equalTo: bottomButtonViews[i].leadingAnchor, constant: 0),
                tempButton.trailingAnchor.constraint(equalTo: bottomButtonViews[i].trailingAnchor, constant: 0),
                tempButton.bottomAnchor.constraint(equalTo: bottomButtonViews[i].bottomAnchor, constant: 0),
                ])
            i += 1
        }
    }
    
    //function for creating a pet button that is used to switch the current pet
    private func createPetButton(name: String) -> UIButton{
        //let petButtonFrame = CGRect(x: 0, y: 0, width: 20, height: 15)
        let petButton = UIButton(type: .system)
        //petButton.frame = petButtonFrame
        petButton.setTitle(name, for: .normal)
        petButton.addTarget(self, action: #selector(changePet(_:)), for: UIControl.Event.touchDown)
        //custom font
        petButton.titleLabel?.font =  UIFont(name: "gameovercre", size: 15)
        return petButton
    }

    //view for the pet frame
    let petView: UIView = {
        let petFrame = CGRect(x: 200, y: 200, width: 300, height: 300)
        let petView = UIView(frame: petFrame)
        return petView
    }()
    
    //image button so pet can be clicked
    let petImageButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(makePetNoise(_:)), for: UIControl.Event.touchDown)
        return button
    }()
    
    //label for the pet name
    let petNameLabel: UILabel = {
        var frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        let label = UILabel(frame: frame)
        label.text = "Nemo"
        label.font = UIFont(name: "gameovercre", size: 17.0)
        return label
    }()
    
    //view for the happiness stats
    let happinessDisplayView: DisplayView = {
        let displayView = DisplayView()
        return displayView
    }()
    
    //view for the food stats
    let foodDisplayView: DisplayView = {
        let displayView = DisplayView()
        return displayView
    }()
    
    //happiness label
    let happinessLabel: UILabel = {
        var labelFrame = CGRect(x: 0, y: 0, width: 10, height: 10)
        let label = UILabel(frame: labelFrame)
        label.text = "Happiness"
        label.font = UIFont(name: "gameovercre", size: 17.0)
        return label
    }()
    
    //label for the current level of happiness
    let happinessLevelLabel: UILabel = {
        var labelFrame = CGRect(x: 0, y: 0, width: 10, height: 10)
        let label = UILabel(frame: labelFrame)
        label.text = "played: 0"
        label.textColor = UIColor.gray
        label.font = UIFont(name: "gameovercre", size: 17.0)
        return label
    }()
    
    //label for food
    let foodLabel: UILabel = {
        var labelFrame = CGRect(x: 0, y: 0, width: 10, height: 10)
        let label = UILabel(frame: labelFrame)
        label.text = "Food Level"
        label.font = UIFont(name: "gameovercre", size: 17.0)
        return label
    }()

    //label for the current level of food
    let foodLevelLabel: UILabel = {
        var labelFrame = CGRect(x: 0, y: 0, width: 10, height: 10)
        let label = UILabel(frame: labelFrame)
        label.text = "fed: 0"
        label.textColor = UIColor.gray
        label.font = UIFont(name: "gameovercre", size: 17.0)
        return label
    }()

    //closure for creating button to play with the pet
    let playButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Play", for: .normal)
        button.backgroundColor = UIColor(white: 0.9, alpha: 1)
        button.addTarget(self, action: #selector(playPet(_:)), for: UIControl.Event.touchDown)
        button.titleLabel?.font =  UIFont(name: "gameovercre", size: 17)
        return button
    }()
    
    //closure for creating button to feed the pet
    let feedButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Feed", for: .normal)
        button.backgroundColor = UIColor(white: 0.9, alpha: 1)
        button.addTarget(self, action: #selector(feedPet(_:)), for: UIControl.Event.touchDown)
        button.titleLabel?.font =  UIFont(name: "gameovercre", size: 17)
        return button
    }()
    
    //function to create the main pet view with image background color and pet name
    func createPetView(){
        //change background color to current pet color
        petView.backgroundColor = currentPet.color
        //add the pet view to the main view
        view.addSubview(petView)
        //add the name of the pet to the pet view
        petView.addSubview(petNameLabel)
        
        //enable auto layout
        petView.translatesAutoresizingMaskIntoConstraints = false
        petNameLabel.translatesAutoresizingMaskIntoConstraints = false
        //auto layout constraints for the pet view
        NSLayoutConstraint.activate([
            //constrain the pet view to the top of the screen
            petView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            petView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            petView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            petView.bottomAnchor.constraint(equalTo: actionButtonStackView.topAnchor, constant: -padding)
            ])
        
        //update the pet image to the current pet
        let petImage = UIImage(named: currentPet.imageName)
        petImageButton.setBackgroundImage(petImage, for: .normal)
        //add the pet image button to the main view
        view.addSubview(petImageButton)
        
        //allow for auto layout
        petImageButton.translatesAutoresizingMaskIntoConstraints = false
        //center image horizontally in the pet view
        petImageButton.centerXAnchor.constraint(equalTo: petView.centerXAnchor).isActive = true
        //center the image vertically in the pet view
        petImageButton.centerYAnchor.constraint(equalTo: petView.centerYAnchor).isActive = true
        //set the width of the image
        petImageButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        //set the height of the image
        petImageButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        //autolayout for the pet name
        petNameLabel.bottomAnchor.constraint(equalTo: petImageButton.topAnchor, constant: -padding).isActive = true
        petNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        petNameLabel.centerXAnchor.constraint(equalTo: petView.centerXAnchor, constant: 0).isActive = true
    }
    
    //function to create the action buttons that will play and feed the pet
    func createActionButtons(){
        //create the stack view with the play and feed button subviews
        actionButtonStackView = UIStackView(arrangedSubviews: [playButtonView, feedButtonView])
        
        //settings for the stack view with play and feed button
        actionButtonStackView.axis = .horizontal
        actionButtonStackView.distribution = .fillEqually
        actionButtonStackView.spacing = padding*4
        
        //add the play and feed button to their own subviews
        playButtonView.addSubview(playButton)
        feedButtonView.addSubview(feedButton)
        
        //add the stack view with the play and feed button to the main view
        view.addSubview(actionButtonStackView)
        
        //enable auto layout
        actionButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        playButton.translatesAutoresizingMaskIntoConstraints = false
        feedButton.translatesAutoresizingMaskIntoConstraints = false

        //auto layout for the stack view with play and feed buttons
        NSLayoutConstraint.activate([
            //auto layout for the stack view that contains the play and feed buttons
            actionButtonStackView.heightAnchor.constraint(equalToConstant: 30),
            actionButtonStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            actionButtonStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            actionButtonStackView.bottomAnchor.constraint(equalTo: statsStackView.topAnchor, constant: -padding),
            //auto layout for the button to play with the current pet
            playButton.topAnchor.constraint(equalTo: playButtonView.topAnchor, constant: 0),
            playButton.leadingAnchor.constraint(equalTo: playButtonView.leadingAnchor, constant: 0),
            playButton.trailingAnchor.constraint(equalTo: playButtonView.trailingAnchor, constant: 0),
            playButton.bottomAnchor.constraint(equalTo: playButtonView.bottomAnchor, constant: 0),
            //auto layout for the button to feed the current pet
            feedButton.topAnchor.constraint(equalTo: feedButtonView.topAnchor, constant: 0),
            feedButton.leadingAnchor.constraint(equalTo: feedButtonView.leadingAnchor, constant: 0),
            feedButton.trailingAnchor.constraint(equalTo: feedButtonView.trailingAnchor, constant: 0),
            feedButton.bottomAnchor.constraint(equalTo: feedButtonView.bottomAnchor, constant: 0)
            ])
    }
    
    //funtion to create the stats display for the food and happiness
    func createStatsDisplay(){
        happinessView.addSubview(happinessLabel)
        happinessView.addSubview(happinessLevelLabel)
        
        foodView.addSubview(foodLabel)
        foodView.addSubview(foodLevelLabel)
        
        happinessView.addSubview(happinessDisplayView)
        foodView.addSubview(foodDisplayView)
        
        //add the happiness and food stats to the stack view
        statsStackView = UIStackView(arrangedSubviews: [happinessView, foodView])
        statsStackView.distribution = .fillEqually
        
        //depending on the device current orientation change the padding and the stack view axis
        if UIDevice.current.orientation.isLandscape {
            statsStackView.axis = .horizontal
            statsStackView.spacing = padding*4
        } else {
            statsStackView.axis = .vertical
            statsStackView.spacing = padding
        }
        
        //add the stats stack view to the main view
        view.addSubview(statsStackView)
        
        //allow for auto layout
        statsStackView.translatesAutoresizingMaskIntoConstraints = false
        happinessDisplayView.translatesAutoresizingMaskIntoConstraints = false
        foodDisplayView.translatesAutoresizingMaskIntoConstraints = false
        happinessLabel.translatesAutoresizingMaskIntoConstraints = false
        happinessLevelLabel.translatesAutoresizingMaskIntoConstraints = false
        foodLabel.translatesAutoresizingMaskIntoConstraints = false
        foodLevelLabel.translatesAutoresizingMaskIntoConstraints = false
        //constraints for auto layout
        NSLayoutConstraint.activate([
            statsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            statsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            statsStackView.bottomAnchor.constraint(equalTo: bottomButtonStackView.topAnchor, constant: 0),
            
            foodView.heightAnchor.constraint(equalToConstant: 60),
            happinessView.heightAnchor.constraint(equalToConstant: 60),
            
            happinessDisplayView.topAnchor.constraint(equalTo: happinessView.centerYAnchor, constant: padding),
            happinessDisplayView.leadingAnchor.constraint(equalTo: happinessView.leadingAnchor, constant: 0),
            happinessDisplayView.trailingAnchor.constraint(equalTo: happinessView.trailingAnchor, constant: 0),
            happinessDisplayView.bottomAnchor.constraint(equalTo: happinessView.bottomAnchor, constant: 0),
            
            foodDisplayView.topAnchor.constraint(equalTo: foodView.centerYAnchor, constant: padding),
            foodDisplayView.leadingAnchor.constraint(equalTo: foodView.leadingAnchor, constant: 0),
            foodDisplayView.trailingAnchor.constraint(equalTo: foodView.trailingAnchor, constant: 0),
            foodDisplayView.bottomAnchor.constraint(equalTo: foodView.bottomAnchor, constant: 0),
            
            happinessLabel.leadingAnchor.constraint(equalTo: happinessView.leadingAnchor, constant: 0),
            happinessLabel.bottomAnchor.constraint(equalTo: happinessView.centerYAnchor, constant: 0),
            
            happinessLevelLabel.trailingAnchor.constraint(equalTo: happinessView.trailingAnchor, constant: 0),
            happinessLevelLabel.bottomAnchor.constraint(equalTo: happinessView.centerYAnchor, constant: 0),
            
            foodLabel.leadingAnchor.constraint(equalTo: foodView.leadingAnchor, constant: 0),
            foodLabel.bottomAnchor.constraint(equalTo: foodView.centerYAnchor, constant: 0),
            
            foodLevelLabel.trailingAnchor.constraint(equalTo: foodView.trailingAnchor, constant: 0),
            foodLevelLabel.bottomAnchor.constraint(equalTo: foodView.centerYAnchor, constant: 0)
            ])
    }
    
    //override function that handles the transition of the orientation of the phone
    //changes how pet levels are displayed depending if it is in landscape or portrait
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            statsStackView.axis = .horizontal
            statsStackView.spacing = padding*4
        } else {
            statsStackView.axis = .vertical
            statsStackView.spacing = padding
        }
    }
    
    //function to unlock a hidden pet if the user beats the game
    func unlockHiddenPet(){
        bottomButtonStackView.subviews.forEach {
            $0.removeFromSuperview()
        }
        bottomButtonViews.removeAll()
        scooby = Pet(name: "Scooby", petType: .scooby, imageName: "scooby", color: UIColor(red: 138/255, green: 43/255, blue: 226/255, alpha: 1))
        pets.append(scooby)
        createBottomButtonBar()
    }

    //function to have the current pet make a custom noise
    @objc func makePetNoise(_ sender: UIButton){
        //have the current pet make noise
        currentPet.makeNoise()
    }
    
    //function to play with the pet
    @objc func playPet(_ sender: UIButton){
        //play with the current pet
        currentPet.play()
        
        //if current pet is at the max level check if they won the game
        if(currentPet.happinessLevel == 10){
            var gameWonFlag = true
            for pet in pets {
                if(pet.happinessLevel != 10){
                    gameWonFlag = false
                }
            }
            if(gameWonFlag){
                unlockHiddenPet()
            }
        }
        //update the display so the pet stats get updated
        updateDisplay()
        
    }
    
    //function to feed the pet
    @objc func feedPet(_ sender: UIButton){
        //feed the current pet
        currentPet.feed()
        //update the display so the pet stats get updated
        updateDisplay()
    }
    
    //Function to change the current pet
    @objc func changePet(_ sender: UIButton){
        //make the current pet stop making noise if the pet is switched
        currentPet.stopNoise()
        
        //change the pet based off the pet button that was selected
        switch sender.currentTitle {
        case "Bird":
            currentPet = bird
        case "Bunny":
            currentPet = bunny
        case "Cat":
            currentPet = cat
        case "Dog":
            currentPet = dog
        case "Fish":
            currentPet = fish
        case "Scooby":
            currentPet = scooby
        default:
            currentPet = bird
        }
        //update the display so the pet image and color can be update on the screen
        updateDisplay()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
