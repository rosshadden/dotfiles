call MakePrefix('camel', '[prefix]c')

map <silent> [camel]w <Plug>CamelCaseMotion_w
map <silent> [camel]b <Plug>CamelCaseMotion_b
map <silent> [camel]e <Plug>CamelCaseMotion_e

omap <silent> [camel]iw <Plug>CamelCaseMotion_iw
xmap <silent> [camel]iw <Plug>CamelCaseMotion_iw
omap <silent> [camel]ib <Plug>CamelCaseMotion_ib
xmap <silent> [camel]ib <Plug>CamelCaseMotion_ib
omap <silent> [camel]ie <Plug>CamelCaseMotion_ie
xmap <silent> [camel]ie <Plug>CamelCaseMotion_ie
