module("RBNode", package.seeall)

RBNode = {}
RBNode.__index = RBNode
RBNode.__type = "RBNode"

RBNode.Red = true
RBNode.BlackChildren = 0
--RBNode.Left = nil
--RBNode.Right = nil

function RBNode:new(Value)
	
	if Value then
		
		local self = setmetatable( {}, RBNode )
		
		self.Value = Value
		
		return self
		
	end
	
end

function RBNode:__tostring()
	
	if self.Left then
		
		if self.Right then
			
			return tostring(self.Left) .. "," .. tostring(self.Value) .. "," .. tostring(self.Right)
			
		end
		
		return tostring(self.Left) .. "," .. tostring(self.Value)
		
	elseif self.Right then
		
		return tostring(self.Value) .. "," .. tostring(self.Right)
		
	end
	
	return tostring(self.Value)
	
end

function RBNode:SetBlack()
	
	self.Red = false
	
end

function RBNode:SetRed()
	
	self.Red = true
	
end

function RBNode:GetRed()
	
	return self.Red
	
end

function RBNode:GetBlack()
	
	return not self.Red
	
end

function RBNode:GetValue()
	
	return self.Value
	
end

function RBNode:_SetValue(Value)
	
	self.Value = Value
	
end

function RBNode:GetBlackChildren()
	
	return self.BlackChildren
	
end

function RBNode:SetBlackChildren(BlackChildren)
	
	self.BlackChildren = BlackChildren
	
end

function RBNode:GetLeft()
	
	return self.Left
	
end

function RBNode:GetRight()
	
	return self.Right
	
end

function RBNode:SetLeft(Left)
	
	self.Left = Left
	
end

function RBNode:SetRight(Right)
	
	self.Right = Right
	
end

function RBNode:GetParent()
	
	return self.Parent
	
end

function RBNode:SetParent(Parent)
	
	self.Parent = Parent
	
end

function RBNode:SetTree(Tree)
	
	self.Tree = Tree
	
end

function RBNode:GetTree()
	
	return self.Tree
	
end

function RBNode:Remove()
	
	if self.Tree then
		
		self.Tree:RemoveNode(self)
		self.Tree = nil
		
	end
	
end

return RBNode