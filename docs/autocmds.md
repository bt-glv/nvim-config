
- Make a function utility to execute a bunch of commands depending on the buffer name


- IDEA I
	- The file's structure
		local	commands_hash: hashtable 
		public	commands_hash_add: function ($function_to_add)
		public	Check_and_execute: function ($buffer_name, $buffer_number) -> searches for the buffer name; if it finds something, execute all related functions
		local	code block:
				* auto command that executes Check_and_execute on every single buffer given the correct paremeters

	- Add a hash table with a lua array that contains functions to be executed if the input has an entry in the hash table 
	- Add an auto command that calls the Check_and_execute when the buffer is created and gives the required parameters


- NOTES
	- Lua tables are quite special
		- They are a mix of a hash table and an iterative array
		- When searching for values given the key, it uses the language's own optimized hash table algorithm to find the value as fast as possible
