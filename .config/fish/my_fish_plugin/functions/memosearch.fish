if which memo > /dev/null 2>&1
  function memosearch
    if [ ! -z "$argv" ]
      set file (memo grep "$argv" | fzf)
    else
      set file (memo list --fullpath | fzf)
    end

    if [ ! -z "$file" ]
      vim $file
    end
  end
end
