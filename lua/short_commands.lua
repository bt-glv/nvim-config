
function cmd	(vim_cmd_command) 		vim.cmd(vim_cmd_command) 				end
function Get_active_buffer_name() return vim.api.nvim_buf_get_name(0) end
function Get_active_buffer_number() return vim.api.nvim_buf_get_number(0) end


function km		(mode,trigger,command)
	vim.keymap.set(mode,trigger,command) 	
end
function kmn	(trigger,command) 		km("n",trigger,command) 				end
function kmv	(trigger,command) 		km("v",trigger,command) 				end
function kmnv	(trigger,command) 		km({'n','v'},trigger,command) 			end
function km_all	(trigger,command) 		km({'n','v','c','i'},trigger,command) 	end
function kmi	(trigger,command) 		km("i",trigger,command) 				end
function kmc	(trigger,command) 		km("c",trigger,command) 				end
function kmnc	(trigger,command) 		km({'n','c'},trigger,command) 			end


-- Defines buffer only keymaps
function bkm	(buffer_number, mode, trigger, command)
	vim.api.nvim_buf_set_keymap(buffer_number, mode, trigger, command, { noremap = true, silent = true })
end
function bkmn	(buffer_number, trigger, command)
	bkm(buffer_number, "n", trigger, command) 				
end

function bkmv	(buffer_number, trigger, command)
	bkm(buffer_number, "v", trigger, command) 				
end

function bkmnv	(buffer_number, trigger, command)
	bkm(buffer_number, {'n','v'}, trigger, command) 			
end

function bkm_all	(buffer_number, trigger, command)
	bkm(buffer_number, {'n','v','c','i'}, trigger, command) 	
end

function bkmi	(buffer_number, trigger, command)
	bkm(buffer_number, "i", trigger, command) 				
end

function bkmc	(buffer_number, trigger, command)
	bkm(buffer_number, "c", trigger, command) 				
end

function bkmnc	(buffer_number, trigger, command)
	bkm(buffer_number, {'n','c'}, trigger, command) 			
end

