# コマンド終了時に通知します。
# Usage: $ notify COMMAND
function notify
  set execute_command $argv
  eval $execute_command

  set escaped_execute_command (string replace --all '"' '\"' (string escape $execute_command))
  set notify_command (string escape "display notification \"$escaped_execute_command\" with title \"Command Finished!\"")

  switch (uname)
    case Linux
      # ~/.ssh/config でmainという名前でsshできるように設定しておく。
      ssh -t main "osascript -e $notify_command"
    case Darwin
      eval "osascript -e $notify_command"
    case '*'
      echo "notifyコマンドがこのOSに対応していないため通知を送れません。"
  end
end
