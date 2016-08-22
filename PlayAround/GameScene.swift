//
//  GameScene.swift
//  PlayAround
//
//  Created by ProjectFine on 8/16/16.
//  Copyright (c) 2016 Michael Redig. All rights reserved.
//

import SpriteKit


//Setup SKUtilities
let SKUSharedUtilities = SKUtilities2.sharedUtilities();

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
	
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
		
		self.backgroundColor = SKColor.init(red: 0.2, green: 0.0, blue: 0.2, alpha: 0.2)
		
		
		createAnimations()
		
		
		let ninja = SKSpriteNode(imageNamed: "Idle_000")
		ninja.setScale(0.2)
		
		ninja.name = "Stan The Ninja Man"
		ninja.position = CGPoint(x: 300, y: 300)
		
		ninja.runAction(ninjaIdleAction)
		ninja.zPosition = 0.1
		self.addChild(ninja)
		
		
		
		let ogre = SKSpriteNode (imageNamed: "Idle_000")
		ogre.name = "Ralph The Ogre"
		
		

		ogre.runAction(ogreWalkAnimation)
		ogre.setScale(0.25)

		self.addChild(ogre)
		randomizeOgrePosition()
		
    }
	
	
	func randomizeOgrePosition() {
		let ogre = self.childNodeWithName("Ralph The Ogre")
		let ogrex = CGFloat ( arc4random_uniform(UInt32 (self.frame.size.width)))
		let ogrey = CGFloat ( arc4random_uniform(UInt32 (self.frame.size.height)))
		ogre!.position = CGPoint(x: ogrex, y: ogrey)
	}

	
	override func inputBeganSKU(location: CGPoint, withEventDictionary eventDict: [NSObject : AnyObject]!) {
		
		
		let ninja = self.childNodeWithName("Stan The Ninja Man")
		
		let ogre = self.childNodeWithName("Ralph The Ogre")
		
		
		
		let walkAction = SKAction.moveTo(location, duration: 1.5)
		let group = SKAction.group([ninjaWalkAnimation, walkAction])
		let sequence = SKAction.sequence([group, ninjaIdleAction])
		
		
		
		ninja!.runAction(sequence)
		
		
		let distance = hypot(ogre!.position.x - ninja!.position.x, ogre!.position.y - ninja!.position.y)
		
		if distance < 128 {
			let red = SKAction.colorizeWithColor(SKColor.redColor(), colorBlendFactor: 0.75, duration: 0.05)
			let white = SKAction.colorizeWithColor(SKColor.redColor(), colorBlendFactor: 0.0, duration: 0.05)
			let sequence = SKAction.sequence([red, white])
			
			ogre?.runAction(sequence)
		}
		
	}


	
	func createAnimations() {
		
		// idle animation
		let ninjaIdleAtlas = SKTextureAtlas(named: "NinjaIdle")
		var ninjaIdleArray = [SKTexture]()
		for textureName in ninjaIdleAtlas.textureNames.sort() {
			ninjaIdleArray.append(ninjaIdleAtlas.textureNamed(textureName))
		}
		
		
		ninjaIdleAction = SKAction.animateWithTextures(ninjaIdleArray, timePerFrame: 1.0/24.0)
		ninjaIdleAction = SKAction.repeatActionForever(ninjaIdleAction)
	
		
		// Ninja walk animation
		let ninjaWalkAtlas = SKTextureAtlas(named: "NinjaWalk")
		var ninjaWalkArray = [SKTexture]()
		for textureName in ninjaWalkAtlas.textureNames.sort() {
			ninjaWalkArray.append(ninjaWalkAtlas.textureNamed(textureName))
		}
		ninjaWalkAnimation = SKAction.animateWithTextures(ninjaWalkArray, timePerFrame: 1.0/24.0)
		ninjaWalkAnimation = SKAction.repeatActionForever(ninjaWalkAnimation)

		// Ogre walk animation
		let ogreWalkAtlas = SKTextureAtlas(named: "OgreWalk")
		var ogreWalkArray = [SKTexture]()
		for textureName in ogreWalkAtlas.textureNames.sort() {
			ogreWalkArray.append(ogreWalkAtlas.textureNamed(textureName))
		}
		ogreWalkAnimation = SKAction.animateWithTextures(ogreWalkArray, timePerFrame: 1.0/24.0)
		ogreWalkAnimation = SKAction.repeatActionForever(ogreWalkAnimation)
		
	
	
	}
	
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
		SKUSharedUtilities.updateCurrentTime(currentTime);

    }
}










