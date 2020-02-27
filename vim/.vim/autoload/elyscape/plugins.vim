function! elyscape#plugins#ActivatePlugins()
  call plug#begin('~/.vim/bundle')

  for l:plugin in s:plugins
    Plug l:plugin
  endfor

  call plug#end()
endfunction

function! elyscape#plugins#AddPlugin(plugin)
  if index(s:plugins, a:plugin) == -1
    let s:plugins += [a:plugin]
  endif
endfunction

function! elyscape#plugins#ListPlugins()
  return s:plugins
endfunction

function! elyscape#plugins#RemovePlugin(plugin)
  let l:index = index(s:plugins, a:plugin)
  if l:index != -1
    call remove(s:plugins, l:index)
  endif
endfunction

function! elyscape#plugins#Reset()
  let s:plugins =
        \ [
        \   'Vimjas/vim-python-pep8-indent',
        \   'airblade/vim-gitgutter',
        \   'cespare/vim-toml',
        \   'editorconfig/editorconfig-vim',
        \   'ekalinin/Dockerfile.vim',
        \   'elyscape/vim-winjumplist',
        \   'freeo/vim-kalisi',
        \   'godlygeek/tabular',
        \   'gurpreetatwal/vim-avro',
        \   'kchmck/vim-coffee-script',
        \   'mbbill/undotree',
        \   'pangloss/vim-javascript',
        \   'rhysd/clever-f.vim',
        \   'rodjek/vim-puppet',
        \   'scrooloose/nerdcommenter',
        \   'scrooloose/nerdtree',
        \   'tpope/vim-abolish',
        \   'tpope/vim-endwise',
        \   'tpope/vim-fugitive',
        \   'tpope/vim-git',
        \   'tpope/vim-repeat',
        \   'tpope/vim-sensible',
        \   'tpope/vim-surround',
        \   'vim-airline/vim-airline',
        \   'vim-airline/vim-airline-themes',
        \   'vim-python/python-syntax',
        \   'vim-ruby/vim-ruby',
        \   'vim-scripts/matchit.zip',
        \   'vim-scripts/restore_view.vim',
        \ ]
endfunction

if !exists('s:plugins')
  call elyscape#plugins#Reset()
endif
