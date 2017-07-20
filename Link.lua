module("Link", package.seeall)

Link = {}
Link.__index = Link
Link.__type = "Link"

--Link.Previous = nil
--Link.Next = nil
--Link.Value = nil
--Link.List = nil

function Link:new(Value)
	
	local self = setmetatable( {}, Link )
	
	self.Value = Value
	
	return self
	
end

function Link:__tostring()
	
	if self.Next then
		
		return tostring(self.Value) .. "," .. tostring(self.Next)
		
	end
	
	return tostring(self.Value)
	
end

function Link:GetNext()
	
	return self.Next
	
end

function Link:GetPrevious()
	
	return self.Previous
	
end

function Link:SetNext(Next)
	
	self.Next = Next
	
end

function Link:SetPrevious(Previous)
	
	self.Previous = Previous
	
end

function Link:SetList(List)
	
	self.List = List
	
end

function Link:GetValue()
	
	return self.Value
	
end

function Link:Remove()
	
	if self.List then
		
		if self.List:_GetFirst() == self then
			
			self.List:_SetFirst( self.Next )
			
		end
		
		if self.List:_GetLast() == self then
			
			self.List:_SetLast( self.Previous )
			
		end
		
		if self.Previous then
			
			self.Previous:SetNext(self.Next)
			
		end
		
		if self.Next then
			
			self.Next:SetPrevious(self.Previous)
			
		end
		
		self.Previous = nil
		self.Next = nil
		self.List = nil
		
	end
	
end

return Link