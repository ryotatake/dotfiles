function journal
  set journal_path "$HOME/notebooks/journals/"
  vim $journal_path(date "+%Y-%m-%d").md
end
