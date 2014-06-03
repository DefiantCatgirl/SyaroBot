class Syaro


  def initialize(*names)
    @names = names
    @names.map! {|name| name.downcase}

    @possibility = [
        'definitely!', 'it\'s possible.', 'I don\'t think so.', 'absolutely.', 'only if you order some tea.', 'doubtful.',
        'I believe so.', 'depends on whether you\'re caffeine high.', 'probably not.'
    ]

    @serve = ['coming right up!', 'here you go.', 'please enjoy!']

    ['coffee reading', 'tea reading', 'Cocoa-san', 'Chino-san'].each do |type|
      @possibility.push type + ' says yes.'
      @possibility.push type + ' says no.'
      @possibility.push type + ' is being vague about that.'
    end
  end

  def match(user, content)
    begin
    content.downcase!
    result = nil

    @names.each do |name|
      #puts 'name: ' + name
      if content.match(/^#{name}~+[^\w.]*$/)
        if rand(7) == 0
          return 'Hello to you too~'
        else
          return user + '~'
        end
      elsif content.match(/^#{name}[^\w.]*$/)
        return reply(user, 'how can I help you?')
      elsif content.match(/^#{name}[^\w.]*/)
        #puts 'Match: ' + content.match(/^#{name}[^\w.]*(.*)/).to_s
        #puts 'Match 0: ' + content.match(/^#{name}[^\w.]*(.*)/)[0].to_s
        #puts 'Match 1: ' + content.match(/^#{name}[^\w.]*(.*)/)[1].to_s
        result = respond(user, content.match(/^#{name}[^\w.]*(.*)/)[1])
        if result
          return result
        else
          return 'I don\'t do anything useful yet, sorry.'
        end
        #break
      end
    end

    nil

    rescue Exception => e
        puts e.to_s
        puts e.backtrace
        return 'Caffeine high! An exception has occured ;_;'
    end
  end

  def respond(user, content)
    puts content.to_s
    #puts content.match(/\?[^\w.]*$/).to_a.to_s
    if content.nil?
      return nil
    elsif content.match(/chaika/)
      return reply(user, 'please ask ChaikaBot about this.')
    elsif content.match(/\s*(.*)[^\w.]*please[^\w.]*/) && !content.match(/^please/)
      puts content.match(/\s*(.*)[^\w.]*please[^\w.]*/).to_a.to_s
      order = content.match(/\s*(.*)[^\w.]*please[^\w.]*/)[1].to_s
      puts order
      while order[-1,1] != nil && order[-1,1].match(/[^\w.]/)
        order.chop!
      end
      return reply(user, order + ', ' + @serve.sample)
    elsif content.match(/\?[^\w.]*$/)
      return reply(user, @possibility.sample)
    end

    nil
  end

  def reply(user, response)
    return user + ', ' + response
  end

end
