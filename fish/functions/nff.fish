# A simple shorthand to open a fuzzy finded file in neovim 
function nff 
    set openedFile (fzf -e --preview="bat --color=always {}")
    if test [[ -e $openedFile ]]
        nvim "$openedFile"
        return
    end

    echo "No file was selected."
end
