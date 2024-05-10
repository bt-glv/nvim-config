 
function cmd(vim_cmd_command) 		vim.cmd(vim_cmd_command) 		end
function km(mode,trigger,command) 	vim.keymap.set(mode,trigger,command) 	end 
function kmn(trigger,command) 		km("n",trigger,command) 		end
function kmv(trigger,command) 		km("v",trigger,command) 		end
function kmnv(trigger,command) 		km({'n','v'},trigger,command) 		end
function kmi(trigger,command) 		km("i",trigger,command) 		end
function kmc(trigger,command) 		km("c",trigger,command) 		end
