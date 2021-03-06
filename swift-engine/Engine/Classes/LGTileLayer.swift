//
//  LGTileLayer.swift
//  swift-engine
//
//  Created by Luke Godfrey on 6/21/14.
//  Copyright (c) 2014 Luke Godfrey. See LICENSE.
//

public class LGTileLayer: LGSystem
{
	var opacity		= 1.0
	var renderLayer	= 0
	
	var isVisible	= true
	var isCollision	= false
	
	var tileWidth: Int
	var tileHeight: Int
	
	var data		= [[LGTile]]()
	
	public init(tileWidth: Int, tileHeight: Int)
	{
		self.tileWidth	= tileWidth
		self.tileHeight	= tileHeight
	}
	
	public func tileAt(#row: Int, col: Int) -> LGTile?
	{
		if row >= 0 && row < data.count && col >= 0 && col < data[row].count
		{
			return data[row][col]
		}
		return nil
	}
	
	
	public func collisionTypeAt(#row: Int, col: Int) -> CollisionType
	{
		if isCollision
		{
			if let tile = tileAt(row: row, col: col)
			{
				return CollisionType(rawValue: tile.pos) ?? .Collision
			}
		}
		
		return .Collision
	}
	
	// Deprecated -- use collisionTypeAt(row: col:) instead
	public func collidesAt(#row: Int, col: Int) -> Bool
	{
		if isCollision
		{
			if let tile = tileAt(row: row, col: col)
			{
				return tile.pos != 0
			}
		}
		return true
	}
	
	public func visibleAt(#row: Int, col: Int) -> Bool
	{
		if isVisible
		{
			if let tile = tileAt(row: row, col: col)
			{
				return tile.pos != 0
			}
		}
		return false
	}
	
	public enum CollisionType: Int
	{
		case None = 0, Collision, OnlyCollidesOnTop
	}
}
