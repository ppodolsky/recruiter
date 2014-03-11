Page.seed(:slug) do |s|
  s.slug = 'jumbotron'
  s.name = 'Jumbotron'
  s.content = <<-MARKDOWN.strip_heredoc
    # Earn cash by playing games?
    Sign up now to be invited to the latest opportunities!
  MARKDOWN
end

Page.seed(:slug) do |s|
  s.slug = 'footer'
  s.name = 'Footer'
  s.content = <<-MARKDOWN.strip_heredoc
    [Recruiter](https://github.com/jrhorn424/recruiter)
  MARKDOWN
end

Page.seed(:slug) do |s|
  s.slug = 'feature-left'
  s.name = 'Feature Left'
  s.content = <<-MARKDOWN.strip_heredoc
    ## Lorem ipsum
    Dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor
    incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
    quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
    consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
    cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat
    non proident, sunt in culpa qui officia deserunt mollit anim id est
    laborum.
  MARKDOWN
end

Page.seed(:slug) do |s|
  s.slug = 'feature-middle'
  s.name = 'Feature Middle'
  s.content = <<-MARKDOWN.strip_heredoc
    ## Lorem ipsum
    Dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor
    incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
    quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
    consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
    cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat
    non proident, sunt in culpa qui officia deserunt mollit anim id est
    laborum.
  MARKDOWN
end

Page.seed(:slug) do |s|
  s.slug = 'feature-right'
  s.name = 'Feature Right'
  s.content = <<-MARKDOWN.strip_heredoc
    ## Lorem ipsum
    Dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor
    incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
    quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
    consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
    cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat
    non proident, sunt in culpa qui officia deserunt mollit anim id est
    laborum.
  MARKDOWN
end


Page.seed(:slug) do |s|
  s.slug = 'rules'
  s.name = 'Rules'
  s.content = <<-MARKDOWN.strip_heredoc
    Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
    tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
    quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
    consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
    cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
    proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
  MARKDOWN
end

Page.seed(:slug) do |s|
  s.slug = 'privacy'
  s.name = 'Privacy'
  s.content = <<-MARKDOWN.strip_heredoc
    Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
    tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
    quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
    consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
    cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
    proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
  MARKDOWN
end

Page.seed(:slug) do |s|
  s.slug = 'faqs'
  s.name = 'FAQs'
  s.content = <<-MARKDOWN.strip_heredoc
    Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
    tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
    quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
    consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
    cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
    proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
  MARKDOWN
end

Page.seed(:slug) do |s|
  s.slug = 'contact'
  s.name = 'Contact'
  s.content = <<-MARKDOWN.strip_heredoc
    Please contact the experimenter running your session if you have
    questions specific to your participation. If you are having trouble with
    the website, see our [help](/help) page, or contact
    [Jane Smith](mailto:webmaster@example.com). For general questions, contact
    [John Smith](mailto:admin@example.com).
  MARKDOWN
end
