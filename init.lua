local M = {}

--- @enum LogLevels
M.levels = {
	TRACE = "[TRACE] ",
	INFO = "[INFO] ",
	DEBUG = "[DEBUG] ",
	WARN = "[WARN] ",
	ERROR = "[ERROR] ",
}

--- @class LogOptions
--- @field logfile string Absolute path to logfile

--- @param opts LogOptions
function M.setup(opts)
	M.logfile = opts.logfile
end

local current_log_level = M.levels.INFO
--- @param log_level M.levels
function M.set_log_level(log_level)
	current_log_level = log_level
end

--- @param log_level M.levels Get current log level
function M.get_log_level(log_level)
	return current_log_level
end

local is_first_log = true
function M.log(message)
	if is_first_log then
		M.clear_log()
		is_first_log = false
	end

	local file = io.open(M.logfile, "a")
	local output = current_log_level .. message .. "\n"
	if file then
		file:write(output)
		file:close()
	end
end

function M.clear_log()
	local file = io.open(M.logfile, "w")
	if file then
		file:close()
	end
end

return M
