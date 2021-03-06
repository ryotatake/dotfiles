# https://lukesilvia.hatenablog.com/entry/20101023/p1
# http://github.com/gmarik/dotfiles/blob/84073cf564b601c99dc4b3b7910bd91234ff94f5/.ruby/lib/gmarik/irb-1.8-history-fix.rb
# http://stackoverflow.com/questions/2065923/irb-history-not-working
require 'irb/ext/save-history'
module IRB
  # use at_exit hook instead finalizer to save history
  # as finalizer is NOT guaranteed to run
  def HistorySavingAbility.extended(obj); 
    Kernel.at_exit{ HistorySavingAbility.create_finalizer.call }
    obj.load_history #TODO: super?
    obj
  end
end if IRB::HistorySavingAbility.respond_to?(:create_finalizer)

# http://rvm.beginrescueend.com/workflow/irbrc/
# for RVM
IRB.conf[:PROMPT_MODE] = :DEFAULT

# ヒストリーを有効にする
IRB.conf[:EVAL_HISTORY] = 1000 
IRB.conf[:SAVE_HISTORY] = 100 
HISTFILE = "~/.irb_history"
MAXHISTSIZE = 100

begin
  if defined? Readline::HISTORY
    histfile = File::expand_path( HISTFILE )
    if File::exists?( histfile )
      lines = IO::readlines( histfile ).collect {|line| line.chomp}
      puts "Read %d saved history commands from %s." %
        [ lines.nitems, histfile ] if $DEBUG || $VERBOSE
      Readline::HISTORY.push( *lines )
    else
      puts "History file '%s' was empty or non-existant." %
        histfile if $DEBUG || $VERBOSE
    end

    Kernel::at_exit {
      lines = Readline::HISTORY.to_a.reverse.uniq.reverse
      lines = lines[ -MAXHISTSIZE, MAXHISTSIZE ] if lines.nitems > MAXHISTSIZE
      $stderr.puts "Saving %d history lines to %s." %

      [ lines.length, histfile ] if $VERBOSE || $DEBUG
      File::open( histfile, File::WRONLY|File::CREAT|File::TRUNC ) {|ofh|
        lines.each {|line| ofh.puts line }
      }
    }
  end
end

# https://github.com/kg8m/dotfiles/blob/master/.irbrc
# Log to STDOUT if in Rails
case
when defined?(Rails) && Rails.respond_to?(:logger=)
  Rails.logger              = Logger.new($stdout)
  ActiveRecord::Base.logger = Rails.logger
  ActiveSupport::Deprecation.behavior = :stderr
when ENV.include?("RAILS_ENV") && !Object.const_defined?("RAILS_DEFAULT_LOGGER")
  require "logger"
  RAILS_DEFAULT_LOGGER = Logger.new($stdout)
end

require 'rubygems'
require 'wirble'
require 'hirb'
# 日本語を使っても表示が崩れないようにする
require 'hirb-unicode'

# TABで補完できるように
Wirble.init
# 出力を色付けする
Wirble.colorize

# レコードを表形式で表示
Hirb.enable
