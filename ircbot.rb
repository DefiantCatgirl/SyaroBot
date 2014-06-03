require 'socket'

class IrcBot

  def initialize(server, port, channel, nick, name, bot)
    @nick = nick
    @bot = bot
    @channel = channel
    @server = server
    @port = port
    @name = name
    @socket = TCPSocket.open(server, port)
    say "NICK #{nick}"
    say "USER #{nick} 0 * :#{name}"
    say "JOIN ##{@channel}"
    #say_to_chan "#{1.chr}ACTION is here to help#{1.chr}"
    say_to_chan "Hi there"
  end

  def say(msg)
    puts msg
    @socket.puts msg
  end

  def say_to_chan(msg)
    say "PRIVMSG ##{@channel} :#{msg}"
  end

  def run
    until @socket.eof? do
      msg = @socket.gets
      puts msg

      if msg.match(/^PING :(.*)$/)
        say "PONG #{$~[1]}"
        next
      end

      if msg.match(/:(.*)!.*PRIVMSG ##{@channel} :(.*)$/)
        name = $~[1]
        content = $~[2]

        response = @bot.match(name, content)

        if !response.nil?
          say_to_chan(response)
        end

        ##put matchers here
        #if content.match()
        #  say_to_chan('your response')
        #end
      end
    end
  end

  def quit
    say "PART ##{@channel} :Bye!"
    say 'QUIT'
  end
end
