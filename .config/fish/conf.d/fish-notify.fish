# https://qiita.com/uzimith/items/10152a40a2c941fde88a
# https://qiita.com/na-o-ys/items/5f56fc96a9a07f0f0f08
function fish_notify --on-event fish_prompt
  set _display_status $status
  if test $CMD_DURATION
    set secs (math "$CMD_DURATION / 1000")
    # 3秒以上掛かったら通知する
    if test $secs -ge 3
      if which osascript > /dev/null ^&1
        echo "display notification \"Returned $status, took $secs seconds\" with title \"$history[1]\"" | osascript
      else
        echo "LONGRUN COMMAND: $history[1], took $secs secs"
      end
    end
  end
end
