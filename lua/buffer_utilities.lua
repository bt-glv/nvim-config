
local commands_per_buffer = {}

-- command_function -> needs to take a buffer number as a parameter
function Commands_add(buffer_name, command_function)
	local for_check = commands_per_buffer[buffer_name]

	if for_check == nil then
		commands_per_buffer[buffer_name] = command_function
		return
	end

	if type(for_check) == "table" then
		table.insert(commands_per_buffer[buffer_name], command_function)
		return
	end

	local aux = commands_per_buffer[buffer_name]
	commands_per_buffer[buffer_name] = {}
	table.insert(commands_per_buffer[buffer_name], aux)
	table.insert(commands_per_buffer[buffer_name], command_function)
end



local function check_and_execute(buffer_number)
	local buffer_name = vim.api.nvim_buf_get_name(buffer_number)
	if commands_per_buffer[buffer_name] == nil then return end

	if type(commands_per_buffer[buffer_name]) == "table" then
		for index, value in ipairs(commands_per_buffer[buffer_name]) do
			value(buffer_number)
		end
		return
	end

	commands_per_buffer[buffer_name](buffer_number)

end

function Buffers_create_autocmds()
	-- TODO: check if BufAdd or BufNewFile is better
	vim.api.nvim_create_autocmd("BufAdd", {
		  callback =	function(args)
			      			check_and_execute(args.buf)
				    	end
				})
end

