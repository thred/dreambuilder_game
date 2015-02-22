# Minetest mod profiler (profiler)
Measure and analyze performance of mods.

## mod_profiling
The current profiler is based on the builtin provided profiler but extends it.

* don't account profiler performance to the builtin mod anymore
* run when the mod is loaded instead of requiring additional configuration
* correctly calculate average values
* don't update zero measurements leading to division by zero issues

Use `/profile [filter]` to print out runtime statistics, optionally filtered to a specific mod, to `stdout` and `debug.txt`.
