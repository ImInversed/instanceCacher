local OUT_OF_VIEW_POSITION = Vector3.new(10e9, 0, 0) -- It's still much faster to reposition a part than it is to reparent it
local INVALID_INSTANCE_ERROR = "Returned invalid instance %s"

local function instanceCache(template, parent, cacheSize)
	local inUse = {}
	local cache = {}

	local function _increaseCacheSize(amount)
		for i = 1, amount do
		  local instance = template:Clone()
			instance.Parent = parent

			table.insert(cache, instance)
		end
	end

	_increaseCacheSize(cacheSize)

	local function getInstance()
		if #cache <= 0 then
			_increaseCacheSize(5)
		end

		local instance = table.remove(cache, #cache)

		inUse[instance] = true

		return instance
	end

	local function returnInstance(instance)
		if inUse[instance] ~= nil then
			inUse[instance] = nil -- yes, this still removes it from the table, even if the statement instance == nil is true

			-- the instance was destroyed somehow, don't add it to the cache
			-- this check does not work if the object was manually :Destroy()'d and has not been cleared by the garbage collector
			if instance == nil then
				return
			end

			instance.Position = OUT_OF_VIEW_POSITION
			table.insert(cache, instance)
		else
			print((INVALID_INSTANCE_ERROR):format(instance.Name))
		end
	end

	return getInstance, returnInstance
end

return instanceCache
