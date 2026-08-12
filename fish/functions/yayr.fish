# Shorthand to clean yay's caches and removed unused packages
function yayr
    echo "Cleaning yay's caches and removing unused packages."
    yay -Sc --noconfirm
    
    set unused (yay -Qdtq)
    if test $unused
        yay -Rns $unused
        return
    else 
        echo "No unused package was found."
    end 
end
