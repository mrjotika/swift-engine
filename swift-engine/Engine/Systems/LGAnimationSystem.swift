//
//  LGAnimationSystem.swift
//  swift-engine
//
//  Created by Luke Godfrey on 8/8/14.
//  Copyright (c) 2014 Luke Godfrey. See LICENSE.
//

final class LGAnimationSystem: LGSystem
{
	var sprites		= [LGSprite]()
	var animatables	= [LGAnimatable]()
	var animations	= [LGAnimation?]()
	
	override func accepts(entity: LGEntity) -> Bool
	{
		return entity.has(LGSprite) && entity.has(LGAnimatable)
	}
	
	override func add(entity: LGEntity)
	{
		super.add(entity)
		
		let sprite		= entity.get(LGSprite)!
		let animatable	= entity.get(LGAnimatable)!
		
		sprites.append(sprite)
		animatables.append(animatable)
		animations.append(animatable.currentAnimation)
	}
	
	override func remove(index: Int)
	{
		super.remove(index)
		
		sprites.removeAtIndex(index)
		animatables.removeAtIndex(index)
		animations.removeAtIndex(index)
	}
	
	override func update()
	{
		for id in 0 ..< entities.count
		{
			let sprite		= sprites[id]
			let animatable	= animatables[id]
			
			if let animation = animatable.currentAnimation
			{
				if animations[id] == nil || animations[id]! != animation
				{
					animations[id] = animation
					sprite.frame = animation.start
					animatable.counter = 0
				}
				
				if ++animatable.counter > animation.ticksPerFrame
				{
					animatable.counter = 0
					
					if ++sprite.frame > animation.end
					{
						if animation.loops
						{
							sprite.frame = animation.start
						}
						else
						{
							sprite.frame = animation.end
						}
					}
				}
			}
		}
	}
}