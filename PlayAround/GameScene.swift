//
//  GameScene.swift
//  PlayAround
//
//  Created by ProjectFine on 8/16/16.
//  Copyright (c) 2016 Michael Redig. All rights reserved.
//

import SpriteKit

var ninjaIdleAction = SKAction()// <------

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
		
		self.backgroundColor = SKColor.init(red: 0.2, green: 0.0, blue: 0.2, alpha: 0.2)

		let ninjaIdleAtlas = SKTextureAtlas(named: "NinjaIdle")// <------
		
		var ninjaIdleArray = [SKTexture]()// <------
		for textureName in ninjaIdleAtlas.textureNames {// <------
			ninjaIdleArray.append(ninjaIdleAtlas.textureNamed(textureName))// <------
		}// <------
		
		ninjaIdleAction = SKAction.animateWithTextures(ninjaIdleArray, timePerFrame: 1.0/12.0)// <------
		ninjaIdleAction = SKAction.repeatActionForever(ninjaIdleAction)// <------
		
		
		let ninja = SKSpriteNode(imageNamed: "Idle_000")
//		ninja.setScale(0.25)
		
		ninja.name = "theNinja"
		
		ninja.runAction(ninjaIdleAction)// <------
		self.addChild(ninja)
		
		
    }
	
#if os(OSX)
    override func mouseDown(theEvent: NSEvent) {
        /* Called when a mouse click occurs */
        
        let location = theEvent.locationInNode(self)
		
		let ninja = self.childNodeWithName("theNinja") // <----
		ninja?.position = location // <-----
		
	
	}
	
	override func mouseDragged(theEvent: NSEvent) {
		let location = theEvent.locationInNode(self)
		
		let ninja = self.childNodeWithName("theNinja") // <----
		ninja?.position = location // <-----
	}
#elseif os(iOS)
	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		
		for touch in touches {
			let location = touch.locationInNode(self)

			let ninja = self.childNodeWithName("theNinja") // <----
			ninja?.position = location // <-----
		}

	
	}
	
	override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
		
		for touch in touches {
			let location = touch.locationInNode(self)
			
			let ninja = self.childNodeWithName("theNinja") // <----
			ninja?.position = location // <-----
		}
		
		
	}
	

#endif

	
	
	
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}










