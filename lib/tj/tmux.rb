module Tmux
  module_function def current_pane_id(shell, session)
    current_pane_id = shell.exec("tmux display-message -t #{session} -p '\#{pane_id}'").chomp
  end
end

require_relative './shell'
require_relative './tmux/session'
require_relative './tmux/pane'
