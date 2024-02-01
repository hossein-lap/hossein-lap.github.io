#!/usr/bin/env lua5.4

-- palette {{{
local themes = {
-- crunchbang {{{
	crunchbang = {
		bg = '#26292A',
		cb = '#181A1B',
		br = '#151617',
		-- br = '#282a36',
		fg = '#bbbbbb',
		hh = '#ffffff',
		cf = '#cccccc',
		h1 = '#ffffff',
		h2 = '#ffffff',
		h3 = '#ffffff',
		h4 = '#ffffff',
		h5 = '#ffffff',
		ln = '#ffffff',
	},
-- }}}
-- dracula {{{
	dracula = {
		bg = '#191A21',
		fg = '#f8f8f2',
		cb = '#21222c',
		cf = '#cccccc',
		hh = '#bd93f9',
		h1 = '#ffb86c',
		h2 = '#ff79c6',
		h3 = '#f1fa8c',
		h4 = '#50fa7b',
		h5 = '#bd93f9',
		ln = '#8be9fd',
		br = '#282a36',
	},
-- }}}
-- ayu dark {{{
	ayu = {
		bg = '#101521',
		fg = '#CBCCC6',
		cb = '#232834',
		cf = '#B3B1AD',
		hh = '#53bdfa',
		h1 = '#fae994',
		h2 = '#f9af4f',
		h3 = '#c2d94c',
		h4 = '#CB9FF8',
		ln = '#90e1c6',
	},
-- }}}
-- onedark {{{
	onedark = {
		bg = '#21252b',
		fg = '#dddddd',
		cb = '#31353f',
		cf = '#abb2bf',
		hh = '#c678dd',
		h1 = '#e5c07b',
		h2 = '#98c379',
		h3 = '#61afef',
		h4 = '#cc9057',
		ln = '#56b6c2',
	}
-- }}}
}
-- }}}

local color = themes.crunchbang -- all but `dracula` are missing `br` color

local elements = {
	spec = {
		fg = {
			'p',
			'body',
			'ul',
			'li',
			'table',
			'h5',
			'h6',
			-- '.highlight',
			'.theheadings',
		},
		bg = {
			'.topbaritem',
			'.topbar',
			'body',
			'.theheadings',
		},
		cb = {
			'.topbaritem:hover',
			'.header',
			'.botbar',
		},
		cf = {
			-- 'code',
			'.theheadings',
		},
		code = {
			'.highlight',
		},
		border = {
			'.topbaritem:hover',
			'.topbaritem',
		},
		ln = {
			'a',
		},
		lnhover = {
			'#nextart:hover',
			'#prevart:hover',
			'a:hover',
		},
		hover = {
			'',
		}
	},
	auto = {
		'h1',
		'h2',
		'h3',
		'h4',
		'h5',
	}
}

function write_color(filename, item, kind, compl)
	for _, value in pairs(item) do
		filename:write(string.format('%s { %s %s; }\n', value, compl, kind))
	end
end

local f = 'theme.css'
local file = io.open(f, 'w')
write_color(file, elements.spec.bg, color.bg, 'background-color:')
write_color(file, elements.spec.fg, color.fg, 'color:')
write_color(file, elements.spec.ln, color.ln, 'color:')
write_color(file, elements.spec.cb, color.cb, 'background-color:')
-- write_color(file, elements.spec.code, color.br, 'background-color:')
write_color(file, elements.spec.cf, color.cf, 'color:')
write_color(file, elements.spec.lnhover, '#000', 'color:')
write_color(file, elements.spec.lnhover, color.ln, 'background-color:')
file:write(string.format('.thetitle { color: %s; }\n', color.hh))
file:write(string.format('.thetitle { background-color: %s; }\n', color.cb))
for _, value in pairs(elements.auto) do
	file:write(string.format('%s { color: %s; }\n', value, color[value]))
end
file:close()
