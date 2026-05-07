local ls          = require('luasnip')
local vscode_snip = ls.parser.parse_snippet
local fmt         = require('luasnip.extras.fmt').fmt
local extras      = require('luasnip.extras')
local s           = ls.snippet
local t           = ls.text_node
local i           = ls.insert_node
local f           = ls.function_node
local l           = require("luasnip.extras").l
local rep         = extras.rep

return {

	-- creates nested pure functions
	s('pfunction', fmt([[
		class <1> {
			<3> exec(<4>) {
				<5>
			}
		}; <1> <2> = new <1>();
	]],
	{ i(1), i(2), i(3), i(4), i(5), },
	{delimiters = '<>', repeat_duplicates = true})),

	-- creates a interface
	s("finterface", fmt([[
		interface [] <[rty] []> {
			[rty] apply([]);
		}
	]],
	{rty = i(2), i(1), i(2), i(3)},
	{delimiters = '[]', repeat_duplicates = true})),


	-- creates the template code for a tomcat 10+ servlet
	s("servlet", fmt([[

	import jakarta.servlet.ServletException;
	import jakarta.servlet.annotation.WebServlet;
	import jakarta.servlet.http.HttpServlet;
	import jakarta.servlet.http.HttpServletRequest;
	import jakarta.servlet.http.HttpServletResponse;
	import jakarta.servlet.http.HttpSession;
	import java.io.IOException;
	import java.util.List;

	@WebServlet("/<1>")
	public class <2> extends HttpServlet {
		private static final long serialVersionUID = 1L;

		public <2>() { super(); }

		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			// response.getWriter().append("Served at: ").append(request.getContextPath());
		}

		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			// doGet(request, response);
		}
	}

		]],
		{
			f(function()
				return string.match(vim.fn.expand("%:t"), "[^.]+")
			end),
			f(function()
				local file_name = string.match(vim.fn.expand("%:t"), "[^.]+")
				return string.upper(string.sub(file_name,1,1)) .. string.sub(file_name, 2, #file_name)
			end)
		},
		{delimiters = '<>', repeat_duplicates = true}))
	}

