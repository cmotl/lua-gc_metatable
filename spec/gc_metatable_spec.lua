describe("gc_metatable", function()
    local gc_metatable = require("gc_metatable")

    it("calls the function when the table goes out of scope and garbage is collected", function()
        local t = {}
        local called = false

        local function my_gc()
            called = true
        end

        gc_metatable(t, my_gc)
        assert.is.falsy(called)

        t = nil
        collectgarbage("collect")

        assert.is.truthy(called)
    end)
end)
