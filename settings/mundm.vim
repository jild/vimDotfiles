" Overwrite for general.vim
" let MYMAKEFILE = '~/documents/dataAgent/mymakefile' " ~/documents/dataAgent/mymakefile
" make! -f ~/documents/dataAgent/mymakefile | copen
map <F5> :make! -f ~/documents/dataAgent/createMakefile <Return> :make! -f qtmake.mk <Return> :copen<Return>
map <F9> :make! -f ~/documents/dataAgent/createMakefile <Return> :make! -f qtmake.mk <Return> :copen<Return>
map <F10> :cprevious<Return>
map <F11> :cnext<Return>

nnoremap <leader>1 vey:Ack <C-R>" ~/programme/azure-iot-gateway-sdk/azure-iot-gateway-sdk/
