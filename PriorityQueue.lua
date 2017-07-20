module("PriorityQueue", package.seeall)

PriorityQueue = {}
PriorityQueue.__index = PriorityQueue
PriorityQueue.__type = "PriorityQueue"

function PriorityQueue:new()
	
	local self = setmetatable( {}, PriorityQueue )
	
	self.Array = {}
	
	return self
	
end

function PriorityQueue:__tostring()
	
	return table.concat(self.Array, ",")
	
end

function PriorityQueue:Insert(Value)
	-- Binary search the insertion position
	local Left = 1
	local Right = #self.Array + 1
	local Middle = math.floor( ( Left + Right ) * 0.5 )
	
	while Left < Right do
		
		local ArrayValue = self.Array[Middle]
		
		if Value < ArrayValue then
			
			Right = Middle - 1
			
		elseif Value > ArrayValue then
			
			Left = Middle + 1
			
		end
		
		Middle = math.floor( ( Left + Right ) * 0.5 )
		
	end
	
	table.insert(self.Array, Middle, Value)
	
end

function PriorityQueue:Contains(Value)
	
	local Left = 1
	local Right = #self.Array + 1
	local Middle = math.floor( ( Left + Right ) * 0.5 )
	
	while Left < Right do
		
		local ArrayValue = self.Array[Middle]
		
		if ArrayValue == Value then
			
			return Middle
			
		elseif Value < ArrayValue then
			
			Right = Middle - 1
			
		elseif Value > ArrayValue then
			
			Left = Middle + 1
			
		end
		
		Middle = math.floor( ( Left + Right ) * 0.5 )
		
	end
	
	if self.Array[Middle] == Value then
		
		return Middle
		
	end
	
	return false
	
end

function PriorityQueue:Get(Index)
	
	return self.Array[Index]
	
end

function PriorityQueue:GetLength()
	
	return #self.Array
	
end

return PriorityQueue