def rails_prompt
  # This is my base prompt, displaying line number and time
  irb_prompt = '[%01n][%t]'
  def_prompt = '' #[%01n][%t]'
  # Maybe you're only running as `irb` an not `rails console`, so check first
  # if rails is available
  if defined? Rails
    app_env = Rails.env
    if Rails.env.production?
      puts "\n\e[1m\e[41mWARNING: YOU ARE USING RAILS CONSOLE IN PRODUCTION!\n" \
                      "Changing data can cause serious data loss.\n" \
                      "Make sure you know what you're doing.\e[0m\e[22m\n\n"
                                                                    app_env = "\e[31m#{app_env}\e[0m" # red
    else
      app_env = "\e[32m#{app_env}\e[0m" # green
    end
    def_prompt << "(\e[1m#{app_env}\e[22m)" # bold
    irb_prompt << def_prompt
  end

  if defined? Pry
    pry_prompt = proc do |context, nesting, pry_instance, sep|
      format(
        '[%<in_count>s] %<name>s(%<context>s)%<def_prompt>s%<nesting>s%<separator>s ',
        in_count: pry_instance.input_ring.count,
        name: pry_instance.config.prompt_name,
        context: Pry.view_clip(context),
        def_prompt: def_prompt,
        nesting: (nesting > 0 ? ":#{nesting}" : ''),
        separator: sep
      )
    end
    Pry::Prompt.add(:default_with_env, 'The same default, but with environment') do
      |context, nesting, pry_instance, sep|
      pry_prompt.call(context, nesting, pry_instance, sep)
    end
    Pry.config.prompt = Pry::Prompt[:default_with_env][:value]
  end
  IRB.conf[:PROMPT] ||= {}
  IRB.conf[:PROMPT][:WITH_ENV] = {
    PROMPT_I: "#{irb_prompt}> ",
    PROMPT_N: "#{irb_prompt}| ",
    PROMPT_C: "#{irb_prompt}| ",
    PROMPT_S: "#{irb_prompt}%l ",
    RETURN: "=> %s\n",
    AUTO_INDENT: true,
  }
  IRB.conf[:PROMPT_MODE] = :WITH_ENV
end

rails_prompt
