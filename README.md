# instanceCacher

an object pooler which (mostly) deals with the jankyness of how polytoria manages instances. this should also remain relevant when polytoria eventually updates to Luau

**usage:**

```lua
local getInstance, returnInstance = instanceCache(template, game["Environment"], 100)

local instance = getInstance()
instance.Anchored = false
instance.Position = somewhere

wait(0.1)

instance.Anchored = true -- always make sure it's anchored before returning
returnInstance(instance)
```
