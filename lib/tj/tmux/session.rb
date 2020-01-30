require_relative '../shell'
require_relative './pane'

module Tmux
  class Session
    attr_reader :shell, :session_name, :current_pane
    def initialize(session_name, window_name, shell=TerminalShell.new)
      @session_name = session_name
      @window_name = window_name
      @shell = shell
    end

    def exec(&block)
      instance_eval(&block)
    end
    
    def has_session?
      res = shell.exec("tmux has-session -t #{session_name} 2>/dev/null; echo $?")
      res.to_i.zero?
    end

    def has_pane?(name)
      all_panes.map(&:title).include?(name)
    end

    def start_session
      shell.exec("tmux new-session -s #{session_name} -n #{window_name} -d")

      current_pane_id = Tmux.current_pane_id(shell, window_name)
      @current_pane = Tmux::Pane.new(window_name, '0', current_pane_id, true, shell)
    end

    def await_signal(name)
      shell.exec("tmux wait-for #{name}")
    end

    def current_pane
      @current_pane ||= all_panes.find(&:active?)
    end

    def current_pane=(other)
      @current_pane = other
    end

    def all_panes
      results = shell.exec("tmux list-panes -s -F'#P:\#{pane_id}:\#{pane_active}:#T' -t #{session_name}")
      results.lines.map do |line|
        index, pane_id, active, title = line.chomp.split(':')
        is_active_pane = active == '1'
        Tmux::Pane.new(window_name, title, pane_id, is_active_pane, shell)
      end
    end

    def find_pane(title)
      all_panes.find {|pane| pane.title == title }
    end

    def window_name
      "#{session_name}:#{@window_name}"
    end
  end
end
