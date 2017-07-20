module("LinkedList", package.seeall)

Link = require("Link")

LinkedList = {}
LinkedList.__index = LinkedList
LinkedList.__type = "LinkedList"

--LinkedList.First = nil
--LinkedList.Last = nil

function LinkedList:new()
	
	local self = setmetatable( {}, LinkedList )
	
	return self
	
end

function LinkedList:__tostring()
	
	return tostring(self.First)
	
end

function LinkedList:Insert(Value)
	
	if self.Last then
		
		local newLink = Link:new(Value)
		
		newLink:SetList(self)
		newLink:SetPrevious(self.Last)
		
		self.Last:SetNext(newLink)
		self.Last = newLink
		
		return self.Last
		
	end
	
	self.First = Link:new(Value)
	self.Last = self.First
	
end

function LinkedList:Contains(Value)
	
	local Link = self.First
	
	while Link do
		
		if Link:GetValue() == Value then
			
			return Link
			
		end
		
		Link = Link:GetNext()
		
	end
	
	return false
	
end

function LinkedList:Get(Index)
	
	local Link = self.First
	local i = 1
	
	while i < Index and Link do
		
		Link = Link:GetNext()
		i = i + 1
		
	end
	
	if i ~= Index then
		
		return nil
		
	end
	
	return Link:GetValue()
	
end

function LinkedList:Remove(Index)
	
	local Link = self.First
	local i = 1
	
	while i < Index and Link do
		
		Link = Link:GetNext()
		i = i + 1
		
	end
	
	if i ~= Index then
		
		return nil
		
	end
	
	return Link:Remove()
	
end

function LinkedList:_GetFirst()
	
	return self.First
	
end

function LinkedList:_SetFirst(First)
	
	self.First = First
	
end

function LinkedList:_GetLast()
	
	return self.Last
	
end

function LinkedList:_SetLast(Last)
	
	self.Last = Last
	
end

return LinkedList