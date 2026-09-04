# A shorthand for opening a fuzzy finded PDF or EPUB in zathura
function zff 
    set openedFile (fzf -i --query ".pdf\$ | .epub\$")
    if test [[ -e $openedFile ]]
        zathura "$openedFile"
        return
    end

    echo "No file was selected."
end
