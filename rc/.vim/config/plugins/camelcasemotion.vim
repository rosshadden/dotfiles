call MakePrefix('camel', '[prefix]C')

map <silent> [camel]w <plug>CamelCaseMotion_w
map <silent> [camel]b <plug>CamelCaseMotion_b
map <silent> [camel]e <plug>CamelCaseMotion_e

omap <silent> [camel]iw <plug>CamelCaseMotion_iw
xmap <silent> [camel]iw <plug>CamelCaseMotion_iw
omap <silent> [camel]ib <plug>CamelCaseMotion_ib
xmap <silent> [camel]ib <plug>CamelCaseMotion_ib
omap <silent> [camel]ie <plug>CamelCaseMotion_ie
xmap <silent> [camel]ie <plug>CamelCaseMotion_ie
