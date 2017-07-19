module("RBTree", package.seeall)

RBNode = require("RBNode")

RBTree = {}
RBTree.__index = RBTree
RBTree.__type = "RBTree"

RBTree.Size = 0

function RBTree:new()

	local self = setmetatable( {}, RBTree )

	return self

end

function RBTree:__tostring()

	return tostring(self.Root)

end

function RBTree:Insert(Value, ParentNode)

	local ParentNode = ParentNode or self.Root

	if ParentNode then

		local Node = ParentNode

		while Node ~= nil do

			ParentNode = Node

			if Value <= ParentNode:GetValue() then

				Node = ParentNode:GetLeft()

			else

				Node = ParentNode:GetRight()

			end

		end

		local newNode = RBNode:new(Value)

		newNode:SetParent(ParentNode)
		newNode:SetTree(self)

		if Value <= ParentNode:GetValue() then

			ParentNode:SetLeft(newNode)

		else

			ParentNode:SetRight(newNode)

		end

		self:_fixAfterInsertion(newNode)
		self.Size = self.Size + 1

		return newNode

	end

	self.Root = RBNode:new(Value)
	self.Root:SetBlack()

	self.Size = self.Size + 1

	return self.Root

end

function RBTree:RemoveNode(p)

	if p then

		if p:GetLeft() ~= nil and p:GetRight() ~= nil then

			local s = self:_successor(p)

			p:_SetValue(s:GetValue())
			p = s

		end

		local replacement = p:GetLeft() or p:GetRight()

		if replacement ~= nil then

			replacement:SetParent(p:GetParent())

			if p:GetParent() == nil then

				self.Root = replacement

			elseif p == p:GetParent():GetLeft() then

				p:GetParent():SetLeft(replacement)

			else

				p:GetParent():SetRight(replacement)

			end

			p:SetLeft(nil)
			p:SetRight(nil)
			p:SetParent(nil)

			if p:GetBlack() then

				self:_fixAfterDeletion(replacement)

			end

		elseif p:GetParent() == nil then

			self.Root = nil

		else

			if p:GetBlack() then

				self:_fixAfterDeletion(p)

			end

			if p:GetParent() ~= nil then

				if p == p:GetParent():GetLeft() then

					p:GetParent():SetLeft(nil)

				elseif p == p:GetParent():GetRight() then

					p:GetParent():SetRight(nil)

				end

				p:SetParent(nil)

			end

		end

	end

end

function RBTree:Remove(Value)

	self:removeNode(self:Contains(Value))

end

function RBTree:Contains(Value)

	local ParentNode = self.Root
	local Node = ParentNode

	while Node ~= nil do

		ParentNode = Node

		if Value == ParentNode:GetValue() then

			return ParentNode

		elseif Value < ParentNode:GetValue() then

			Node = ParentNode:GetLeft()

		else

			Node = ParentNode:GetRight()

		end

	end

	return false

end

function RBTree:_fixAfterDeletion(x)

	while x ~= self.Root and x and x:GetBlack() do

		if x == x:GetParent():GetLeft() then

			local sib = x:GetParent():GetRight()

			if ( sib and sib:GetRed() ) then

				sib:SetBlack()
				x:GetParent():SetRed()
				self:_rotateLeft(x:GetParent())
				sib = x:GetParent():GetRight()

			end

			if ( not sib:GetLeft() or sib:GetLeft():GetBlack() ) and ( not sib:GetRight() or sib:GetRight():GetBlack() ) then

				sib:SetRed()
				x = x:GetParent()

			else

				if sib:GetRight():GetBlack() then

					sib:GetLeft():SetBlack()
					sib:SetRed()
					self:_rotateRight(sib)
					sib = x:GetParent():GetRight()

				end

				if x:GetParent():GetBlack() then

					sib:SetBlack()

				else

					sib:SetRed()

				end

				x:GetParent():SetBlack()
				sib:GetRight():SetBlack()

				self:_rotateLeft(x:GetParent())
				x = self.Root

			end

		else

			local sib = x:GetParent():GetLeft()

			if ( sib and sib:GetRed() ) then

				sib:SetBlack()
				x:GetParent():SetRed()
				self:_rotateRight(x:GetParent())
				sib = x:GetParent():GetLeft()

			end

			if ( not sib:GetRight() or sib:GetRight():GetBlack() ) and ( not sib:GetLeft() or sib:GetLeft():GetBlack() ) then

				sib:SetRed()
				x = x:GetParent()

			else

				if sib:GetLeft():GetBlack() then

					sib:GetRight():SetBlack()
					sib:SetRed()
					self:_rotateLeft(sib)
					sib = x:GetParent():GetLeft()

				end

				if x:GetParent():GetBlack() then

					sib:SetBlack()

				else

					sib:SetRed()

				end

				x:GetParent():SetBlack()
				sib:GetLeft():SetBlack()
				self:_rotateRight(x:GetParent())
				x = self.Root

			end

		end

	end

	x:SetBlack()

end

function RBTree:_successor(t)

	if t:GetRight() ~= nil then

		local p = t:GetRight()

		while p:GetLeft() ~= nil do

			p = p:GetLeft()

		end

		return p

	else

		local p = t:GetParent()
		local ch = t

		while p ~= nil and ch == p:GetRight() do

			ch = p
			p = p:GetParent()

		end

		return p

	end

end

function RBTree:_rotateLeft(p)

	if p ~= nil then

		local r = p:GetRight()

		p:SetRight(r:GetLeft())

		if r:GetLeft() ~= nil then

			r:GetLeft():SetParent(p)

		end

		r:SetParent(p:GetParent())

		if p:GetParent() == nil then

			self.Root = r

		elseif p:GetParent():GetLeft() == p then

			p:GetParent():SetLeft(r)

		else

			p:GetParent():SetRight(r)

		end

		r:SetLeft(p)
		p:SetParent(r)

	end

end

function RBTree:_rotateRight(p)

	if p ~= nil then

		local l = p:GetLeft()

		p:SetLeft(l:GetRight())

		if l:GetRight() ~= nil then

			l:GetRight():SetParent(p)

		end

		l:SetParent(p:GetParent())

		if p:GetParent() == nil then

			self.Root = l

		elseif p:GetParent():GetRight() == p then

			p:GetParent():SetRight(l)

		else

			p:GetParent():SetLeft(l)

		end

		l:SetRight(p)
		p:SetParent(l)

	end

end

function RBTree:_fixAfterInsertion(x)

	while x ~= nil and x ~= self.Root and x:GetParent():GetRed() do

		if x:GetParent() == x:GetParent():GetParent():GetLeft() then

			local y = x:GetParent():GetParent():GetRight()

			if y and y:GetRed() then

				x:GetParent():SetBlack()
				x:GetParent():GetParent():SetRed()
				y:SetBlack()

				x = x:GetParent():GetParent()

			else

				if x == x:GetParent():GetRight() then

					x = x:GetParent()
					self:_rotateLeft(x)

				end

				x:GetParent():SetBlack()
				x:GetParent():GetParent():SetRed()
				self:_rotateRight(x:GetParent():GetParent())

			end

		else

			local y = x:GetParent():GetParent():GetLeft()

			if y and y:GetRed() then

				x:GetParent():SetBlack()
				x:GetParent():GetParent():SetRed()
				y:SetBlack()

			else

				if x == x:GetParent():GetLeft() then

					x = x:GetParent()
					self:_rotateRight(x)

				end

				x:GetParent():SetBlack()
				x:GetParent():GetParent():SetRed()
				self:_rotateLeft(x:GetParent():GetParent())

			end

		end

	end

	self.Root:SetBlack()

end

return RBTree
