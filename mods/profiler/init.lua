if core.setting_getbool("mod_profiling") then
	error("The builtin profiler is already running. Stop it first by setting mod_profiling = false in your minetest.conf")
end

local modpath = minetest.get_modpath(minetest.get_current_modname())
profiler = {}
dofile(modpath .. "/mod_profiling.lua")
dofile(modpath .. "/profile_printer.lua")

core.register_chatcommand("profile", {
	description = "print profiling data to the log",
	params = "[filter]",
	privs = { server=true },
	func = profiler.print_log,
})
