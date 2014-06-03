require_relative 'ircbot'
require_relative 'syaro'

def start
  @bot = IrcBot.new("irc.rizon.net", 6667, 'soranowoto', 'SyaroBot', 'Kirima Syaro', Syaro.new('Syarobot', 'Syaro'))

  trap("INT"){ @bot.quit }

  @bot.run
end

until false
  begin
    start
  rescue Exception => e
    puts e.to_s
    puts e.backtrace
    if(!@bot.nil?)
      @bot.quit
    end
  end
end
