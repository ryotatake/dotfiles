# https://qiita.com/uzimith/items/10152a40a2c941fde88a
# https://qiita.com/na-o-ys/items/5f56fc96a9a07f0f0f08
function fish_notify --on-event fish_prompt
  set _display_status $status
  if test $CMD_DURATION
    set secs (math "$CMD_DURATION / 1000")
    # 5秒以上掛かったら通知する
    if test $secs -ge 5
      if test $SLACK_NOTIFICATION_URL
        set notify "curl -X POST -H 'Content-type: application/json' --data '{\"text\":\"Command: $history[1], took $secs second\"}' $SLACK_NOTIFICATION_URL"
        eval $notify
      end
    end
  end
end
