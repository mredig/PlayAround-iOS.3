//
//  GameScene.swift
//  PlayAround
//
//  Created by ProjectFine on 8/16/16.
//  Copyright (c) 2016 Michael Redig. All rights reserved.
//

import SpriteKit


//Setup SKUtilities
let SKUSharedUtilities = SKUtilities2.shared();

#if os(OSX)
	typealias SKUImage = NSImage;
	typealias SKUFont = NSFont;
#else
	typealias SKUImage = UIImage;
	typealias SKUFont = UIFont;
#endif



var ninjaIdleAction = SKAction()
var ninjaWalkAnimation = SKAction()
var ogreWalkAnimation = SKAction()

class GameScene: SKUScene {
	
	var ogreHP = 3;
	
    override func didMove(to view: SKView) {
        /* Setup your scene here */
		
		self.backgroundColor = SKColor.init(red: 0.2, green: 0.0, blue: 0.2, alpha: 0.2)
		
		
		createAnimations()
		
		
		let ninja = SKSpriteNode(imageNamed: "Idle_000")
		ninja.setScale(0.2)
		
		ninja.name = "Stan The Ninja Man"
		ninja.position = CGPoint(x: 300, y: 300)
		
		ninja.run(ninjaIdleAction)
		ninja.zPosition = 0.1
		self.addChild(ninja)
		
		
		
		let ogre = SKSpriteNode (imageNamed: "Idle_000")
		ogre.name = "Ralph The Ogre"
		
		

		ogre.run(ogreWalkAnimation)
		ogre.setScale(0.25)

		self.addChild(ogre)
		randomizeOgrePosition()
		
    }
	
	
	func randomizeOgrePosition() {
		
		let inset = CGFloat(50)
		let halfInset = inset / 2.0
		let ogre = self.childNode(withName: "Ralph The Ogre")
		var ogrex = CGFloat ( arc4random_uniform(UInt32 (self.frame.size.width - inset)))
		var ogrey = CGFloat ( arc4random_uniform(UInt32 (self.frame.size.height - inset)))
		ogrex += halfInset
		ogrey += halfInset
		print("width:", self.frame.size.width, "Height: ", self.frame.size.height)
		ogre!.position = CGPoint(x: ogrex, y: ogrey)
	}


	override func inputBeganSKU(_ location: CGPoint, withEventDictionary eventDict: [AnyHashable : Any]!) {
		let ninja = self.childNode(withName: "Stan The Ninja Man")

		let ogre = self.childNode(withName: "Ralph The Ogre")

		let walkAction = SKAction.move(to: location, duration: 1.5)
		let group = SKAction.group([ninjaWalkAnimation, walkAction])
		let sequence = SKAction.sequence([group, ninjaIdleAction])



		ninja!.run(sequence)


		let distance = hypot(ogre!.position.x - ninja!.position.x, ogre!.position.y - ninja!.position.y)

		if distance < 128 {
			let red = SKAction.colorize(with: SKColor.red, colorBlendFactor: 0.75, duration: 0.05)
			let white = SKAction.colorize(with: SKColor.red, colorBlendFactor: 0.0, duration: 0.05)
			let sequence = SKAction.sequence([red, white])

			ogre?.run(sequence)
		}
	}

	func createAnimations() {
		
		// idle animation
		let ninjaIdleAtlas = SKTextureAtlas(named: "NinjaIdle")
		var ninjaIdleArray = [SKTexture]()
		for textureName in ninjaIdleAtlas.textureNames.sorted() {
			ninjaIdleArray.append(ninjaIdleAtlas.textureNamed(textureName))
		}
		
		
		ninjaIdleAction = SKAction.animate(with: ninjaIdleArray, timePerFrame: 1.0/24.0)
		ninjaIdleAction = SKAction.repeatForever(ninjaIdleAction)
	
		
		// Ninja walk animation
		let ninjaWalkAtlas = SKTextureAtlas(named: "NinjaWalk")
		var ninjaWalkArray = [SKTexture]()
		for textureName in ninjaWalkAtlas.textureNames.sorted() {
			ninjaWalkArray.append(ninjaWalkAtlas.textureNamed(textureName))
		}
		ninjaWalkAnimation = SKAction.animate(with: ninjaWalkArray, timePerFrame: 1.0/24.0)
		ninjaWalkAnimation = SKAction.repeatForever(ninjaWalkAnimation)

		// Ogre walk animation
		let ogreWalkAtlas = SKTextureAtlas(named: "OgreWalk")
		var ogreWalkArray = [SKTexture]()
		for textureName in ogreWalkAtlas.textureNames.sorted() {
			ogreWalkArray.append(ogreWalkAtlas.textureNamed(textureName))
		}
		ogreWalkAnimation = SKAction.animate(with: ogreWalkArray, timePerFrame: 1.0/24.0)
		ogreWalkAnimation = SKAction.repeatForever(ogreWalkAnimation)
		
	
	
	}
	
	override func update(_ currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
		SKUSharedUtilities?.updateCurrentTime(currentTime);

    }
}










